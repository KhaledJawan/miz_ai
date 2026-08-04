import { mizAiError } from "../miz-ai/errors.ts";
import type { MenuAnalysisRequest } from "./types.ts";

export const MAX_MENU_PAGES = 4;
export const MAX_IMAGE_BASE64_CHARS = 4 * 1024 * 1024;
export const MAX_TOTAL_BASE64_CHARS = 12 * 1024 * 1024;

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

function parseFoodProfileContext(raw: unknown): MenuAnalysisRequest["foodProfileContext"] {
  if (raw === undefined || raw === null) return null;
  if (!isPlainObject(raw)) {
    throw mizAiError("INVALID_REQUEST", "foodProfileContext must be an object");
  }
  return raw;
}

export function parseMenuAnalysisRequest(raw: unknown): MenuAnalysisRequest {
  if (!isPlainObject(raw) || !Array.isArray(raw.images)) {
    throw mizAiError("INVALID_REQUEST", "menu request must contain images");
  }
  if (raw.images.length === 0 || raw.images.length > MAX_MENU_PAGES) {
    throw mizAiError("INVALID_REQUEST", "invalid menu page count");
  }
  const locale = raw.locale === "de" || raw.locale === "fa" ? raw.locale : "en";
  const foodProfileContext = parseFoodProfileContext(raw.foodProfileContext);
  let totalChars = 0;
  const images = raw.images.map((rawImage) => {
    if (!isPlainObject(rawImage)) {
      throw mizAiError("INVALID_REQUEST", "invalid image entry");
    }
    const mimeType = rawImage.mimeType;
    const data = rawImage.data;
    if (typeof mimeType !== "string" || !SUPPORTED_MIME_TYPES.has(mimeType)) {
      throw mizAiError("INVALID_REQUEST", "unsupported image type");
    }
    if (
      typeof data !== "string" || data.length === 0 ||
      data.length > MAX_IMAGE_BASE64_CHARS || !isBase64(data)
    ) {
      throw mizAiError("INVALID_REQUEST", "invalid image data");
    }
    totalChars += data.length;
    if (totalChars > MAX_TOTAL_BASE64_CHARS) {
      throw mizAiError("INVALID_REQUEST", "image payload too large");
    }
    return { mimeType, data };
  });
  return { locale, images, foodProfileContext };
}
