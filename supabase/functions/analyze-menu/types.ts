import type { RawFoodProfileContext } from "../miz-ai/types.ts";
import type {
  DishSafetyReason,
  DishSafetyStatus,
  PriceValueIndicator,
} from "./safety_classifier.ts";

export interface IncomingMenuImage {
  mimeType?: unknown;
  data?: unknown;
}

export interface MenuAnalysisRequest {
  locale: "en" | "de" | "fa";
  images: Array<{ mimeType: string; data: string }>;
  foodProfileContext: RawFoodProfileContext | null;
}

// ---------------------------------------------------------------------------
// Stage 1 — bare vision extraction (Gemini JSON-only, no dietary/allergen
// guessing — see vision_parser.ts).
// ---------------------------------------------------------------------------

export interface ExtractedMenuItem {
  extractedName: string;
  /** The printed price as extracted text, or null if not printed. Parsed
   * to a number (if possible) downstream for the price indicator. */
  price: string | null;
}

export interface ExtractedMenuCategory {
  name: string;
  items: ExtractedMenuItem[];
}

export interface VisionParseResult {
  readable: boolean;
  detectedLanguage: string | null;
  currency: string | null;
  categories: ExtractedMenuCategory[];
}

// ---------------------------------------------------------------------------
// Stage 2/3 — matched + classified + UI-ready dish.
// ---------------------------------------------------------------------------

export interface MatchedDish {
  extractedName: string;
  price: number | null;
  priceIndicator: PriceValueIndicator;
  /** Null when no Mizzz catalog match cleared the confidence threshold —
   * the UI must render a plainer fallback card, never a fabricated match. */
  matchedFoodId: string | null;
  matchedName: string | null;
  shortDescription: string | null;
  imagePath: string | null;
  matchConfidence: number | null;
  /** Null alongside matchedFoodId — safety can't be classified without a
   * trusted catalog record. */
  safetyStatus: DishSafetyStatus | null;
  safetyReasons: DishSafetyReason[];
  safetyCertain: boolean;
}

export interface MenuAnalysisCategoryResult {
  name: string;
  dishes: MatchedDish[];
}

export interface MenuAnalysisResult {
  readable: boolean;
  detectedLanguage: string | null;
  currency: string | null;
  categories: MenuAnalysisCategoryResult[];
  /** Non-fatal notes for the UI, e.g. "pairing suggestions and ingredient
   * lists are not available from the current catalog." Never a substitute
   * for a real error response. */
  notes: string[];
}
