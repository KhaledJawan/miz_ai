import { assertEquals, assertThrows } from "jsr:@std/assert@1";
import { parseFoodAnalysisRequest } from "./request_schema.ts";

Deno.test("accepts one supported food image and preserves locale", () => {
  const parsed = parseFoodAnalysisRequest({
    locale: "fa",
    image: { mimeType: "image/jpeg", data: "YWJj" },
  });
  assertEquals(parsed.locale, "fa");
  assertEquals(parsed.image.mimeType, "image/jpeg");
});

Deno.test("defaults unknown locale to English", () => {
  const parsed = parseFoodAnalysisRequest({
    locale: "xx",
    image: { mimeType: "image/png", data: "YWJj" },
  });
  assertEquals(parsed.locale, "en");
});

Deno.test("rejects missing, unsupported, and malformed images", () => {
  assertThrows(() => parseFoodAnalysisRequest({}));
  assertThrows(() =>
    parseFoodAnalysisRequest({ image: { mimeType: "image/svg+xml", data: "YWJj" } })
  );
  assertThrows(() =>
    parseFoodAnalysisRequest({ image: { mimeType: "image/jpeg", data: "not base64" } })
  );
});
