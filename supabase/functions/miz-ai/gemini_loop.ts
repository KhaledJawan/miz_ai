import {
  continueInteraction,
  createInteraction,
  finalText,
  functionCallSteps,
  type FunctionResultInput,
  type GeminiFunctionDeclaration,
} from "./gemini_client.ts";
import { mizAiError } from "./errors.ts";
import { LOCATION_REQUIRED_SIGNAL } from "./system_instruction.ts";
import { dispatchTool, TOOL_ALLOWLIST } from "./tools.ts";
import type { NormalizedPlace, ToolExecutionContext, ToolExecutionRecord } from "./types.ts";

export const MAX_TOOL_ROUNDS = 3;

export interface GeminiLoopResult {
  message: string;
  places: NormalizedPlace[];
  toolExecutions: ToolExecutionRecord[];
  requiresLocation: boolean;
  inputTokens: number | null;
  outputTokens: number | null;
}

const LOCATION_TOOL_ALIASES = new Set([
  "get_user_location",
  "request_location",
  "access_gps",
  "get_current_position",
]);

/**
 * Runs the send -> inspect -> (validate+execute tools) -> continue loop,
 * bounded to MAX_TOOL_ROUNDS. Gemini only ever *proposes* a function call
 * (name + arguments); every call here is validated and executed by
 * `dispatchTool`, never by Gemini or by evaluating anything it returned.
 */
export async function runGeminiLoop(params: {
  apiKey: string;
  model: string;
  input: string;
  systemInstruction: string;
  tools: GeminiFunctionDeclaration[];
  context: ToolExecutionContext;
  retryInput?: string;
}): Promise<GeminiLoopResult> {
  const toolExecutions: ToolExecutionRecord[] = [];
  const places: NormalizedPlace[] = [];
  let completedPlaceSearch = false;

  let response = await createInteraction({
    apiKey: params.apiKey,
    model: params.model,
    input: params.input,
    systemInstruction: params.systemInstruction,
    tools: params.tools,
    deadlineMs: params.context.deadlineMs,
    requestId: params.context.requestId,
    retryInput: params.retryInput,
  });
  let inputTokens = response.usage?.total_input_tokens ?? null;
  let outputTokens = response.usage?.total_output_tokens ?? null;

  // Rounds 0..MAX_TOOL_ROUNDS-1 may dispatch tools and continue the
  // interaction; the loop runs one extra iteration (round ==
  // MAX_TOOL_ROUNDS) purely to re-check the last continuation's response
  // — if the model still wants more tools at that point, the budget is
  // truly exhausted and we return a controlled error instead of a 4th
  // round-trip.
  for (let round = 0; round <= MAX_TOOL_ROUNDS; round++) {
    const calls = functionCallSteps(response);
    if (calls.length === 0) {
      const text = finalText(response);
      if (text === LOCATION_REQUIRED_SIGNAL) {
        return {
          message: "",
          places,
          toolExecutions,
          requiresLocation: true,
          inputTokens,
          outputTokens,
        };
      }
      if (completedPlaceSearch && places.length === 0) {
        throw mizAiError("NO_RESULTS", "validated place search returned no results");
      }
      if (text === null && places.length === 0) {
        throw mizAiError("AI_UNAVAILABLE", "Gemini returned neither text nor tool calls");
      }
      return {
        // Real-place UI is rendered from validated typed cards. Model prose
        // can embellish provider data with unsupported claims, so never send
        // free-form narration alongside place results.
        message: places.length > 0 ? "" : text ?? "",
        places,
        toolExecutions,
        requiresLocation: false,
        inputTokens,
        outputTokens,
      };
    }
    if (round === MAX_TOOL_ROUNDS) {
      throw mizAiError("TOOL_LOOP_LIMIT", `Exceeded ${MAX_TOOL_ROUNDS} tool-call rounds`);
    }

    const functionResults: FunctionResultInput[] = [];
    for (const call of calls) {
      if (
        LOCATION_TOOL_ALIASES.has(call.name) &&
        params.context.location === null &&
        params.context.selectedCity === null
      ) {
        toolExecutions.push({ name: "unsupported_location_tool", status: "error" });
        return {
          message: "",
          places,
          toolExecutions,
          requiresLocation: true,
          inputTokens,
          outputTokens,
        };
      }

      const dispatch = await dispatchTool(call.name, call.arguments, params.context);
      toolExecutions.push({
        name: TOOL_ALLOWLIST.has(call.name) ? call.name : "unknown",
        status: dispatch.status,
      });

      if (dispatch.status === "error" && dispatch.result.errorType === "LOCATION_REQUIRED") {
        // Structurally short-circuit: no point spending another round-trip
        // asking Gemini to narrate a missing location — Flutter already
        // has a dedicated UI flow for this (see spec's "Location flow").
        return {
          message: "",
          places,
          toolExecutions,
          requiresLocation: true,
          inputTokens,
          outputTokens,
        };
      }

      if (call.name === "search_nearby_places" && dispatch.status === "success") {
        completedPlaceSearch = true;
        const found = (dispatch.result as { places?: NormalizedPlace[] }).places;
        if (Array.isArray(found)) places.push(...found);
      }

      functionResults.push({
        type: "function_result",
        name: call.name,
        call_id: call.id,
        result: [{ type: "text", text: JSON.stringify(dispatch.result) }],
      });
    }

    try {
      response = await continueInteraction({
        apiKey: params.apiKey,
        model: params.model,
        previousInteractionId: response.id,
        functionResults,
        tools: params.tools,
        deadlineMs: params.context.deadlineMs,
        requestId: params.context.requestId,
      });
      if (response.usage?.total_input_tokens !== undefined) {
        inputTokens = (inputTokens ?? 0) + response.usage.total_input_tokens;
      }
      if (response.usage?.total_output_tokens !== undefined) {
        outputTokens = (outputTokens ?? 0) + response.usage.total_output_tokens;
      }
    } catch (error) {
      // Real Places data is still useful even if Gemini fails to narrate it.
      // Preserve partial success instead of discarding validated results.
      if (places.length > 0) {
        return {
          message: "",
          places,
          toolExecutions,
          requiresLocation: false,
          inputTokens,
          outputTokens,
        };
      }
      throw error;
    }
  }

  // Unreachable: every loop iteration above returns or throws before
  // falling through to `round++`. Kept only so TypeScript's control-flow
  // analysis sees a guaranteed return on every path.
  throw mizAiError("SERVER_ERROR", "gemini loop exited without a result");
}
