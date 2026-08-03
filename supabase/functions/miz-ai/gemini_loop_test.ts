import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { MizAiError } from "./errors.ts";
import { TOOL_DECLARATIONS } from "./tools.ts";
import type { ToolExecutionContext } from "./types.ts";
import { MAX_TOOL_ROUNDS, runGeminiLoop } from "./gemini_loop.ts";
import { LOCATION_REQUIRED_SIGNAL } from "./system_instruction.ts";

// search_nearby_places checks for this before anything else; tests in this
// file that dispatch it (via a queued function_call) need it set, even
// when the test's actual point is the LOCATION_REQUIRED short-circuit
// rather than the Places call itself.
Deno.env.set("GOOGLE_PLACES_API_KEY", "test-key");

const context: ToolExecutionContext = {
  location: null,
  selectedCity: { name: "Trier", latitude: 49.75, longitude: 6.64 },
  foodProfileContext: {
    dietType: "vegan",
    strictRestrictions: [],
    allergies: [],
    intolerances: [],
    dislikedIngredients: [],
    likedCuisines: [],
    curiousCuisines: [],
    spiceLevel: null,
    adventurousness: null,
  },
  locale: "en",
  userId: null,
  deadlineMs: Date.now() + 60000,
  requestId: "loop-test",
};

interface QueuedResponse {
  url: "interactions" | "places";
  body: unknown;
  status?: number;
}

function stubSequence(queue: QueuedResponse[]): () => void {
  const original = globalThis.fetch;
  let index = 0;
  globalThis.fetch = ((input: string | URL | Request) => {
    const url = String(input);
    const isPlaces = url.includes("places.googleapis.com");
    const expected = queue[index];
    if (!expected) {
      throw new Error(`Unexpected extra fetch call to ${url} (queue exhausted)`);
    }
    if ((expected.url === "places") !== isPlaces) {
      throw new Error(`Unexpected fetch order: got ${url}, expected ${expected.url}`);
    }
    index++;
    return Promise.resolve(
      new Response(JSON.stringify(expected.body), { status: expected.status ?? 200 }),
    );
  }) as typeof fetch;
  return () => {
    globalThis.fetch = original;
  };
}

const runParams = {
  apiKey: "test-key",
  model: "gemini-3.6-flash",
  input: "Do I like spicy food?",
  systemInstruction: "system",
  tools: TOOL_DECLARATIONS,
  context,
};

Deno.test("runGeminiLoop returns text directly when no tool call is made", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "completed",
        steps: [{ type: "model_output", content: [{ type: "text", text: "Sushi is Japanese." }] }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.message, "Sushi is Japanese.");
    assertEquals(result.toolExecutions.length, 0);
    assertEquals(result.requiresLocation, false);
  } finally {
    restore();
  }
});

Deno.test("runGeminiLoop executes a single tool call round-trip", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "completed",
        steps: [
          {
            type: "function_call",
            id: "c1",
            name: "get_user_food_profile",
            arguments: { sections: ["flavors"] },
          },
        ],
      },
    },
    {
      url: "interactions",
      body: {
        id: "i2",
        status: "completed",
        steps: [{
          type: "model_output",
          content: [{ type: "text", text: "You seem to enjoy moderate spice." }],
        }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.message, "You seem to enjoy moderate spice.");
    assertEquals(result.toolExecutions, [{ name: "get_user_food_profile", status: "success" }]);
  } finally {
    restore();
  }
});

Deno.test("runGeminiLoop handles multiple parallel function calls in one turn", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "completed",
        steps: [
          { type: "function_call", id: "c1", name: "get_user_food_profile", arguments: {} },
          {
            type: "function_call",
            id: "c2",
            name: "search_nearby_places",
            arguments: { placeTypes: ["cafe"] },
          },
        ],
      },
    },
    {
      url: "places",
      body: {
        places: [{
          id: "places/1",
          displayName: { text: "Café Central" },
          location: { latitude: 49.751, longitude: 6.641 },
        }],
      },
    },
    {
      url: "interactions",
      body: {
        id: "i2",
        status: "completed",
        steps: [{
          type: "model_output",
          content: [{ type: "text", text: "Here is what I found." }],
        }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.toolExecutions.length, 2);
    assertEquals(result.message, "");
    assertEquals(result.places.length, 1);
  } finally {
    restore();
  }
});

Deno.test("runGeminiLoop short-circuits into requiresLocation without asking Gemini again", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "completed",
        steps: [
          {
            type: "function_call",
            id: "c1",
            name: "search_nearby_places",
            arguments: { placeTypes: ["cafe"] },
          },
        ],
      },
    },
    // No second "interactions" entry queued — if the loop tried to
    // continue the interaction after LOCATION_REQUIRED, this test would
    // fail with "queue exhausted".
  ]);
  try {
    const result = await runGeminiLoop({
      ...runParams,
      context: { ...context, selectedCity: null },
    });
    assertEquals(result.requiresLocation, true);
    assertEquals(result.message, "");
  } finally {
    restore();
  }
});

