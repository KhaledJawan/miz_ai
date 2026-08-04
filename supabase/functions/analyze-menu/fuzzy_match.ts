/// Deterministic local string-similarity scoring, used to re-rank and
/// gate Mizzz catalog search candidates for one extracted menu-item name.
/// Mizzz's `food_catalog_v1_search` already does its own trigram/alias/
/// full-text ranking server-side (`score` field) — this module cross-checks
/// that with a second, independent local signal (normalized Levenshtein
/// ratio) so a low-confidence remote match never gets accepted just because
/// it was the top result of a weak query.

function normalize(value: string): string {
  return value
    .toLowerCase()
    .normalize("NFKD")
    .replace(/[\u0300-\u036f]/g, "") // strip combining diacritics (é -> e, ü -> u)
    .replace(/[^a-z0-9\s]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

/** Classic edit-distance, iterative two-row implementation (O(n*m) time,
 * O(min(n,m)) space) — no external dependency, bounded input lengths make
 * this cheap (menu item names are never more than ~120 chars). */
function levenshteinDistance(a: string, b: string): number {
  if (a === b) return 0;
  if (a.length === 0) return b.length;
  if (b.length === 0) return a.length;
  let previousRow = Array.from({ length: b.length + 1 }, (_, i) => i);
  for (let i = 0; i < a.length; i++) {
    const currentRow = [i + 1];
    for (let j = 0; j < b.length; j++) {
      const insertCost = currentRow[j] + 1;
      const deleteCost = previousRow[j + 1] + 1;
      const substituteCost = previousRow[j] + (a[i] === b[j] ? 0 : 1);
      currentRow.push(Math.min(insertCost, deleteCost, substituteCost));
    }
    previousRow = currentRow;
  }
  return previousRow[b.length];
}

/** 1.0 = identical (after normalization), 0.0 = completely dissimilar. */
export function similarityRatio(a: string, b: string): number {
  const normalizedA = normalize(a);
  const normalizedB = normalize(b);
  if (!normalizedA && !normalizedB) return 1;
  if (!normalizedA || !normalizedB) return 0;
  const maxLength = Math.max(normalizedA.length, normalizedB.length);
  const distance = levenshteinDistance(normalizedA, normalizedB);
  return 1 - distance / maxLength;
}

export interface FuzzyMatchCandidate {
  id: string;
  name: string;
  remoteScore: number;
}

export interface FuzzyMatchResult<T extends FuzzyMatchCandidate> {
  candidate: T;
  localSimilarity: number;
  /** Weighted blend of Mizzz's own ranking score and the independent local
   * string similarity — never trusts either signal alone. */
  combinedConfidence: number;
}

const REMOTE_SCORE_WEIGHT = 0.4;
const LOCAL_SIMILARITY_WEIGHT = 0.6;

/** Returns the best candidate, or null if nothing clears the minimum bar —
 * the caller must treat null as "no confident match" and fall back
 * gracefully (see requirements: never force a low-confidence match). */
export function bestFuzzyMatch<T extends FuzzyMatchCandidate>(
  extractedName: string,
  candidates: readonly T[],
  minConfidence = 0.55,
): FuzzyMatchResult<T> | null {
  let best: FuzzyMatchResult<T> | null = null;
  for (const candidate of candidates) {
    const localSimilarity = similarityRatio(extractedName, candidate.name);
    const remoteScore = Math.min(Math.max(candidate.remoteScore, 0), 1);
    const combinedConfidence = remoteScore * REMOTE_SCORE_WEIGHT +
      localSimilarity * LOCAL_SIMILARITY_WEIGHT;
    if (!best || combinedConfidence > best.combinedConfidence) {
      best = { candidate, localSimilarity, combinedConfidence };
    }
  }
  if (!best || best.combinedConfidence < minConfidence) return null;
  return best;
}
