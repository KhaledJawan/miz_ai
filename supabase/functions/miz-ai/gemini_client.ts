import { mizAiError } from "./errors.ts";
import { logEvent } from "./observability.ts";

const INTERACTIONS_URL = "https://generativelanguage.googleapis.com/v1beta/interactions";
export const GEMINI_ATTEMPT_TIMEOUT_MS = 35000;
export const GEMINI_MAX_ATTEMPTS = 2;
export const MAX_OUTPUT_TOKENS = 1024;

export interface GeminiFunctionDeclaration {
  type: "function";
  name: string;
  description: string;
  parameters: Record<string, unknown>;
}

export interface GeminiModelOutputStep {
  type: "model_output";
  content: Array<{ type: "text"; text: string }>;
}

export interface GeminiFunctionCallStep {
  type: "function_call";
  id: string;
  name: string;
  arguments: unknown;
}

export type GeminiStep = GeminiModelOutputStep | GeminiFunctionCallStep;

export interface GeminiInteractionResponse {
  id: string;
  status: string;
  steps: unknown[];
  usage?: { total_input_tokens?: number; total_output_tokens?: number };
}

export interface FunctionResultInput {
  type: "function_result";
  name: string;
  call_id: string;
  result: Array<{ type: "text"; text: string }>;
}

function isPlainObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function isFunctionCallStep(step: unknown): step is GeminiFunctionCallStep {
  return isPlainObject(step) && step.type === "function_call" &&
    typeof step.id === "string" && step.id.length > 0 &&
    typeof step.name === "string" && step.name.length > 0;
}

function isModelOutputStep(step: unknown): step is GeminiModelOutputStep {
  if (!isPlainObject(step) || step.type !== "model_output" || !Array.isArray(step.content)) {
    return false;
  }
  return step.content.every((block) =>
    isPlainObject(block) && block.type === "text" && typeof block.text === "string"
  );
}

export function functionCallSteps(response: GeminiInteractionResponse): GeminiFunctionCallStep[] {
  return response.steps.filter(isFunctionCallStep);
}

export function finalText(response: GeminiInteractionResponse): string | null {
  const outputSteps = response.steps.filter(isModelOutputStep);
  if (outputSteps.length === 0) return null;
  const last = outputSteps[outputSteps.length - 1];
  return last.content.map((block) => block.text).join("").trim() || null;
}

function parseInteractionResponse(raw: unknown): GeminiInteractionResponse {
  if (
    !isPlainObject(raw) || typeof raw.id !== "string" || raw.id.length === 0 ||
    typeof raw.status !== "string" || !Array.isArray(raw.steps)
  ) {
    throw mizAiError("AI_UNAVAILABLE", "Gemini returned an invalid interaction envelope");
  }
  if (["failed", "cancelled", "budget_exceeded"].includes(raw.status)) {
    throw mizAiError("AI_UNAVAILABLE", `Gemini interaction status: ${raw.status}`);
  }
  return {
    id: raw.id,
    status: raw.status,
    steps: raw.steps,
    usage: isPlainObject(raw.usage)
      ? {
        total_input_tokens: typeof raw.usage.total_input_tokens === "number"
          ? raw.usage.total_input_tokens
          : undefined,
        total_output_tokens: typeof raw.usage.total_output_tokens === "number"
          ? raw.usage.total_output_tokens
          : undefined,
      }
      : undefined,
  };
}

interface InteractionCallOptions {
  deadlineMs: number;
  requestId: string;
  retryBody?: Record<string, unknown>;
  attemptTimeoutMs?: number;
}

