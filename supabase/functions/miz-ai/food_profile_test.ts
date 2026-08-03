import { assertEquals, assertThrows } from "jsr:@std/assert@1";
import {
  executeGetUserFoodProfile,
  sanitizeFoodProfileContext,
  validateGetUserFoodProfileArgs,
} from "./food_profile.ts";

Deno.test("sanitizeFoodProfileContext returns null for null input", () => {
  assertEquals(sanitizeFoodProfileContext(null), null);
});

Deno.test("sanitizeFoodProfileContext keeps allergies separate from dislikes", () => {
  const result = sanitizeFoodProfileContext({
    allergies: [{ code: "peanut", severity: "severe" }],
    dislikedIngredients: ["mushroom"],
  });
  assertEquals(result?.allergies, [{ code: "peanut", severity: "severe" }]);
  assertEquals(result?.dislikedIngredients, ["mushroom"]);
});

Deno.test("sanitizeFoodProfileContext drops malformed allergy entries instead of throwing", () => {
  const result = sanitizeFoodProfileContext({
    allergies: [{ code: "peanut" }, "not-an-object", { severity: "mild" }, 42],
  });
  assertEquals(result?.allergies, []);
});

Deno.test("sanitizeFoodProfileContext clamps oversized lists", () => {
  const manyItems = Array.from({ length: 100 }, (_, i) => `cuisine-${i}`);
  const result = sanitizeFoodProfileContext({ likedCuisines: manyItems });
  assertEquals(result?.likedCuisines.length, 30);
});

Deno.test("sanitizeFoodProfileContext drops non-string / oversized scalar fields", () => {
  const result = sanitizeFoodProfileContext({
    dietType: "a".repeat(200),
    spiceLevel: 5,
  });
  assertEquals(result?.dietType, null);
  assertEquals(result?.spiceLevel, null);
});

Deno.test("validateGetUserFoodProfileArgs defaults to every section when omitted", () => {
  const args = validateGetUserFoodProfileArgs(undefined);
  assertEquals(args.sections?.length, 8);
});

Deno.test("validateGetUserFoodProfileArgs rejects an unknown section", () => {
  assertThrows(() => validateGetUserFoodProfileArgs({ sections: ["diet", "medical_history"] }));
});

Deno.test("validateGetUserFoodProfileArgs accepts a valid subset", () => {
  const args = validateGetUserFoodProfileArgs({ sections: ["allergies", "intolerances"] });
  assertEquals(args.sections, ["allergies", "intolerances"]);
});

Deno.test("executeGetUserFoodProfile reports unavailable when no context was supplied", () => {
  const result = executeGetUserFoodProfile({ sections: ["diet"] }, null);
  assertEquals(result.available, false);
});

Deno.test("executeGetUserFoodProfile returns only the requested sections", () => {
  const context = sanitizeFoodProfileContext({
    dietType: "omnivore",
    allergies: [{ code: "peanut", severity: "severe" }],
    likedCuisines: ["italian"],
  })!;
  const result = executeGetUserFoodProfile({ sections: ["allergies"] }, context);
  assertEquals(result.available, true);
  assertEquals("allergies" in result, true);
  assertEquals("dietType" in result, false);
  assertEquals("likedCuisines" in result, false);
});

Deno.test("executeGetUserFoodProfile never exposes precise location or interaction logs", () => {
  const context = sanitizeFoodProfileContext({ dietType: "vegan" })!;
  const result = executeGetUserFoodProfile({ sections: undefined }, context);
  assertEquals("latitude" in result, false);
  assertEquals("longitude" in result, false);
  assertEquals("interactionHistory" in result, false);
});
