import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { analyzeFoodWithGemini, parseFoodAnalysis } from "./gemini_food_client.ts";

const validAnalysis = {
  recognized: true,
  overview: "A baked Italian flatbread.",
  candidates: ["Pizza Margherita|||Pizza with tomato, cheese, and basil.|||high"],
};

function successResponse(analysis: unknown): Response {
  return Response.json({
    steps: [{
      type: "model_output",
      content: [{ type: "text", text: JSON.stringify(analysis) }],
    }],
  });
}

Deno.test("parses bounded food candidates", () => {
  const parsed = parseFoodAnalysis(validAnalysis);
  assertEquals(parsed.recognized, true);
  assertEquals(parsed.candidates[0].name, "Pizza Margherita");
  assertEquals(parsed.candidates[0].confidence, 0.9);
});

Deno.test("drops malformed candidates without trusting them", () => {
  const parsed = parseFoodAnalysis({
    ...validAnalysis,
    candidates: ["bad", ...validAnalysis.candidates],
  });
  assertEquals(parsed.candidates.length, 1);
});

Deno.test("sends prompt before the image with structured output and no storage", async () => {
  let body: Record<string, unknown> | null = null;
  const result = await analyzeFoodWithGemini({
    apiKey: "secret",
    model: "gemini-test",
    requestId: "food-1",
    deadlineMs: Date.now() + 5000,
    request: { locale: "de", image: { mimeType: "image/jpeg", data: "YWJj" } },
    fetcher: async (_input, init) => {
      body = JSON.parse(init?.body as string);
      return successResponse(validAnalysis);
    },
  });
  const requestBody = body as unknown as Record<string, unknown>;
  const input = requestBody.input as Array<Record<string, unknown>>;
  assertEquals(input[0].type, "text");
  assertEquals(input[1].type, "image");
  assertEquals(requestBody.store, false);
  assertEquals(result.candidates.length, 1);
});

Deno.test("maps provider limits and invalid responses to safe failures", async () => {
  await assertRejects(
    () =>
      analyzeFoodWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "food-2",
        deadlineMs: Date.now() + 5000,
        request: { locale: "en", image: { mimeType: "image/png", data: "YWJj" } },
        fetcher: async () => new Response("", { status: 429 }),
      }),
    Error,
    "busy",
  );
  await assertRejects(
    () =>
      analyzeFoodWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "food-3",
        deadlineMs: Date.now() + 5000,
        request: { locale: "en", image: { mimeType: "image/png", data: "YWJj" } },
        fetcher: async () => Response.json({ invalid: true }),
      }),
  );
});
