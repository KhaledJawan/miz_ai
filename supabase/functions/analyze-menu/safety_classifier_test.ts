import { assertEquals } from "jsr:@std/assert@1";
import type { TrustedFoodProfileContext } from "../miz-ai/types.ts";
import { calculatePriceValueIndicator, classifyDishSafety } from "./safety_classifier.ts";
import type { MizzzCatalogDetail } from "./mizzz_catalog_client.ts";

function dish(overrides: Partial<MizzzCatalogDetail> = {}): MizzzCatalogDetail {
  return {
    id: "food-1",
    name: "Test Dish",
    shortDescription: null,
    foodType: "dish",
    halalStatus: "unknown",
    vegetarianStatus: "unknown",
    veganStatus: "unknown",
    alcoholStatus: "unknown",
    spicyLevel: null,
    imagePath: null,
    version: 1,
    ...overrides,
  };
}

function profile(overrides: Partial<TrustedFoodProfileContext> = {}): TrustedFoodProfileContext {
  return {
    dietType: null,
    strictRestrictions: [],
    allergies: [],
    intolerances: [],
    dislikedIngredients: [],
    likedCuisines: [],
    curiousCuisines: [],
    spiceLevel: null,
    adventurousness: null,
    ...overrides,
  };
}

Deno.test("classifyDishSafety: no profile is always safe with no reasons", () => {
  const result = classifyDishSafety(dish({ halalStatus: "not_halal" }), null);
  assertEquals(result.status, "safe");
  assertEquals(result.reasons.length, 0);
  assertEquals(result.certain, true);
});

Deno.test("classifyDishSafety: halalRequired + not_halal is restricted, certain", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "not_halal" }),
    profile({ strictRestrictions: ["halalRequired"] }),
  );
  assertEquals(result.status, "restricted");
  assertEquals(result.certain, true);
  assertEquals(result.reasons.some((r) => r.code === "notHalal"), true);
});

Deno.test("classifyDishSafety: halalRequired + halal is safe", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "halal" }),
    profile({ strictRestrictions: ["halalRequired"] }),
  );
  assertEquals(result.status, "safe");
});

Deno.test("classifyDishSafety: halalRequired + unknown is restricted and uncertain (never claim safety on missing data)", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "unknown" }),
    profile({ strictRestrictions: ["halalRequired"] }),
  );
  assertEquals(result.status, "restricted");
  assertEquals(result.certain, false);
});

Deno.test("classifyDishSafety: halalPreferred (soft) + depends_on_recipe is only a warning, never restricted", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "depends_on_recipe" }),
    profile({ strictRestrictions: ["halalPreferred"] }),
  );
  assertEquals(result.status, "warning");
});

Deno.test("classifyDishSafety: noPork + not_halal is restricted", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "not_halal" }),
    profile({ strictRestrictions: ["noPork"] }),
  );
  assertEquals(result.status, "restricted");
});

Deno.test("classifyDishSafety: vegan dietType + not_vegan is restricted", () => {
  const result = classifyDishSafety(
    dish({ veganStatus: "not_vegan" }),
    profile({ dietType: "vegan" }),
  );
  assertEquals(result.status, "restricted");
  assertEquals(result.reasons.some((r) => r.code === "notVegan"), true);
});

Deno.test("classifyDishSafety: vegan dietType + vegan status is safe", () => {
  const result = classifyDishSafety(
    dish({ veganStatus: "vegan", vegetarianStatus: "vegetarian" }),
    profile({ dietType: "vegan" }),
  );
  assertEquals(result.status, "safe");
});

Deno.test("classifyDishSafety: vegetarian dietType + not_vegetarian is restricted", () => {
  const result = classifyDishSafety(
    dish({ vegetarianStatus: "not_vegetarian" }),
    profile({ dietType: "vegetarian" }),
  );
  assertEquals(result.status, "restricted");
});

Deno.test("classifyDishSafety: noAlcohol + contains is restricted", () => {
  const result = classifyDishSafety(
    dish({ alcoholStatus: "contains" }),
    profile({ strictRestrictions: ["noAlcohol"] }),
  );
  assertEquals(result.status, "restricted");
});

Deno.test("classifyDishSafety: noAlcohol + may_contain is a warning, uncertain", () => {
  const result = classifyDishSafety(
    dish({ alcoholStatus: "may_contain" }),
    profile({ strictRestrictions: ["noAlcohol"] }),
  );
  assertEquals(result.status, "warning");
  assertEquals(result.certain, false);
});

Deno.test("classifyDishSafety: active allergies always add allergensNotVerifiable (v2 detail has no allergen data)", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "halal" }),
    profile({ allergies: [{ code: "peanuts", severity: "severe" }] }),
  );
  assertEquals(result.reasons.some((r) => r.code === "allergensNotVerifiable"), true);
  assertEquals(result.certain, false);
  assertEquals(result.status, "warning");
});

Deno.test("classifyDishSafety: restricted status is never downgraded by a later warning-only check", () => {
  const result = classifyDishSafety(
    dish({ halalStatus: "not_halal", alcoholStatus: "may_contain" }),
    profile({ strictRestrictions: ["halalRequired", "noAlcohol"] }),
  );
  assertEquals(result.status, "restricted");
});

Deno.test("calculatePriceValueIndicator: unknown with fewer than 3 category prices", () => {
  assertEquals(calculatePriceValueIndicator(10, [12]), "unknown");
  assertEquals(calculatePriceValueIndicator(null, [10, 12, 14]), "unknown");
});

Deno.test("calculatePriceValueIndicator: good/high/very_high relative to median", () => {
  const categoryPrices = [10, 12, 14, 16, 18]; // median 14
  assertEquals(calculatePriceValueIndicator(10, categoryPrices), "good");
  assertEquals(calculatePriceValueIndicator(14, categoryPrices), "good");
  assertEquals(calculatePriceValueIndicator(17, categoryPrices), "high");
  assertEquals(calculatePriceValueIndicator(20, categoryPrices), "very_high");
});
