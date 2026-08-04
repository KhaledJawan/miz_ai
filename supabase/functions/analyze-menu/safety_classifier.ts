import type { TrustedFoodProfileContext } from "../miz-ai/types.ts";
import type { MizzzCatalogDetail } from "./mizzz_catalog_client.ts";

/// Deterministic, AI-free dish safety classification — no Gemini call, no
/// probabilistic scoring. Mirrors the same non-negotiable principles as
/// `FoodEligibilityService` in the Flutter app: allergen/halal/dietary
/// facts never come from the model, severe cases are never downgraded,
/// and unknown data is never presented as "safe." See CLAUDE.md §11 and
/// docs/CENTRAL_FOOD_CATALOG.md "Non-negotiable safety rules."
///
/// This operates on a *different* data shape than FoodEligibilityService
/// (Mizzz's catalog halal/vegetarian/vegan/alcohol enums + the user's
/// label-based strictRestrictions/allergies, rather than Miz AI's local
/// ingredient-id graph) since the two systems have separate id spaces —
/// see docs/CENTRAL_FOOD_CATALOG.md "Miz AI integration boundary."

export type DishSafetyStatus = "safe" | "warning" | "restricted";

export interface DishSafetyReason {
  /** Stable code, never a free-text sentence — the UI localizes this. */
  code: string;
  detail?: string;
}

export interface DishSafetyResult {
  status: DishSafetyStatus;
  reasons: DishSafetyReason[];
  /** True only when every relevant field was a definite, non-"unknown"/
   * non-"depends_on_recipe" value — the UI must show uncertainty otherwise
   * (never claim allergy/halal certainty on incomplete data). */
  certain: boolean;
}

const HALAL_STRICT_CODES = new Set(["halalRequired"]);
const HALAL_SOFT_CODES = new Set(["halalPreferred"]);
const PORK_RESTRICTION_CODES = new Set(["noPork"]);
const ALCOHOL_FREE_CODES = new Set(["noAlcohol"]);

function hasAny(restrictions: readonly string[], codes: Set<string>): boolean {
  return restrictions.some((code) => codes.has(code));
}

/**
 * `restrictions` is `TrustedFoodProfileContext.strictRestrictions` — food
 * rule codes the user marked as a *required* (not merely preferred)
 * restriction. Soft/preferred rules only ever produce a warning, never an
 * exclusion, matching FoodEligibilityService's own severity handling.
 */
export function classifyDishSafety(
  dish: MizzzCatalogDetail,
  profile: TrustedFoodProfileContext | null,
): DishSafetyResult {
  const reasons: DishSafetyReason[] = [];
  let status: DishSafetyStatus = "safe";
  let certain = true;

  const restrictions = profile?.strictRestrictions ?? [];
  const requiresHalal = hasAny(restrictions, HALAL_STRICT_CODES);
  const prefersHalal = hasAny(restrictions, HALAL_SOFT_CODES);
  const noPork = hasAny(restrictions, PORK_RESTRICTION_CODES);
  const requiresAlcoholFree = hasAny(restrictions, ALCOHOL_FREE_CODES);
  // dietType (not a strictRestrictions code) is where vegetarian/vegan
  // actually lives — see FoodProfile.dietType / buildFoodProfileAiContext.
  const requiresVegan = profile?.dietType === "vegan";
  const requiresVegetarian = requiresVegan || profile?.dietType === "vegetarian";

  const escalate = (next: DishSafetyStatus) => {
    if (next === "restricted") status = "restricted";
    else if (next === "warning" && status !== "restricted") status = "warning";
  };

  if (requiresHalal || noPork) {
    if (dish.halalStatus === "not_halal") {
      escalate("restricted");
      reasons.push({ code: "notHalal", detail: dish.halalStatus });
    } else if (dish.halalStatus === "halal") {
      // Definite match — no reason needed, nothing to warn about.
    } else if (dish.halalStatus === "usually_halal" || dish.halalStatus === "depends_on_recipe") {
      escalate(requiresHalal ? "restricted" : "warning");
      reasons.push({ code: "halalUncertain", detail: dish.halalStatus });
      certain = false;
    } else {
      // "unknown" — never claim safety on missing data.
      escalate(requiresHalal ? "restricted" : "warning");
      reasons.push({ code: "halalUnknown" });
      certain = false;
    }
  } else if (prefersHalal && dish.halalStatus !== "halal") {
    escalate("warning");
    reasons.push({ code: "halalPreferenceNotMet", detail: dish.halalStatus });
    if (dish.halalStatus === "unknown" || dish.halalStatus === "depends_on_recipe") certain = false;
  }

  if (requiresVegan) {
    if (dish.veganStatus === "not_vegan") {
      escalate("restricted");
      reasons.push({ code: "notVegan" });
    } else if (dish.veganStatus !== "vegan") {
      escalate("restricted");
      reasons.push({ code: "veganUncertain", detail: dish.veganStatus });
      certain = false;
    }
  } else if (requiresVegetarian) {
    if (dish.vegetarianStatus === "not_vegetarian") {
      escalate("restricted");
      reasons.push({ code: "notVegetarian" });
    } else if (dish.vegetarianStatus !== "vegetarian") {
      escalate("restricted");
      reasons.push({ code: "vegetarianUncertain", detail: dish.vegetarianStatus });
      certain = false;
    }
  }

  if (requiresAlcoholFree) {
    if (dish.alcoholStatus === "contains" || dish.alcoholStatus === "typically_contains") {
      escalate("restricted");
      reasons.push({ code: "containsAlcohol", detail: dish.alcoholStatus });
    } else if (dish.alcoholStatus === "may_contain" || dish.alcoholStatus === "depends_on_recipe") {
      escalate("warning");
      reasons.push({ code: "mayContainAlcohol", detail: dish.alcoholStatus });
      certain = false;
    } else if (dish.alcoholStatus === "unknown") {
      escalate("warning");
      reasons.push({ code: "alcoholUnknown" });
      certain = false;
    }
  }

  // Allergies: the catalog v2 read contract (food_catalog_v1_detail) does
  // not currently expose allergen labels, only dietary/halal/alcohol
  // status. Surface this honestly rather than silently skipping it —
  // never claim an allergy was checked when it wasn't.
  if ((profile?.allergies.length ?? 0) > 0) {
    reasons.push({ code: "allergensNotVerifiable" });
    certain = false;
    if (status === "safe") status = "warning";
  }

  return { status, reasons, certain };
}

/** A 3-tier traffic-light signal (the UI renders this as a colored $ mark):
 * "good" covers at-or-below-typical prices, "high" is noticeably above
 * typical, "very_high" is well above. Never a claim about objective fair
 * pricing -- purely relative to the median of other matched items in the
 * same category from this same menu scan. */
export type PriceValueIndicator = "good" | "high" | "very_high" | "unknown";

export function calculatePriceValueIndicator(
  price: number | null,
  categoryPrices: readonly number[],
): PriceValueIndicator {
  if (price === null || categoryPrices.length < 3) return "unknown";
  const sorted = [...categoryPrices].sort((a, b) => a - b);
  const mid = Math.floor(sorted.length / 2);
  const median = sorted.length % 2 === 0 ? (sorted[mid - 1] + sorted[mid]) / 2 : sorted[mid];
  if (median <= 0) return "unknown";
  const ratio = price / median;
  if (ratio > 1.4) return "very_high";
  if (ratio > 1.15) return "high";
  return "good";
}
