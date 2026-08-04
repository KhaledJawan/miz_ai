import { mizAiError } from "../miz-ai/errors.ts";

/// Read-only client for Mizzz's versioned Central Food Catalog HTTP
/// contract (`docs/CENTRAL_FOOD_CATALOG.md` "Miz AI integration boundary").
/// Calls only the two bounded, `anon`-grantable PostgREST RPC endpoints —
/// `food_catalog_v1_search` / `food_catalog_v1_detail` — with the lowest
/// privilege credential. This is the *only* place Miz AI talks to Mizzz's
/// project; no Mizzz credential ever reaches Flutter, and no other Mizzz
/// table/RPC is called from here.

export interface MizzzCatalogSearchResult {
  id: string;
  name: string;
  description: string | null;
  category: string | null;
  imagePath: string | null;
  matchType: string;
  score: number;
}

export interface MizzzCatalogDetail {
  id: string;
  name: string;
  shortDescription: string | null;
  foodType: string;
  halalStatus: string;
  vegetarianStatus: string;
  veganStatus: string;
  alcoholStatus: string;
  spicyLevel: number | null;
  imagePath: string | null;
  version: number;
}

export interface MizzzCatalogConfig {
  baseUrl: string;
  anonKey: string;
}

const REQUEST_TIMEOUT_MS = 6000;

export function readMizzzCatalogConfig(): MizzzCatalogConfig | null {
  const baseUrl = Deno.env.get("MIZZZ_SUPABASE_URL")?.trim();
  const anonKey = Deno.env.get("MIZZZ_SUPABASE_ANON_KEY")?.trim();
  if (!baseUrl || !anonKey) return null;
  return { baseUrl: baseUrl.replace(/\/+$/, ""), anonKey };
}

type Fetcher = typeof fetch;

