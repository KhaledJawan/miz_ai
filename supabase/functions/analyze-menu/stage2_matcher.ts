import type { TrustedFoodProfileContext } from "../miz-ai/types.ts";
import { bestFuzzyMatch } from "./fuzzy_match.ts";
import {
  getMizzzCatalogDetail,
  proposeMizzzCatalogCandidate,
  searchMizzzCatalog,
} from "./mizzz_catalog_client.ts";
import { calculatePriceValueIndicator, classifyDishSafety } from "./safety_classifier.ts";
import type { ExtractedMenuCategory, MatchedDish, MenuAnalysisCategoryResult } from "./types.ts";

/// Stage 2 — deterministic local matching + database filtering. No Gemini
/// call happens anywhere in this file: every dish's dietary/safety facts
/// come from Mizzz's trusted catalog (via mizzz_catalog_client.ts) and are
/// classified by safety_classifier.ts's pure rule engine.

/** Global cap across all categories — bounds Mizzz network fan-out and
 * total latency regardless of how many items Stage 1 extracted. Matches
 * the item cap the previous single-call Gemini approach also used. */
const MAX_ITEMS_TO_MATCH = 40;
const MATCH_CONCURRENCY = 5;
const MIN_MATCH_CONFIDENCE = 0.55;

function parsePrice(raw: string | null): number | null {
  if (!raw) return null;
  const cleaned = raw.replace(/[^0-9.,]/g, "").replace(",", ".");
  const value = Number.parseFloat(cleaned);
  return Number.isFinite(value) ? value : null;
}

interface WorkItem {
  categoryIndex: number;
  categoryName: string;
  extractedName: string;
  price: number | null;
}

/** Best-effort only — a failed propose-candidate call must never affect
 * what's shown to the user, and never retries (a later scan of the same
 * dish will just try again). */
async function proposeCandidateIfNew(
  item: WorkItem,
  locale: string,
  fetcher: typeof fetch | undefined,
): Promise<void> {
  try {
    await proposeMizzzCatalogCandidate(item.extractedName, {
      category: item.categoryName,
      languageCode: locale,
      price: item.price,
      fetcher,
    });
  } catch (_error) {
    // Never fails the scan, and never surfaces to the user -- see
    // docs/EDGE_FUNCTIONS.md "New dishes are proposed silently."
  }
}

async function matchOneItem(
  item: WorkItem,
  profile: TrustedFoodProfileContext | null,
  locale: string,
  fetcher: typeof fetch | undefined,
  deadlineMs: number,
): Promise<Omit<MatchedDish, "priceIndicator">> {
  const base = {
    extractedName: item.extractedName,
    price: item.price,
    matchedFoodId: null,
    matchedName: null,
    shortDescription: null,
    imagePath: null,
    matchConfidence: null,
    safetyStatus: null,
    safetyReasons: [],
    safetyCertain: true,
  } satisfies Omit<MatchedDish, "priceIndicator">;

  if (Date.now() >= deadlineMs) return base;

  let candidates;
  try {
    candidates = await searchMizzzCatalog(item.extractedName, {
      languageCode: locale,
      limit: 5,
      fetcher,
    });
  } catch (_error) {
    // A single failed lookup must never fail the whole menu scan -- the
    // item still renders, just without a catalog match. This is a lookup
    // failure, not confirmation the dish is new, so it's never proposed.
    return base;
  }
  if (candidates.length === 0) {
    await proposeCandidateIfNew(item, locale, fetcher);
    return base;
  }

  const match = bestFuzzyMatch(
    item.extractedName,
    candidates.map((candidate) => ({
      id: candidate.id,
      name: candidate.name,
      remoteScore: candidate.score,
    })),
    MIN_MATCH_CONFIDENCE,
  );
  if (!match) {
    await proposeCandidateIfNew(item, locale, fetcher);
    return base;
  }

  let detail;
  try {
    detail = await getMizzzCatalogDetail(match.candidate.id, { languageCode: locale, fetcher });
  } catch (_error) {
    return base;
  }
  if (!detail) return base;

  const safety = classifyDishSafety(detail, profile);
  return {
    extractedName: item.extractedName,
    price: item.price,
    matchedFoodId: detail.id,
    matchedName: detail.name,
    shortDescription: detail.shortDescription,
    imagePath: detail.imagePath,
    matchConfidence: match.combinedConfidence,
    safetyStatus: safety.status,
    safetyReasons: safety.reasons,
    safetyCertain: safety.certain,
  };
}

async function processInBatches<T, R>(
  items: T[],
  concurrency: number,
  worker: (item: T) => Promise<R>,
): Promise<R[]> {
  const results: R[] = new Array(items.length);
  let cursor = 0;
  async function runNext(): Promise<void> {
    while (cursor < items.length) {
      const index = cursor++;
      results[index] = await worker(items[index]);
    }
  }
  await Promise.all(Array.from({ length: Math.min(concurrency, items.length) }, runNext));
  return results;
}

export async function matchAndClassifyCategories(
  categories: ExtractedMenuCategory[],
  profile: TrustedFoodProfileContext | null,
  locale: string,
  deadlineMs: number,
  fetcher?: typeof fetch,
): Promise<{ categories: MenuAnalysisCategoryResult[]; truncated: boolean }> {
  const work: WorkItem[] = [];
  for (const [categoryIndex, category] of categories.entries()) {
    for (const item of category.items) {
      if (work.length >= MAX_ITEMS_TO_MATCH) break;
      work.push({
        categoryIndex,
        categoryName: category.name,
        extractedName: item.extractedName,
        price: parsePrice(item.price),
      });
    }
    if (work.length >= MAX_ITEMS_TO_MATCH) break;
  }
  const truncated = categories.reduce((sum, c) => sum + c.items.length, 0) > work.length;

  const matched = await processInBatches(
    work,
    MATCH_CONCURRENCY,
    (item) => matchOneItem(item, profile, locale, fetcher, deadlineMs),
  );

  // Price indicator needs every item's price in its category first.
  const pricesByCategory = new Map<number, number[]>();
  for (const [i, item] of matched.entries()) {
    if (item.price === null) continue;
    const categoryIndex = work[i].categoryIndex;
    const list = pricesByCategory.get(categoryIndex) ?? [];
    list.push(item.price);
    pricesByCategory.set(categoryIndex, list);
  }

  const byCategory = new Map<number, MatchedDish[]>();
  for (const [i, item] of matched.entries()) {
    const categoryIndex = work[i].categoryIndex;
    const categoryPrices = pricesByCategory.get(categoryIndex) ?? [];
    const dish: MatchedDish = {
      ...item,
      priceIndicator: calculatePriceValueIndicator(item.price, categoryPrices),
    };
    const list = byCategory.get(categoryIndex) ?? [];
    list.push(dish);
    byCategory.set(categoryIndex, list);
  }

  const results: MenuAnalysisCategoryResult[] = [];
  for (const [categoryIndex, category] of categories.entries()) {
    const dishes = byCategory.get(categoryIndex);
    if (dishes && dishes.length > 0) results.push({ name: category.name, dishes });
  }
  return { categories: results, truncated };
}
