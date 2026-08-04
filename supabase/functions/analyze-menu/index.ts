import { CORS_HEADERS } from "../_shared/cors.ts";
import { requireValidClientKey } from "../miz-ai/client_auth.ts";
import { mizAiError, toSafeResponse } from "../miz-ai/errors.ts";
import { sanitizeFoodProfileContext } from "../miz-ai/food_profile.ts";
import { logEvent } from "../miz-ai/observability.ts";
import { parseMenuAnalysisRequest } from "./request_schema.ts";
import { matchAndClassifyCategories } from "./stage2_matcher.ts";
import type { MenuAnalysisResult } from "./types.ts";
import { parseMenuVision } from "./vision_parser.ts";

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
  const deadlineMs = startedAt + TOTAL_BUDGET_MS;
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

    // Stage 1: bare vision extraction (Gemini, JSON-only).
    const vision = await parseMenuVision({ apiKey, model, request, requestId, deadlineMs });

    let analysis: MenuAnalysisResult;
    if (!vision.readable || vision.categories.length === 0) {
      analysis = {
        readable: vision.readable,
        detectedLanguage: vision.detectedLanguage,
        currency: vision.currency,
        categories: [],
        notes: vision.readable
          ? [
            "No dishes could be extracted from this photo. Try a clearer, closer photo of the menu.",
          ]
          : [],
      };
    } else {
      // Stage 2: deterministic local matching + database filtering
      // (no Gemini call in this stage at all).
      const profile = sanitizeFoodProfileContext(request.foodProfileContext);
      const { categories, truncated } = await matchAndClassifyCategories(
        vision.categories,
        profile,
        request.locale,
        deadlineMs,
      );
      const notes: string[] = [];
      if (truncated) notes.push("Only the first 40 items on this menu were checked.");
      analysis = {
        readable: vision.readable,
        detectedLanguage: vision.detectedLanguage,
        currency: vision.currency,
        categories,
        notes,
      };
    }

    logEvent(requestId, "menu_request_completed", {
      success: true,
      readable: analysis.readable,
      categoryCount: analysis.categories.length,
      dishCount: analysis.categories.reduce((sum, c) => sum + c.dishes.length, 0),
      matchedCount: analysis.categories.reduce(
        (sum, c) => sum + c.dishes.filter((d) => d.matchedFoodId !== null).length,
        0,
      ),
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
