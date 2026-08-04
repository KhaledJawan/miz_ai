import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { MizAiError } from "../miz-ai/errors.ts";
import {
  getMizzzCatalogDetail,
  proposeMizzzCatalogCandidate,
  searchMizzzCatalog,
} from "./mizzz_catalog_client.ts";

Deno.env.set("MIZZZ_SUPABASE_URL", "https://example-mizzz.supabase.co");
Deno.env.set("MIZZZ_SUPABASE_ANON_KEY", "test-anon-key");

function fetchStub(response: Response): typeof fetch {
  return () => Promise.resolve(response);
}

function jsonResponse(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "content-type": "application/json" },
  });
}

Deno.test("searchMizzzCatalog sends the query, language, and limit as p_ params", async () => {
  let capturedBody: unknown;
  let capturedHeaders: Headers | undefined;
  const fetcher: typeof fetch = (_url, init) => {
    capturedBody = JSON.parse(init!.body as string);
    capturedHeaders = new Headers(init!.headers);
    return Promise.resolve(jsonResponse([]));
  };
  await searchMizzzCatalog("Sauerbraten", { languageCode: "de", limit: 5, fetcher });
  assertEquals(capturedBody, {
    p_query: "Sauerbraten",
    p_language_code: "de",
    p_item_type: null,
    p_limit: 5,
  });
  assertEquals(capturedHeaders?.get("apikey"), "test-anon-key");
});

Deno.test("searchMizzzCatalog returns an empty array for an empty query without calling the network", async () => {
  let called = false;
  const fetcher: typeof fetch = () => {
    called = true;
    return Promise.resolve(jsonResponse([]));
  };
  const result = await searchMizzzCatalog("   ", { fetcher });
  assertEquals(result, []);
  assertEquals(called, false);
});

Deno.test("searchMizzzCatalog parses valid rows and drops malformed ones", async () => {
  const fetcher = fetchStub(jsonResponse([
    {
      id: "1",
      name: "Sauerbraten",
      description: "d",
      category: "Mains",
      image_path: null,
      match_type: "alias",
      score: 0.9,
    },
    { id: "2" }, // missing name/score -- dropped
    "not an object", // dropped
  ]));
  const result = await searchMizzzCatalog("sauerbraten", { fetcher });
  assertEquals(result.length, 1);
  assertEquals(result[0].id, "1");
  assertEquals(result[0].score, 0.9);
});

Deno.test("searchMizzzCatalog maps 401/403 to AI_CONFIGURATION_ERROR", async () => {
  const fetcher = fetchStub(new Response("unauthorized", { status: 401 }));
  await assertRejects(
    () => searchMizzzCatalog("x", { fetcher }),
    MizAiError,
  );
});

Deno.test("searchMizzzCatalog maps 429 to AI_RATE_LIMIT", async () => {
  const fetcher = fetchStub(new Response("rate limited", { status: 429 }));
  try {
    await searchMizzzCatalog("x", { fetcher });
    throw new Error("expected rejection");
  } catch (error) {
    if (!(error instanceof MizAiError)) throw error;
    assertEquals(error.code, "AI_RATE_LIMIT");
  }
});

Deno.test("searchMizzzCatalog never throws for a network failure -- maps to AI_UNAVAILABLE", async () => {
  const fetcher: typeof fetch = () => Promise.reject(new TypeError("network down"));
  try {
    await searchMizzzCatalog("x", { fetcher });
    throw new Error("expected rejection");
  } catch (error) {
    if (!(error instanceof MizAiError)) throw error;
    assertEquals(error.code, "AI_UNAVAILABLE");
  }
});

Deno.test("getMizzzCatalogDetail returns null for a non-object/malformed body", async () => {
  const fetcher = fetchStub(jsonResponse(null));
  const result = await getMizzzCatalogDetail("food-1", { fetcher });
  assertEquals(result, null);
});

Deno.test("getMizzzCatalogDetail parses the full dietary/halal/alcohol shape", async () => {
  const fetcher = fetchStub(jsonResponse({
    id: "food-1",
    name: "Sauerbraten",
    shortDescription: "Marinated pot roast",
    foodType: "dish",
    halalStatus: "depends_on_recipe",
    vegetarianStatus: "not_vegetarian",
    veganStatus: "not_vegan",
    alcoholStatus: "does_not_contain",
    spicyLevel: 0,
    imagePath: "foods/food-1/original.webp",
    version: 3,
  }));
  const result = await getMizzzCatalogDetail("food-1", { fetcher });
  assertEquals(result?.halalStatus, "depends_on_recipe");
  assertEquals(result?.version, 3);
});

Deno.test("proposeMizzzCatalogCandidate sends name/category/language/price as p_ params", async () => {
  let capturedBody: unknown;
  let capturedPath = "";
  const fetcher: typeof fetch = (url, init) => {
    capturedPath = url.toString();
    capturedBody = JSON.parse(init!.body as string);
    return Promise.resolve(jsonResponse({ status: "created", proposalId: "p-1" }));
  };
  await proposeMizzzCatalogCandidate("Orecchiette di Manzo", {
    category: "Pasta / Carne",
    languageCode: "de",
    price: 16.95,
    fetcher,
  });
  assertEquals(capturedPath.endsWith("food_catalog_v1_propose_candidate"), true);
  assertEquals(capturedBody, {
    p_canonical_name: "Orecchiette di Manzo",
    p_category: "Pasta / Carne",
    p_language_code: "de",
    p_price: 16.95,
  });
});

Deno.test("proposeMizzzCatalogCandidate never calls the network for a too-short name", async () => {
  let called = false;
  const fetcher: typeof fetch = () => {
    called = true;
    return Promise.resolve(jsonResponse({ status: "created" }));
  };
  await proposeMizzzCatalogCandidate(" a ", { fetcher });
  assertEquals(called, false);
});

Deno.test("proposeMizzzCatalogCandidate propagates a server failure to the caller", async () => {
  const fetcher = fetchStub(new Response("", { status: 500 }));
  await assertRejects(
    () => proposeMizzzCatalogCandidate("A New Dish", { fetcher }),
    MizAiError,
  );
});

Deno.test("readMizzzCatalogConfig / callers throw AI_CONFIGURATION_ERROR when secrets are missing", async () => {
  const originalUrl = Deno.env.get("MIZZZ_SUPABASE_URL");
  const originalKey = Deno.env.get("MIZZZ_SUPABASE_ANON_KEY");
  Deno.env.delete("MIZZZ_SUPABASE_URL");
  Deno.env.delete("MIZZZ_SUPABASE_ANON_KEY");
  try {
    await assertRejects(() => searchMizzzCatalog("x"), MizAiError);
  } finally {
    if (originalUrl) Deno.env.set("MIZZZ_SUPABASE_URL", originalUrl);
    if (originalKey) Deno.env.set("MIZZZ_SUPABASE_ANON_KEY", originalKey);
  }
});
