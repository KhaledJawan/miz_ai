import { assertEquals, assertRejects, assertThrows } from "jsr:@std/assert@1";
import { classifyCaptureWithGemini, parseClassifyOutput } from "./gemini_classify_client.ts";

function successResponse(result: unknown): Response {
  return Response.json({
    steps: [{
      type: "model_output",
      content: [{ type: "text", text: JSON.stringify(result) }],
    }],
  });
}

Deno.test("parses a valid classification", () => {
  assertEquals(parseClassifyOutput({ kind: "menu" }).kind, "menu");
  assertEquals(parseClassifyOutput({ kind: "single_dish" }).kind, "single_dish");
  assertEquals(parseClassifyOutput({ kind: "unrecognized" }).kind, "unrecognized");
});

Deno.test("rejects an invalid kind value rather than trusting it", () => {
  assertThrows(() => parseClassifyOutput({ kind: "restaurant" }));
});

Deno.test("sends prompt before the image with structured output and no storage", async () => {
  let body: Record<string, unknown> | null = null;
  const result = await classifyCaptureWithGemini({
    apiKey: "secret",
    model: "gemini-test",
    requestId: "classify-1",
    deadlineMs: Date.now() + 5000,
    request: { locale: "en", image: { mimeType: "image/jpeg", data: "YWJj" } },
    fetcher: async (_input, init) => {
      body = JSON.parse(init?.body as string);
      return successResponse({ kind: "menu" });
    },
  });
  const requestBody = body as unknown as Record<string, unknown>;
  const input = requestBody.input as Array<Record<string, unknown>>;
  assertEquals(input[0].type, "text");
  assertEquals(input[1].type, "image");
  assertEquals(requestBody.store, false);
  assertEquals(result.kind, "menu");
});

Deno.test("maps a 429 to a rejection", async () => {
  await assertRejects(
    () =>
      classifyCaptureWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "classify-2",
        deadlineMs: Date.now() + 5000,
        request: { locale: "en", image: { mimeType: "image/png", data: "YWJj" } },
        fetcher: async () => new Response("", { status: 429 }),
      }),
  );
});

Deno.test("maps an invalid response body to a rejection", async () => {
  await assertRejects(
    () =>
      classifyCaptureWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "classify-3",
        deadlineMs: Date.now() + 5000,
        request: { locale: "en", image: { mimeType: "image/png", data: "YWJj" } },
        fetcher: async () => Response.json({ invalid: true }),
      }),
  );
});

Deno.test("an already-expired deadline rejects without calling fetch", async () => {
  let called = false;
  await assertRejects(
    () =>
      classifyCaptureWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "classify-4",
        deadlineMs: Date.now() - 1,
        request: { locale: "en", image: { mimeType: "image/png", data: "YWJj" } },
        fetcher: async () => {
          called = true;
          return successResponse({ kind: "menu" });
        },
      }),
  );
  assertEquals(called, false);
});
