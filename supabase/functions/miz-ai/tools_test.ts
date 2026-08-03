import { assertEquals } from "jsr:@std/assert@1";
import { dispatchTool, TOOL_ALLOWLIST, TOOL_DECLARATIONS } from "./tools.ts";
import type { ToolExecutionContext } from "./types.ts";

const baseContext: ToolExecutionContext = {
  location: null,
  selectedCity: { name: "Trier", latitude: 49.75, longitude: 6.64 },
  foodProfileContext: null,
  locale: "en",
  userId: null,
  deadlineMs: Date.now() + 60000,
  requestId: "tools-test",
};

function withStubbedFetch<T>(response: unknown, status: number, run: () => Promise<T>): Promise<T> {
  const original = globalThis.fetch;
  globalThis.fetch = (() =>
    Promise.resolve(
      new Response(JSON.stringify(response), {
        status,
        headers: { "content-type": "application/json" },
      }),
    )) as typeof fetch;
  return run().finally(() => {
    globalThis.fetch = original;
  });
}

Deno.test("TOOL_ALLOWLIST contains exactly the two declared tools", () => {
  assertEquals(TOOL_ALLOWLIST.size, 2);
  assertEquals(TOOL_ALLOWLIST.has("search_nearby_places"), true);
  assertEquals(TOOL_ALLOWLIST.has("get_user_food_profile"), true);
});

Deno.test("TOOL_DECLARATIONS require placeTypes for search_nearby_places", () => {
  const declaration = TOOL_DECLARATIONS.find((tool) => tool.name === "search_nearby_places")!;
  const parameters = declaration.parameters as { required: string[] };
  assertEquals(parameters.required, ["placeTypes"]);
});

Deno.test("dispatchTool rejects a name that is not on the allowlist", async () => {
  const result = await dispatchTool("delete_everything", {}, baseContext);
  assertEquals(result.status, "error");
  assertEquals(result.result.errorType, "INVALID_TOOL_CALL");
});

Deno.test("dispatchTool rejects search_nearby_places with an empty placeTypes array", async () => {
  const result = await dispatchTool("search_nearby_places", { placeTypes: [] }, baseContext);
  assertEquals(result.status, "error");
  assertEquals(result.result.errorType, "INVALID_TOOL_ARGUMENTS");
});

Deno.test("dispatchTool rejects search_nearby_places with an unsupported placeType", async () => {
  const result = await dispatchTool(
    "search_nearby_places",
    { placeTypes: ["nightclub"] },
    baseContext,
  );
  assertEquals(result.status, "error");
  assertEquals(result.result.errorType, "INVALID_TOOL_ARGUMENTS");
});

Deno.test("dispatchTool rejects unknown coordinate fields before execution", async () => {
  const priorKey = Deno.env.get("GOOGLE_PLACES_API_KEY");
  Deno.env.set("GOOGLE_PLACES_API_KEY", "test-key");
  try {
    await withStubbedFetch({ places: [] }, 200, async () => {
      const result = await dispatchTool(
        "search_nearby_places",
        { placeTypes: ["cafe"], latitude: 0, longitude: 0 },
        baseContext,
      );
      assertEquals(result.status, "error");
      assertEquals(result.result.errorType, "INVALID_TOOL_ARGUMENTS");
    });
  } finally {
    if (priorKey === undefined) Deno.env.delete("GOOGLE_PLACES_API_KEY");
    else Deno.env.set("GOOGLE_PLACES_API_KEY", priorKey);
  }
});

Deno.test("dispatchTool returns LOCATION_REQUIRED when neither location nor city is available", async () => {
  Deno.env.set("GOOGLE_PLACES_API_KEY", "test-key");
  const result = await dispatchTool(
    "search_nearby_places",
    { placeTypes: ["cafe"] },
    { ...baseContext, selectedCity: null },
  );
  assertEquals(result.status, "error");
  assertEquals(result.result.errorType, "LOCATION_REQUIRED");
});

Deno.test("dispatchTool routes get_user_food_profile without any network call", async () => {
  const result = await dispatchTool("get_user_food_profile", { sections: ["diet"] }, baseContext);
  assertEquals(result.status, "success");
  assertEquals(result.result.available, false); // no foodProfileContext in baseContext
});

Deno.test("dispatchTool rejects an invalid section for get_user_food_profile", async () => {
  const result = await dispatchTool(
    "get_user_food_profile",
    { sections: ["not_a_real_section"] },
    baseContext,
  );
  assertEquals(result.status, "error");
  assertEquals(result.result.errorType, "INVALID_TOOL_ARGUMENTS");
});

Deno.test("dispatchTool rejects out-of-range radius instead of clamping", async () => {
  const result = await dispatchTool(
    "search_nearby_places",
    { placeTypes: ["cafe"], radiusMeters: 20001 },
    baseContext,
  );
  assertEquals(result.status, "error");
  assertEquals(result.result.errorType, "INVALID_TOOL_ARGUMENTS");
});
