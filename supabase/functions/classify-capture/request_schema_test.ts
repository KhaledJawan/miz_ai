import { assertEquals, assertThrows } from "jsr:@std/assert@1";
import { MizAiError } from "../miz-ai/errors.ts";
import { parseClassifyCaptureRequest } from "./request_schema.ts";

function validRaw(
  locale: unknown = "en",
  image: unknown = { mimeType: "image/jpeg", data: "YWJj" },
) {
  return { locale, image };
}

Deno.test("parses a valid request and defaults an unknown locale to en", () => {
  const parsed = parseClassifyCaptureRequest(validRaw("fr"));
  assertEquals(parsed.locale, "en");
  assertEquals(parsed.image.mimeType, "image/jpeg");
});

Deno.test("accepts de and fa locales", () => {
  assertEquals(parseClassifyCaptureRequest(validRaw("de")).locale, "de");
  assertEquals(parseClassifyCaptureRequest(validRaw("fa")).locale, "fa");
});

Deno.test("rejects a missing image", () => {
  assertThrows(() => parseClassifyCaptureRequest({ locale: "en" }), MizAiError);
});

Deno.test("rejects an unsupported mime type", () => {
  assertThrows(
    () => parseClassifyCaptureRequest(validRaw("en", { mimeType: "image/gif", data: "YWJj" })),
    MizAiError,
  );
});

Deno.test("rejects non-base64 image data", () => {
  assertThrows(
    () =>
      parseClassifyCaptureRequest(validRaw("en", { mimeType: "image/jpeg", data: "not base64!" })),
    MizAiError,
  );
});

Deno.test("rejects oversized image data", () => {
  const huge = "A".repeat(4 * 1024 * 1024 + 4);
  assertThrows(
    () => parseClassifyCaptureRequest(validRaw("en", { mimeType: "image/jpeg", data: huge })),
    MizAiError,
  );
});
