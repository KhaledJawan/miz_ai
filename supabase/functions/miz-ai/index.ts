import { createClient } from "npm:@supabase/supabase-js@2";
import { CORS_HEADERS } from "../_shared/cors.ts";
import { requireValidClientKey } from "./client_auth.ts";
import { mizAiError, toSafeResponse } from "./errors.ts";
import { sanitizeFoodProfileContext } from "./food_profile.ts";
import { runGeminiLoop } from "./gemini_loop.ts";
import { MAX_MESSAGE_LENGTH, parseMizAiRequest } from "./request_schema.ts";
import { logEvent } from "./observability.ts";
import {
  buildMenuFollowUpSystemInstruction,
  buildSystemInstruction,
} from "./system_instruction.ts";
import { TOOL_DECLARATIONS } from "./tools.ts";
import type { MizAiResponse, ToolExecutionContext } from "./types.ts";

const MAX_BODY_BYTES = 32 * 1024; // 32KB — generous for a chat message + bounded history
const DEFAULT_MODEL = "gemini-3.6-flash";
export const TOTAL_REQUEST_BUDGET_MS = 58000;

async function resolveUserId(req: Request): Promise<string | null> {
  const authHeader = req.headers.get("Authorization");
  if (!authHeader?.startsWith("Bearer ")) return null;

  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
  if (!supabaseUrl || !anonKey) return null;

  try {
    const client = createClient(supabaseUrl, anonKey, {
      global: { headers: { Authorization: authHeader } },
    });
    const { data, error } = await client.auth.getUser();
    if (error || !data.user) return null;
    return data.user.id;
  } catch (_error) {
    // Never let identity resolution fail the whole request — an invalid
    // or expired token simply falls back to guest.
    return null;
  }
}

async function readBody(req: Request): Promise<unknown> {
  const contentLength = req.headers.get("content-length");
  if (contentLength && Number(contentLength) > MAX_BODY_BYTES) {
    throw mizAiError("INVALID_REQUEST", "request body too large");
  }
  const text = await req.text();
  if (text.length > MAX_BODY_BYTES) {
    throw mizAiError("INVALID_REQUEST", "request body too large");
  }
  try {
    return JSON.parse(text);
  } catch (_error) {
    throw mizAiError("INVALID_REQUEST", "request body is not valid JSON");
  }
}

function buildInputWithHistory(message: string, history: { role: string; text: string }[]): string {
  if (history.length === 0) return message;
  const transcript = history
    .map((turn) => `${turn.role === "user" ? "User" : "Miz"}: ${turn.text}`)
    .join("\n");
  return `Conversation so far:\n${transcript}\n\nUser: ${message}`;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: CORS_HEADERS });
  }
  if (req.method !== "POST") {
    const { body, status } = toSafeResponse(mizAiError("INVALID_REQUEST", "method not allowed"));
    return Response.json(body, { status, headers: CORS_HEADERS });
  }

  const requestId = crypto.randomUUID();
  const startedAt = Date.now();
  const responseHeaders = { ...CORS_HEADERS, "X-Request-Id": requestId };
  try {
    requireValidClientKey(req);
    const geminiApiKey = Deno.env.get("GEMINI_API_KEY");
    if (!geminiApiKey) {
      throw mizAiError("AI_CONFIGURATION_ERROR", "GEMINI_API_KEY is not configured");
    }
    const model = Deno.env.get("GEMINI_MODEL")?.trim() || DEFAULT_MODEL;
    logEvent(requestId, "request_started", { model });

    const rawBody = await readBody(req);
    const request = parseMizAiRequest(rawBody);
    const userId = await resolveUserId(req);

    const context: ToolExecutionContext = {
      location: request.location,
      selectedCity: request.selectedCity,
      foodProfileContext: sanitizeFoodProfileContext(request.foodProfileContext),
      locale: request.locale,
      userId,
      deadlineMs: startedAt + TOTAL_REQUEST_BUDGET_MS,
      requestId,
    };

    // No keyword-matching here to decide whether location is needed —
    // Gemini itself decides whether to call search_nearby_places. If it
    // does and neither `request.location` nor `request.selectedCity` was
    // supplied, the tool call fails fast with LOCATION_REQUIRED and the
    // loop short-circuits into `requiresLocation: true` below.
    // Stage 4 (Menu Assistant follow-up): a distinct, minimal prompt and no
    // tools at all — the dish data was already deterministically computed
    // by analyze-menu's Stage 2, so this agent only explains it, never
    // re-derives or contradicts it. History is already capped tighter by
    // request_schema.ts for this path.
    const isMenuFollowUp = request.menuContext !== null;
    const loopResult = await runGeminiLoop({
      apiKey: geminiApiKey,
      model,
      input: buildInputWithHistory(request.message.slice(0, MAX_MESSAGE_LENGTH), request.history),
      systemInstruction: isMenuFollowUp
        ? buildMenuFollowUpSystemInstruction(request.locale, request.menuContext!)
        : buildSystemInstruction(
          request.locale,
          request.location !== null || request.selectedCity !== null,
        ),
      tools: isMenuFollowUp ? [] : TOOL_DECLARATIONS,
      context,
      // A single retry uses only the current bounded message rather than
      // resending conversation history.
      retryInput: request.message.slice(0, MAX_MESSAGE_LENGTH),
    });

    const response: MizAiResponse = {
      message: loopResult.message,
      conversationId: request.conversationId,
      places: loopResult.places,
      toolExecutions: loopResult.toolExecutions,
      requiresLocation: loopResult.requiresLocation,
      requiresClarification: false,
      clarificationQuestion: null,
      usage: {
        inputTokens: loopResult.inputTokens,
        outputTokens: loopResult.outputTokens,
      },
    };
    logEvent(requestId, "request_completed", {
      success: true,
      model,
      durationMs: Date.now() - startedAt,
      toolCount: loopResult.toolExecutions.length,
    });
    return Response.json(response, { headers: responseHeaders });
  } catch (error) {
    const { body, status } = toSafeResponse(error);
    logEvent(requestId, "request_completed", {
      success: false,
      errorCode: body.errorCode,
      durationMs: Date.now() - startedAt,
    });
    return Response.json(body, { status, headers: responseHeaders });
  }
});
