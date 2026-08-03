import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { analyzeMenuWithGemini, parseMenuAnalysis } from "./gemini_menu_client.ts";

const validAnalysis = {
  readable: true,
  detectedLanguage: "German",
  overview: "A short seasonal menu.",
  currency: "EUR",
  items: [{
    section: "Mains",
    name: "Käsespätzle",
    explanation: "Soft egg noodles with cheese and onions.",
    price: "€14",
    dietaryTags: "vegetarian",
    possibleAllergens: "egg|milk|wheat",
    confidence: "high",
  }],
  notes: ["Ask the restaurant about substitutions."],
};

const validFlatAnalysis = {
  readable: true,
  detectedLanguage: "German",
  overview: "A short seasonal menu.",
  currency: "EUR",
  items: [
    "Mains|||Käsespätzle|||Soft egg noodles with cheese and onions.|||€14|||vegetarian|||egg|milk|wheat|||high",
  ],
  notes: ["Ask the restaurant about substitutions."],
};

function successResponse(analysis: unknown): Response {
  return Response.json({
    id: "interaction-1",
    status: "completed",
    steps: [{
      type: "model_output",
      content: [{ type: "text", text: JSON.stringify(analysis) }],
    }],
  });
}

Deno.test("parses and bounds a typed menu analysis", () => {
  const parsed = parseMenuAnalysis(validFlatAnalysis);
  assertEquals(parsed.sections[0].items[0].name, "Käsespätzle");
  assertEquals(parsed.sections[0].items[0].confidence, "high");
  assertEquals(parsed.sections[0].items[0].possibleAllergens, ["egg", "milk", "wheat"]);
});

Deno.test("unwraps and validates the shallow structured analysis envelope", () => {
  const parsed = parseMenuAnalysis({
    analysisJson: JSON.stringify({ ...validAnalysis, notes: "Confirm ingredients" }),
  });
  assertEquals(parsed.sections[0].items[0].possibleAllergens, ["egg", "milk", "wheat"]);
  assertEquals(parsed.notes, ["Confirm ingredients"]);
});

Deno.test("accepts a safe unreadable-menu response with nullable metadata", () => {
  const parsed = parseMenuAnalysis({
    analysisJson: JSON.stringify({
      readable: false,
      detectedLanguage: "English",
      overview: "This image does not show a readable restaurant menu.",
      currency: null,
      items: [],
      notes: null,
    }),
  });

  assertEquals(parsed.readable, false);
  assertEquals(parsed.currency, null);
  assertEquals(parsed.sections, []);
  assertEquals(parsed.notes, []);
});

Deno.test("rejects an invalid semantic response despite structured JSON", () => {
  assertRejects(
    async () => parseMenuAnalysis({ ...validAnalysis, readable: "yes" }),
  );
});

Deno.test("drops a malformed dish instead of failing the whole menu", () => {
  const parsed = parseMenuAnalysis({
    ...validFlatAnalysis,
    items: ["not-enough-fields", ...validFlatAnalysis.items],
  });
  assertEquals(parsed.sections.length, 1);
  assertEquals(parsed.sections[0].items.length, 1);
});

Deno.test("preserves empty optional fields in an encoded dish", () => {
  const parsed = parseMenuAnalysis({
    ...validFlatAnalysis,
    items: [["Starters", "Broth", "A clear vegetable soup.", "", "", "", "medium"].join("|||")],
  });
  const item = parsed.sections[0].items[0];
  assertEquals(item.price, null);
  assertEquals(item.dietaryTags, []);
  assertEquals(item.possibleAllergens, []);
  assertEquals(item.confidence, "medium");
});

Deno.test("sends text before inline images with structured output and no storage", async () => {
  let capturedBody: Record<string, unknown> | null = null;
  const result = await analyzeMenuWithGemini({
    apiKey: "secret",
    model: "gemini-test",
    requestId: "request-1",
    deadlineMs: Date.now() + 5000,
    request: {
      locale: "fa",
      images: [{ mimeType: "image/jpeg", data: "YWJj" }],
    },
    fetcher: async (_input, init) => {
      capturedBody = JSON.parse(init?.body as string);
      return successResponse(validFlatAnalysis);
    },
  });
  const body = capturedBody as unknown as Record<string, unknown>;
  const input = body.input as Array<Record<string, unknown>>;
  assertEquals(input[0].type, "text");
  assertEquals(input[1], {
    type: "image",
    data: "YWJj",
    mime_type: "image/jpeg",
  });
  assertEquals(body.store, false);
  const responseFormat = body.response_format as Record<string, unknown>;
  const schema = responseFormat.schema as Record<string, unknown>;
  const properties = schema.properties as Record<string, Record<string, unknown>>;
  assertEquals(properties.items.type, "array");
  assertEquals(result.sections.length, 1);
});

Deno.test("accepts a JSON response wrapped in a markdown fence", async () => {
  const response = Response.json({
    steps: [{
      type: "model_output",
      content: [{
        type: "text",
        text: `\`\`\`json\n${JSON.stringify(validFlatAnalysis)}\n\`\`\``,
      }],
    }],
  });
  const result = await analyzeMenuWithGemini({
    apiKey: "secret",
    model: "gemini-test",
    requestId: "request-fenced",
    deadlineMs: Date.now() + 5000,
    request: { locale: "en", images: [{ mimeType: "image/png", data: "YWJj" }] },
    fetcher: async () => response,
  });
  assertEquals(result.sections[0].items[0].name, "Käsespätzle");
});

Deno.test("maps rate limits and invalid envelopes to typed safe failures", async () => {
  await assertRejects(
    () =>
      analyzeMenuWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "request-2",
        deadlineMs: Date.now() + 5000,
        request: { locale: "en", images: [{ mimeType: "image/png", data: "YWJj" }] },
        fetcher: async () => new Response("", { status: 429 }),
      }),
    Error,
    "busy",
  );
  await assertRejects(
    () =>
      analyzeMenuWithGemini({
        apiKey: "secret",
        model: "gemini-test",
        requestId: "request-3",
        deadlineMs: Date.now() + 5000,
        request: { locale: "en", images: [{ mimeType: "image/png", data: "YWJj" }] },
        fetcher: async () => Response.json({ invalid: true }),
      }),
  );
});