Deno.test("runGeminiLoop returns TOOL_LOOP_LIMIT after exceeding the max rounds", async () => {
  const alwaysCallsTool = {
    id: "loop",
    status: "completed",
    steps: [{ type: "function_call", id: "c", name: "get_user_food_profile", arguments: {} }],
  };
  // createInteraction (1) + continueInteraction x MAX_TOOL_ROUNDS = MAX_TOOL_ROUNDS + 1 calls,
  // every one of them still requesting a tool call.
  const queue: QueuedResponse[] = Array.from({ length: MAX_TOOL_ROUNDS + 1 }, () => ({
    url: "interactions" as const,
    body: alwaysCallsTool,
  }));
  const restore = stubSequence(queue);
  try {
    const error = await assertRejects(() => runGeminiLoop(runParams), MizAiError);
    assertEquals((error as MizAiError).code, "TOOL_LOOP_LIMIT");
  } finally {
    restore();
  }
});

Deno.test("runGeminiLoop recovers when Gemini invents an unknown tool", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "requires_action",
        steps: [{ type: "function_call", id: "c1", name: "delete_everything", arguments: {} }],
      },
    },
    {
      url: "interactions",
      body: {
        id: "i2",
        status: "completed",
        steps: [{
          type: "model_output",
          content: [{ type: "text", text: "I cannot use that operation." }],
        }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.message, "I cannot use that operation.");
    assertEquals(result.toolExecutions[0].status, "error");
  } finally {
    restore();
  }
});

Deno.test("invented location tool becomes requiresLocation instead of an error", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "requires_action",
        steps: [{
          type: "function_call",
          id: "c1",
          name: "get_user_location",
          arguments: {},
        }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop({
      ...runParams,
      context: { ...context, selectedCity: null },
    });
    assertEquals(result.requiresLocation, true);
  } finally {
    restore();
  }
});

Deno.test("explicit model location signal becomes requiresLocation", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "completed",
        steps: [{
          type: "model_output",
          content: [{ type: "text", text: LOCATION_REQUIRED_SIGNAL }],
        }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.requiresLocation, true);
    assertEquals(result.message, "");
  } finally {
    restore();
  }
});

Deno.test("invalid tool arguments are returned to Gemini for recovery", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "requires_action",
        steps: [{
          type: "function_call",
          id: "c1",
          name: "search_nearby_places",
          arguments: { placeTypes: ["cafe"], radiusMeters: 999999 },
        }],
      },
    },
    {
      url: "interactions",
      body: {
        id: "i2",
        status: "completed",
        steps: [{
          type: "model_output",
          content: [{ type: "text", text: "Please try a smaller search area." }],
        }],
      },
    },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.message, "Please try a smaller search area.");
    assertEquals(result.toolExecutions, [{ name: "search_nearby_places", status: "error" }]);
  } finally {
    restore();
  }
});

Deno.test("an empty model response becomes AI_UNAVAILABLE", async () => {
  const restore = stubSequence([
    { url: "interactions", body: { id: "i1", status: "completed", steps: [] } },
  ]);
  try {
    const error = await assertRejects(() => runGeminiLoop(runParams), MizAiError);
    assertEquals((error as MizAiError).code, "AI_UNAVAILABLE");
  } finally {
    restore();
  }
});

Deno.test("an empty validated place search becomes NO_RESULTS", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "requires_action",
        steps: [{
          type: "function_call",
          id: "c1",
          name: "search_nearby_places",
          arguments: { placeTypes: ["cafe"] },
        }],
      },
    },
    { url: "places", body: { places: [] } },
    {
      url: "interactions",
      body: {
        id: "i2",
        status: "completed",
        steps: [{
          type: "model_output",
          content: [{ type: "text", text: "I found no matching cafés." }],
        }],
      },
    },
  ]);
  try {
    const error = await assertRejects(() => runGeminiLoop(runParams), MizAiError);
    assertEquals((error as MizAiError).code, "NO_RESULTS");
  } finally {
    restore();
  }
});

Deno.test("validated Places data survives failed Gemini narration", async () => {
  const restore = stubSequence([
    {
      url: "interactions",
      body: {
        id: "i1",
        status: "requires_action",
        steps: [{
          type: "function_call",
          id: "c1",
          name: "search_nearby_places",
          arguments: { placeTypes: ["cafe"] },
        }],
      },
    },
    {
      url: "places",
      body: {
        places: [{
          id: "places/1",
          displayName: { text: "Café Central" },
          location: { latitude: 49.751, longitude: 6.641 },
        }],
      },
    },
    { url: "interactions", body: {}, status: 503 },
    { url: "interactions", body: {}, status: 503 },
  ]);
  try {
    const result = await runGeminiLoop(runParams);
    assertEquals(result.places.length, 1);
    assertEquals(result.message, "");
  } finally {
    restore();
  }
});
