import { CORS_HEADERS } from "../_shared/cors.ts";
import { requireValidClientKey } from "../miz-ai/client_auth.ts";
import { mizAiError, toSafeResponse } from "../miz-ai/errors.ts";
import { logEvent } from "../miz-ai/observability.ts";
import { analyzeMenuWithGemini } from "./gemini_menu_client.ts";
import { parseMenuAnalysisRequest } from "./request_schema.ts";

const MAX_BODY_BYTES = 13 * 1024 * 1024;
const DEFAULT_MODEL = "gemini-3.6-flash";
const TOTAL_BUDGET_MS = 70000;

async function readBody(req: Request): Promise<unknown> {
  const contentLength = req.headers.get("content-length");
  if (contentLength && Number(contentLength) > MAX_BODY_BYTES) {
    throw mizAiError("INVALID_REQUEST", "menu request too large");
  }
  const text = await req.text();
  if (text.length > MAX_BODY_BYTES) {
    throw mizAiError("INVALID_REQUEST", "menu request too large");
  }
  try {
    return JSON.parse(text);
  } catch (_error) {
    throw mizAiError("INVALID_REQUEST", "menu request is not valid JSON");
  }
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: CORS_HEADERS });
  if (req.method !== "POST") {
    const { body, status } = toSafeResponse(mizAiError("INVALID_REQUEST", "method not allowed"));
    return Response.json(body, { status, headers: CORS_HEADERS });
  }

  const requestId = crypto.randomUUID();
  const startedAt = Date.now();
  const responseHeaders = { ...CORS_HEADERS, "X-Request-Id": requestId };
  try {
    requireValidClientKey(req);
    const apiKey = Deno.env.get("GEMINI_API_KEY");
    if (!apiKey) throw mizAiError("AI_CONFIGURATION_ERROR", "GEMINI_API_KEY missing");
    const model = Deno.env.get("GEMINI_MODEL")?.trim() || DEFAULT_MODEL;
    const request = parseMenuAnalysisRequest(await readBody(req));
    const totalBase64Chars = request.images.reduce((sum, image) => sum + image.data.length, 0);
    logEvent(requestId, "menu_request_started", {
      model,
      pageCount: request.images.length,
      encodedChars: totalBase64Chars,
    });
    const analysis = await analyzeMenuWithGemini({
      apiKey,
      model,
      request,
      requestId,
      deadlineMs: startedAt + TOTAL_BUDGET_MS,
    });
    logEvent(requestId, "menu_request_completed", {
      success: true,
      readable: analysis.readable,
      sectionCount: analysis.sections.length,
      itemCount: analysis.sections.reduce((sum, section) => sum + section.items.length, 0),
      durationMs: Date.now() - startedAt,
    });
    return Response.json({ success: true, analysis }, { headers: responseHeaders });
  } catch (error) {
    const { body, status } = toSafeResponse(error);
    logEvent(requestId, "menu_request_completed", {
      success: false,
      errorCode: body.errorCode,
      durationMs: Date.now() - startedAt,
    });
    return Response.json(body, { status, headers: responseHeaders });
  }
});
