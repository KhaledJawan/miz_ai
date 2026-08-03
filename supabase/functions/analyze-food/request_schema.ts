import { mizAiError } from "../miz-ai/errors.ts";
import type { FoodAnalysisRequest } from "./types.ts";

export const MAX_FOOD_IMAGE_BASE64_CHARS = 4 * 1024 * 1024;

const SUPPORTED_MIME_TYPES = new Set([
  "image/jpeg",
  "image/png",
  "image/webp",
  "image/heic",
  "image/heif",
]);

function isPlainObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function isBase64(value: string): boolean {
  return value.length % 4 === 0 && /^[A-Za-z0-9+/]+={0,2}$/.test(value);
}

export function parseFoodAnalysisRequest(raw: unknown): FoodAnalysisRequest {
  if (!isPlainObject(raw) || !isPlainObject(raw.image)) {
    throw mizAiError("INVALID_REQUEST", "food request must contain one image");
  }
  const mimeType = raw.image.mimeType;
  const data = raw.image.data;
  if (typeof mimeType !== "string" || !SUPPORTED_MIME_TYPES.has(mimeType)) {
    throw mizAiError("INVALID_REQUEST", "unsupported image type");
  }
  if (
    typeof data !== "string" || data.length === 0 ||
    data.length > MAX_FOOD_IMAGE_BASE64_CHARS || !isBase64(data)
  ) {
    throw mizAiError("INVALID_REQUEST", "invalid food image data");
  }
  const locale = raw.locale === "de" || raw.locale === "fa" ? raw.locale : "en";
  return { locale, image: { mimeType, data } };
}
