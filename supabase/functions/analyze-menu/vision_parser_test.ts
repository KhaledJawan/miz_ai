import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { MizAiError } from "../miz-ai/errors.ts";
import { parseMenuVision, parseVisionOutput } from "./vision_parser.ts";
import type { MenuAnalysisRequest } from "./types.ts";

Deno.test("parseVisionOutput: unreadable menu returns readable=false with no categories", () => {
  const result = parseVisionOutput({
    readable: false,
    detectedLanguage: null,
    currency: null,
    categories: [],
  });
  assertEquals(result.readable, false);
  assertEquals(result.categories.length, 0);
});

Deno.test("parseVisionOutput: decodes nested category/item objects", () => {
  const result = parseVisionOutput({
    readable: true,
    detectedLanguage: "de",
    currency: "EUR",
    categories: [
      {
        name: "Mains",
        items: [
          { name: "Sauerbraten", price: "18.50" },
          { name: "Currywurst", price: "9" },
        ],
      },
    ],
  });
  assertEquals(result.categories.length, 1);
  assertEquals(result.categories[0].name, "Mains");
  assertEquals(result.categories[0].items.length, 2);
  assertEquals(result.categories[0].items[0], { extractedName: "Sauerbraten", price: "18.50" });
  assertEquals(result.categories[0].items[1], { extractedName: "Currywurst", price: "9" });
});

Deno.test("parseVisionOutput: missing/empty price on an item becomes null, not a dropped item", () => {
  const result = parseVisionOutput({
    readable: true,
    detectedLanguage: null,
    currency: null,
    categories: [{ name: "Drinks", items: [{ name: "Water", price: "" }] }],
  });
  assertEquals(result.categories[0].items[0], { extractedName: "Water", price: null });
});

Deno.test("parseVisionOutput: blank category name falls back to 'Menu'", () => {
  const result = parseVisionOutput({
    readable: true,
    detectedLanguage: null,
    currency: null,
    categories: [{ name: "", items: [{ name: "Sauerbraten", price: "18" }] }],
  });
  assertEquals(result.categories[0].name, "Menu");
});

Deno.test("parseVisionOutput: a category with no valid items is dropped", () => {
  const result = parseVisionOutput({
    readable: true,
    detectedLanguage: null,
    currency: null,
    categories: [{ name: "Empty", items: [] }, {
      name: "Mains",
      items: [{ name: "Pasta", price: "" }],
    }],
  });
  assertEquals(result.categories.length, 1);
  assertEquals(result.categories[0].name, "Mains");
});

Deno.test("parseVisionOutput: caps at 12 categories and 20 items per category", () => {
  const manyItems = Array.from({ length: 25 }, (_, i) => ({ name: `Item${i}`, price: `${i}` }));
  const manyCategories = Array.from({ length: 15 }, (_, i) => ({
    name: `Cat${i}`,
    items: [{ name: "Dish", price: "1" }],
  }));
  const result = parseVisionOutput({
    readable: true,
    detectedLanguage: null,
    currency: null,
    categories: [{ name: "Big", items: manyItems }, ...manyCategories],
  });
  assertEquals(result.categories.length <= 12, true);
  assertEquals(result.categories[0].items.length <= 20, true);
});

Deno.test("parseVisionOutput: throws AI_UNAVAILABLE for a missing readable field", () => {
  try {
    parseVisionOutput({ detectedLanguage: null, currency: null, categories: [] });
    throw new Error("expected throw");
  } catch (error) {
    if (!(error instanceof MizAiError)) throw error;
    assertEquals(error.code, "AI_UNAVAILABLE");
  }
});

function baseRequest(): MenuAnalysisRequest {
  return {
    locale: "en",
    images: [{ mimeType: "image/jpeg", data: "aGVsbG8=" }],
    foodProfileContext: null,
  };
}

function interactionEnvelope(json: unknown) {
  return {
    id: "interaction-1",
    status: "completed",
    steps: [
      { type: "model_output", content: [{ type: "text", text: JSON.stringify(json) }] },
    ],
  };
}

Deno.test("parseMenuVision: happy path end to end through the HTTP layer", async () => {
  const fetcher: typeof fetch = () =>
    Promise.resolve(
      new Response(
        JSON.stringify(
          interactionEnvelope({
            readable: true,
            detectedLanguage: "de",
            currency: "EUR",
            categories: [
              { name: "Mains", items: [{ name: "Sauerbraten", price: "18.50" }] },
            ],
          }),
        ),
        { status: 200 },
      ),
    );
  const result = await parseMenuVision({
    apiKey: "test-key",
    model: "gemini-3.6-flash",
    request: baseRequest(),
    requestId: "req-1",
    deadlineMs: Date.now() + 10000,
    fetcher,
  });
  assertEquals(result.readable, true);
  assertEquals(result.categories[0].items[0].extractedName, "Sauerbraten");
});

Deno.test("parseMenuVision: maps a 401 to AI_CONFIGURATION_ERROR", async () => {
  const fetcher: typeof fetch = () => Promise.resolve(new Response("no", { status: 401 }));
  await assertRejects(
    () =>
      parseMenuVision({
        apiKey: "bad-key",
        model: "gemini-3.6-flash",
        request: baseRequest(),
        requestId: "req-1",
        deadlineMs: Date.now() + 10000,
        fetcher,
      }),
    MizAiError,
  );
});

Deno.test("parseMenuVision: an already-expired deadline throws AI_TIMEOUT without calling fetch", async () => {
  let called = false;
  const fetcher: typeof fetch = () => {
    called = true;
    return Promise.resolve(new Response("{}", { status: 200 }));
  };
  await assertRejects(
    () =>
      parseMenuVision({
        apiKey: "test-key",
        model: "gemini-3.6-flash",
        request: baseRequest(),
        requestId: "req-1",
        deadlineMs: Date.now() - 1,
        fetcher,
      }),
    MizAiError,
  );
  assertEquals(called, false);
});
