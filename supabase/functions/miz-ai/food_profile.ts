import { mizAiError } from "./errors.ts";
import type {
  FoodProfileAllergy,
  FoodProfileSection,
  GetUserFoodProfileArgs,
  RawFoodProfileContext,
  TrustedFoodProfileContext,
} from "./types.ts";

const KNOWN_SECTIONS = new Set<FoodProfileSection>([
  "diet",
  "restrictions",
  "allergies",
  "intolerances",
  "ingredients",
  "cuisines",
  "flavors",
  "eating_style",
]);

const ALL_SECTIONS: FoodProfileSection[] = Array.from(KNOWN_SECTIONS);
const MAX_LIST_LENGTH = 30;
const MAX_STRING_LENGTH = 60;

function sanitizeString(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const trimmed = value.trim();
  if (trimmed.length === 0 || trimmed.length > MAX_STRING_LENGTH) return null;
  return trimmed;
}

function sanitizeStringList(value: unknown): string[] {
  if (!Array.isArray(value)) return [];
  const out: string[] = [];
  for (const entry of value) {
    const clean = sanitizeString(entry);
    if (clean) out.push(clean);
    if (out.length >= MAX_LIST_LENGTH) break;
  }
  return out;
}

function sanitizeAllergies(value: unknown): FoodProfileAllergy[] {
  if (!Array.isArray(value)) return [];
  const out: FoodProfileAllergy[] = [];
  for (const entry of value) {
    if (typeof entry !== "object" || entry === null) continue;
    const code = sanitizeString((entry as Record<string, unknown>).code);
    const severity = sanitizeString((entry as Record<string, unknown>).severity);
    if (code && severity) out.push({ code, severity });
    if (out.length >= MAX_LIST_LENGTH) break;
  }
  return out;
}

/**
 * The client computes this from its local (unsynced) Food Profile database
 * and sends it as part of the request — see docs/API.md and ADR on Food
 * Profile context. This function never trusts it verbatim: every field is
 * re-clamped to the same shape/length limits the client itself uses, so a
 * malformed or oversized payload can never reach Gemini or logs unbounded.
 */
export function sanitizeFoodProfileContext(
  raw: RawFoodProfileContext | null,
): TrustedFoodProfileContext | null {
  if (raw === null) return null;
  return {
    dietType: sanitizeString(raw.dietType),
    strictRestrictions: sanitizeStringList(raw.strictRestrictions),
    allergies: sanitizeAllergies(raw.allergies),
    intolerances: sanitizeStringList(raw.intolerances),
    dislikedIngredients: sanitizeStringList(raw.dislikedIngredients),
    likedCuisines: sanitizeStringList(raw.likedCuisines),
    curiousCuisines: sanitizeStringList(raw.curiousCuisines),
    spiceLevel: sanitizeString(raw.spiceLevel),
    adventurousness: sanitizeString(raw.adventurousness),
  };
}

export function validateGetUserFoodProfileArgs(raw: unknown): GetUserFoodProfileArgs {
  if (raw === null || raw === undefined) return { sections: ALL_SECTIONS };
  if (typeof raw !== "object" || Array.isArray(raw)) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "profile arguments must be an object");
  }
  const object = raw as Record<string, unknown>;
  if (Object.keys(object).some((key) => key !== "sections")) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "profile arguments contain unknown fields");
  }
  const sectionsRaw = object.sections;
  if (sectionsRaw === undefined) return { sections: ALL_SECTIONS };
  if (!Array.isArray(sectionsRaw)) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "profile sections must be an array");
  }
  if (sectionsRaw.length > ALL_SECTIONS.length) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "too many profile sections");
  }
  const sections: FoodProfileSection[] = [];
  for (const entry of sectionsRaw) {
    if (typeof entry !== "string" || !KNOWN_SECTIONS.has(entry as FoodProfileSection)) {
      throw mizAiError(
        "INVALID_TOOL_ARGUMENTS",
        `get_user_food_profile unknown section: ${String(entry)}`,
      );
    }
    sections.push(entry as FoodProfileSection);
  }
  if (new Set(sections).size !== sections.length) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "profile sections must be unique");
  }
  return { sections: sections.length > 0 ? sections : ALL_SECTIONS };
}

/**
 * Returns only the requested sections of the trusted context. Never
 * returns precise location or interaction logs — those never enter this
 * shape in the first place (see TrustedFoodProfileContext).
 */
export function executeGetUserFoodProfile(
  args: GetUserFoodProfileArgs,
  context: TrustedFoodProfileContext | null,
): Record<string, unknown> {
  if (context === null) {
    return { available: false, reason: "No Food Profile data was provided with this request." };
  }
  const sections = new Set(args.sections ?? ALL_SECTIONS);
  const result: Record<string, unknown> = { available: true };
  if (sections.has("diet")) result.dietType = context.dietType;
  if (sections.has("restrictions")) result.strictRestrictions = context.strictRestrictions;
  if (sections.has("allergies")) result.allergies = context.allergies;
  if (sections.has("intolerances")) result.intolerances = context.intolerances;
  if (sections.has("ingredients")) result.dislikedIngredients = context.dislikedIngredients;
  if (sections.has("cuisines")) {
    result.likedCuisines = context.likedCuisines;
    result.curiousCuisines = context.curiousCuisines;
  }
  if (sections.has("flavors")) result.spiceLevel = context.spiceLevel;
  if (sections.has("eating_style")) result.adventurousness = context.adventurousness;
  return result;
}