async function callInteractionsApi(
  apiKey: string,
  body: Record<string, unknown>,
  options: InteractionCallOptions,
): Promise<GeminiInteractionResponse> {
  for (let attempt = 1; attempt <= GEMINI_MAX_ATTEMPTS; attempt++) {
    const remainingMs = options.deadlineMs - Date.now();
    if (remainingMs <= 0) throw mizAiError("AI_TIMEOUT", "total request deadline reached");

    const controller = new AbortController();
    const timeoutMs = Math.max(
      1,
      Math.min(options.attemptTimeoutMs ?? GEMINI_ATTEMPT_TIMEOUT_MS, remainingMs),
    );
    const timeout = setTimeout(() => controller.abort(), timeoutMs);
    const startedAt = Date.now();
    let response: Response;
    try {
      response = await fetch(INTERACTIONS_URL, {
        method: "POST",
        headers: { "x-goog-api-key": apiKey, "Content-Type": "application/json" },
        body: JSON.stringify(attempt === 1 ? body : options.retryBody ?? body),
        signal: controller.signal,
      });
    } catch (error) {
      const timedOut = error instanceof DOMException && error.name === "AbortError";
      logEvent(options.requestId, "gemini_attempt", {
        attempt,
        success: false,
        errorCode: timedOut ? "AI_TIMEOUT" : "AI_UNAVAILABLE",
        durationMs: Date.now() - startedAt,
      });
      if (attempt < GEMINI_MAX_ATTEMPTS && options.deadlineMs > Date.now()) continue;
      throw mizAiError(
        timedOut ? "AI_TIMEOUT" : "AI_UNAVAILABLE",
        timedOut ? "Gemini request timed out" : "Gemini network request failed",
      );
    } finally {
      clearTimeout(timeout);
    }

    if (response.status === 401 || response.status === 403) {
      throw mizAiError("AI_CONFIGURATION_ERROR", `Gemini auth error: ${response.status}`);
    }
    if (response.status === 429) {
      throw mizAiError("AI_RATE_LIMIT", "Gemini rate limit reached");
    }
    if (response.status >= 500) {
      logEvent(options.requestId, "gemini_attempt", {
        attempt,
        success: false,
        errorCode: "AI_UNAVAILABLE",
        durationMs: Date.now() - startedAt,
      });
      if (attempt < GEMINI_MAX_ATTEMPTS && options.deadlineMs > Date.now()) continue;
      throw mizAiError("AI_UNAVAILABLE", `Gemini temporary error: ${response.status}`);
    }
    if (!response.ok) {
      throw mizAiError("AI_UNAVAILABLE", `Gemini rejected request: ${response.status}`);
    }

    const raw = await response.json().catch(() => null);
    const parsed = parseInteractionResponse(raw);
    logEvent(options.requestId, "gemini_attempt", {
      attempt,
      success: true,
      durationMs: Date.now() - startedAt,
    });
    return parsed;
  }
  throw mizAiError("AI_UNAVAILABLE", "Gemini attempt loop exited unexpectedly");
}

export interface CreateInteractionParams {
  apiKey: string;
  model: string;
  input: string;
  systemInstruction: string;
  tools: GeminiFunctionDeclaration[];
  deadlineMs: number;
  requestId: string;
  retryInput?: string;
  attemptTimeoutMs?: number;
}

export function createInteraction(
  params: CreateInteractionParams,
): Promise<GeminiInteractionResponse> {
  const body = {
    model: params.model,
    input: params.input,
    system_instruction: params.systemInstruction,
    tools: params.tools,
    store: true,
    generation_config: { max_output_tokens: MAX_OUTPUT_TOKENS, tool_choice: "auto" },
  };
  return callInteractionsApi(params.apiKey, body, {
    deadlineMs: params.deadlineMs,
    requestId: params.requestId,
    attemptTimeoutMs: params.attemptTimeoutMs,
    retryBody: params.retryInput === undefined ? undefined : { ...body, input: params.retryInput },
  });
}

export interface ContinueInteractionParams {
  apiKey: string;
  model: string;
  previousInteractionId: string;
  functionResults: FunctionResultInput[];
  tools: GeminiFunctionDeclaration[];
  deadlineMs: number;
  requestId: string;
  attemptTimeoutMs?: number;
}

export function continueInteraction(
  params: ContinueInteractionParams,
): Promise<GeminiInteractionResponse> {
  const body = {
    model: params.model,
    previous_interaction_id: params.previousInteractionId,
    input: params.functionResults,
    tools: params.tools,
    store: true,
    generation_config: { max_output_tokens: MAX_OUTPUT_TOKENS, tool_choice: "auto" },
  };
  return callInteractionsApi(params.apiKey, body, {
    deadlineMs: params.deadlineMs,
    requestId: params.requestId,
    attemptTimeoutMs: params.attemptTimeoutMs,
  });
}
