import { assertEquals } from "jsr:@std/assert@1";
import { matchAndClassifyCategories } from "./stage2_matcher.ts";
import type { ExtractedMenuCategory } from "./types.ts";
import type { TrustedFoodProfileContext } from "../miz-ai/types.ts";

Deno.env.set("MIZZZ_SUPABASE_URL", "https://example-mizzz.supabase.co");
Deno.env.set("MIZZZ_SUPABASE_ANON_KEY", "test-anon-key");

function jsonResponse(body: unknown): Response {
  return new Response(JSON.stringify(body), { status: 200 });
}

/** Routes by RPC function name so search vs detail return different
 * canned data, keyed by the query/food id used in these tests. */
function stubFetcher(
  searchResults: Record<string, unknown[]>,
  details: Record<string, unknown>,
): typeof fetch {
  return (url, init) => {
    const path = url.toString();
    const body = JSON.parse(init!.body as string);
    if (path.endsWith("food_catalog_v1_search")) {
      return Promise.resolve(jsonResponse(searchResults[body.p_query] ?? []));
    }
    if (path.endsWith("food_catalog_v1_detail")) {
      const detail = details[body.p_food_id];
      return Promise.resolve(jsonResponse(detail ?? null));
    }
    return Promise.resolve(jsonResponse(null));
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

Deno.test("matchAndClassifyCategories: a confident match is enriched with catalog data and classified", async () => {
  const categories: ExtractedMenuCategory[] = [
    { name: "Mains", items: [{ extractedName: "Sauerbraten", price: "18.50" }] },
  ];
  const fetcher = stubFetcher(
    {
      "Sauerbraten": [{
        id: "f1",
        name: "Sauerbraten",
        score: 0.95,
        description: null,
        category: null,
        image_path: null,
        match_type: "exact",
      }],
    },
    {
      "f1": {
        id: "f1",
        name: "Sauerbraten",
        shortDescription: "d",
        foodType: "dish",
        halalStatus: "halal",
        vegetarianStatus: "not_vegetarian",
        veganStatus: "not_vegan",
        alcoholStatus: "does_not_contain",
        spicyLevel: 0,
        imagePath: null,
        version: 1,
      },
    },
  );
  const { categories: result } = await matchAndClassifyCategories(
    categories,
    profile({ strictRestrictions: ["halalRequired"] }),
    "en",
    Date.now() + 10000,
    fetcher,
  );
  assertEquals(result.length, 1);
  const dish = result[0].dishes[0];
  assertEquals(dish.matchedFoodId, "f1");
  assertEquals(dish.safetyStatus, "safe");
  assertEquals(dish.price, 18.5);
});

Deno.test("matchAndClassifyCategories: no search results leaves the item unmatched, never dropped", async () => {
  const categories: ExtractedMenuCategory[] = [
    { name: "Mains", items: [{ extractedName: "Mystery Dish", price: "12" }] },
  ];
  const fetcher = stubFetcher({}, {});
  const { categories: result } = await matchAndClassifyCategories(
    categories,
    null,
    "en",
    Date.now() + 10000,
    fetcher,
  );
  assertEquals(result.length, 1);
  assertEquals(result[0].dishes.length, 1);
  assertEquals(result[0].dishes[0].matchedFoodId, null);
  assertEquals(result[0].dishes[0].safetyStatus, null);
});

Deno.test("matchAndClassifyCategories: a single item's failed lookup never fails the whole scan", async () => {
  const categories: ExtractedMenuCategory[] = [
    {
      name: "Mains",
      items: [{ extractedName: "Sauerbraten", price: "18" }, {
        extractedName: "Currywurst",
        price: "9",
      }],
    },
  ];
  const fetcher: typeof fetch = (_url, init) => {
    const body = JSON.parse(init!.body as string);
    if (body.p_query === "Sauerbraten") return Promise.reject(new TypeError("boom"));
    return Promise.resolve(jsonResponse([]));
  };
  const { categories: result } = await matchAndClassifyCategories(
    categories,
    null,
    "en",
    Date.now() + 10000,
    fetcher,
  );
  assertEquals(result[0].dishes.length, 2);
  assertEquals(result[0].dishes.every((d) => d.matchedFoodId === null), true);
});

Deno.test("matchAndClassifyCategories: caps total matched items at 40 across all categories", async () => {
  const items = Array.from({ length: 25 }, (_, i) => ({ extractedName: `Dish ${i}`, price: null }));
  const categories: ExtractedMenuCategory[] = [
    { name: "A", items },
    { name: "B", items },
  ];
  const fetcher = stubFetcher({}, {});
  const { categories: result, truncated } = await matchAndClassifyCategories(
    categories,
    null,
    "en",
    Date.now() + 10000,
    fetcher,
  );
  const totalDishes = result.reduce((sum, c) => sum + c.dishes.length, 0);
  assertEquals(totalDishes, 40);
  assertEquals(truncated, true);
});

Deno.test("matchAndClassifyCategories: price indicator is computed per-category from matched prices", async () => {
  const categories: ExtractedMenuCategory[] = [
    {
      name: "Mains",
      items: [
        { extractedName: "A", price: "10" },
        { extractedName: "B", price: "20" },
        { extractedName: "C", price: "30" },
      ],
    },
  ];
  const fetcher = stubFetcher({}, {});
  const { categories: result } = await matchAndClassifyCategories(
    categories,
    null,
    "en",
    Date.now() + 10000,
    fetcher,
  );
  const dishes = result[0].dishes;
  const cheap = dishes.find((d) => d.extractedName === "A")!;
  const pricey = dishes.find((d) => d.extractedName === "C")!;
  assertEquals(cheap.priceIndicator, "good");
  assertEquals(pricey.priceIndicator, "very_high");
});

Deno.test("matchAndClassifyCategories: a genuinely unmatched dish is proposed as a new candidate", async () => {
  const categories: ExtractedMenuCategory[] = [
    { name: "Pasta / Carne", items: [{ extractedName: "Mystery Dish", price: "16.95" }] },
  ];
  const proposeCalls: Record<string, unknown>[] = [];
  const fetcher: typeof fetch = (url, init) => {
    const path = url.toString();
    const body = JSON.parse(init!.body as string);
    if (path.endsWith("food_catalog_v1_propose_candidate")) {
      proposeCalls.push(body);
      return Promise.resolve(jsonResponse({ status: "created" }));
    }
    return Promise.resolve(jsonResponse([]));
  };
  await matchAndClassifyCategories(categories, null, "en", Date.now() + 10000, fetcher);
  assertEquals(proposeCalls.length, 1);
  assertEquals(proposeCalls[0].p_canonical_name, "Mystery Dish");
  assertEquals(proposeCalls[0].p_category, "Pasta / Carne");
  assertEquals(proposeCalls[0].p_price, 16.95);
});

Deno.test("matchAndClassifyCategories: a failed lookup is never proposed as a new candidate", async () => {
  const categories: ExtractedMenuCategory[] = [
    { name: "Mains", items: [{ extractedName: "Sauerbraten", price: "18" }] },
  ];
  let proposeCalled = false;
  const fetcher: typeof fetch = (url) => {
    if (url.toString().endsWith("food_catalog_v1_propose_candidate")) {
      proposeCalled = true;
      return Promise.resolve(jsonResponse({ status: "created" }));
    }
    return Promise.reject(new TypeError("boom"));
  };
  await matchAndClassifyCategories(categories, null, "en", Date.now() + 10000, fetcher);
  assertEquals(proposeCalled, false);
});

Deno.test("matchAndClassifyCategories: a matched dish is never proposed as a new candidate", async () => {
  const categories: ExtractedMenuCategory[] = [
    { name: "Mains", items: [{ extractedName: "Sauerbraten", price: "18.50" }] },
  ];
  let proposeCalled = false;
  const fetcher = stubFetcher(
    {
      "Sauerbraten": [{
        id: "f1",
        name: "Sauerbraten",
        score: 0.95,
        description: null,
        category: null,
        image_path: null,
        match_type: "exact",
      }],
    },
    {
      "f1": {
        id: "f1",
        name: "Sauerbraten",
        shortDescription: "d",
        foodType: "dish",
        halalStatus: "halal",
        vegetarianStatus: "not_vegetarian",
        veganStatus: "not_vegan",
        alcoholStatus: "does_not_contain",
        spicyLevel: 0,
        imagePath: null,
        version: 1,
      },
    },
  );
  const wrapped: typeof fetch = (url, init) => {
    if (url.toString().endsWith("food_catalog_v1_propose_candidate")) proposeCalled = true;
    return fetcher(url, init);
  };
  await matchAndClassifyCategories(categories, null, "en", Date.now() + 10000, wrapped);
  assertEquals(proposeCalled, false);
});