async function callRpc(
  config: MizzzCatalogConfig,
  fn: string,
  body: Record<string, unknown>,
  fetcher: Fetcher,
): Promise<unknown> {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);
  let response: Response;
  try {
    response = await fetcher(`${config.baseUrl}/rest/v1/rpc/${fn}`, {
      method: "POST",
      headers: {
        "apikey": config.anonKey,
        "Authorization": `Bearer ${config.anonKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
      signal: controller.signal,
    });
  } catch (error) {
    const timedOut = error instanceof DOMException && error.name === "AbortError";
    throw mizAiError(
      timedOut ? "AI_TIMEOUT" : "AI_UNAVAILABLE",
      `mizzz catalog ${fn} ${timedOut ? "timed out" : "network failure"}`,
    );
  } finally {
    clearTimeout(timeout);
  }
  if (response.status === 401 || response.status === 403) {
    // Never surface this as a Gemini/AI error — it's a Miz AI-side
    // misconfiguration (missing/rotated secret), not a transient failure.
    throw mizAiError("AI_CONFIGURATION_ERROR", `mizzz catalog ${fn} auth failed`);
  }
  if (response.status === 429) {
    throw mizAiError("AI_RATE_LIMIT", `mizzz catalog ${fn} rate limited`);
  }
  if (!response.ok) {
    // Never echo Mizzz's raw error body to the client.
    throw mizAiError("AI_UNAVAILABLE", `mizzz catalog ${fn} failed: ${response.status}`);
  }
  return await response.json().catch(() => null);
}

function isPlainObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function toSearchResult(raw: unknown): MizzzCatalogSearchResult | null {
  if (!isPlainObject(raw)) return null;
  const id = raw.id;
  const name = raw.name;
  const score = raw.score;
  if (typeof id !== "string" || typeof name !== "string" || typeof score !== "number") {
    return null;
  }
  return {
    id,
    name,
    description: typeof raw.description === "string" ? raw.description : null,
    category: typeof raw.category === "string" ? raw.category : null,
    imagePath: typeof raw.image_path === "string" ? raw.image_path : null,
    matchType: typeof raw.match_type === "string" ? raw.match_type : "unknown",
    score,
  };
}

/** `food_catalog_v1_search` — trigram/alias/full-text hybrid search, already
 * ranked server-side by Mizzz. Never sends unbounded queries or page sizes. */
export async function searchMizzzCatalog(
  query: string,
  options: { languageCode?: string | null; limit?: number; fetcher?: Fetcher } = {},
): Promise<MizzzCatalogSearchResult[]> {
  const config = readMizzzCatalogConfig();
  if (!config) throw mizAiError("AI_CONFIGURATION_ERROR", "Mizzz catalog is not configured");
  const trimmed = query.trim().slice(0, 120);
  if (!trimmed) return [];
  const raw = await callRpc(config, "food_catalog_v1_search", {
    p_query: trimmed,
    p_language_code: options.languageCode ?? null,
    p_item_type: null,
    p_limit: Math.min(Math.max(options.limit ?? 5, 1), 20),
  }, options.fetcher ?? fetch);
  if (!Array.isArray(raw)) return [];
  const results: MizzzCatalogSearchResult[] = [];
  for (const entry of raw) {
    const parsed = toSearchResult(entry);
    if (parsed) results.push(parsed);
  }
  return results;
}

/** `food_catalog_v1_detail` — only verified, non-archived rows; returns the
 * dietary/halal/alcohol fields the deterministic safety classifier needs. */
export async function getMizzzCatalogDetail(
  foodId: string,
  options: { languageCode?: string | null; fetcher?: Fetcher } = {},
): Promise<MizzzCatalogDetail | null> {
  const config = readMizzzCatalogConfig();
  if (!config) throw mizAiError("AI_CONFIGURATION_ERROR", "Mizzz catalog is not configured");
  const raw = await callRpc(config, "food_catalog_v1_detail", {
    p_food_id: foodId,
    p_language_code: options.languageCode ?? null,
  }, options.fetcher ?? fetch);
  if (!isPlainObject(raw) || typeof raw.id !== "string" || typeof raw.name !== "string") {
    return null;
  }
  return {
    id: raw.id,
    name: raw.name,
    shortDescription: typeof raw.shortDescription === "string" ? raw.shortDescription : null,
    foodType: typeof raw.foodType === "string" ? raw.foodType : "dish",
    halalStatus: typeof raw.halalStatus === "string" ? raw.halalStatus : "unknown",
    vegetarianStatus: typeof raw.vegetarianStatus === "string" ? raw.vegetarianStatus : "unknown",
    veganStatus: typeof raw.veganStatus === "string" ? raw.veganStatus : "unknown",
    alcoholStatus: typeof raw.alcoholStatus === "string" ? raw.alcoholStatus : "unknown",
    spicyLevel: typeof raw.spicyLevel === "number" ? raw.spicyLevel : null,
    imagePath: typeof raw.imagePath === "string" ? raw.imagePath : null,
    version: typeof raw.version === "number" ? raw.version : 1,
  };
}

/** `food_catalog_v1_propose_candidate` — the one write RPC Miz AI is allowed
 * to call, and only for a dish that genuinely didn't match anything (never
 * on a failed/uncertain lookup). Submits name/category/price only — never a
 * description or any dietary fact, since Miz AI's vision step never invents
 * food knowledge (see CLAUDE.md AI rules). Mizzz dedupes by normalized name
 * and always creates a `pending` proposal, never an auto-approved one. */
export async function proposeMizzzCatalogCandidate(
  canonicalName: string,
  options: {
    category?: string | null;
    languageCode?: string | null;
    price?: number | null;
    fetcher?: Fetcher;
  } = {},
): Promise<void> {
  const config = readMizzzCatalogConfig();
  if (!config) throw mizAiError("AI_CONFIGURATION_ERROR", "Mizzz catalog is not configured");
  const trimmed = canonicalName.trim().slice(0, 150);
  if (trimmed.length < 2) return;
  await callRpc(config, "food_catalog_v1_propose_candidate", {
    p_canonical_name: trimmed,
    p_category: options.category?.trim().slice(0, 100) || null,
    p_language_code: options.languageCode ?? null,
    p_price: options.price ?? null,
  }, options.fetcher ?? fetch);
}
