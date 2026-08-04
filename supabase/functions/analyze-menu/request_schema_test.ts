import { assertEquals, assertThrows } from "jsr:@std/assert@1";
import { parseMenuAnalysisRequest } from "./request_schema.ts";

Deno.test("accepts bounded supported images and preserves locale", () => {
  const parsed = parseMenuAnalysisRequest({
    locale: "de",
    images: [{ mimeType: "image/jpeg", data: "YWJj" }],
  });
  assertEquals(parsed.locale, "de");
  assertEquals(parsed.images.length, 1);
});

Deno.test("defaults unknown locale to English", () => {
  const parsed = parseMenuAnalysisRequest({
    locale: "xx",
    images: [{ mimeType: "image/png", data: "YWJj" }],
  });
  assertEquals(parsed.locale, "en");
});

Deno.test("rejects missing and excessive pages", () => {
  assertThrows(() => parseMenuAnalysisRequest({ images: [] }));
  assertThrows(() =>
    parseMenuAnalysisRequest({
      images: Array.from({ length: 5 }, () => ({ mimeType: "image/jpeg", data: "YWJj" })),
    })
  );
});

Deno.test("rejects unsupported image types and malformed base64", () => {
  assertThrows(() =>
    parseMenuAnalysisRequest({ images: [{ mimeType: "image/svg+xml", data: "YWJj" }] })
  );
  assertThrows(() =>
    parseMenuAnalysisRequest({ images: [{ mimeType: "image/jpeg", data: "not base64" }] })
  );
});

Deno.test("foodProfileContext defaults to null and passes through an opaque object", () => {
  const withoutContext = parseMenuAnalysisRequest({
    images: [{ mimeType: "image/jpeg", data: "YWJj" }],
  });
  assertEquals(withoutContext.foodProfileContext, null);

  const withContext = parseMenuAnalysisRequest({
    images: [{ mimeType: "image/jpeg", data: "YWJj" }],
    foodProfileContext: { dietType: "vegan" },
  });
  assertEquals(withContext.foodProfileContext, { dietType: "vegan" });
});

Deno.test("rejects a non-object foodProfileContext", () => {
  assertThrows(() =>
    parseMenuAnalysisRequest({
      images: [{ mimeType: "image/jpeg", data: "YWJj" }],
      foodProfileContext: "not an object",
    })
  );
});
