// Shared types for the miz-ai Edge Function. No `any` — every boundary
// (client request, Gemini response, Places response) is a plain, narrow
// interface validated by the corresponding module before use.

export interface IncomingHistoryTurn {
  role: "user" | "assistant";
  text: string;
}

export interface IncomingLocation {
  latitude: number;
  longitude: number;
  accuracyMeters?: number;
}

export interface IncomingSelectedCity {
  name: string;
  latitude: number;
  longitude: number;
}

/** Raw client payload, before validation. Every field is untrusted. */
export interface IncomingRequest {
  message?: unknown;
  conversationId?: unknown;
  history?: unknown;
  location?: unknown;
  selectedCity?: unknown;
  locale?: unknown;
  foodProfileContext?: unknown;
}

/** Validated, clamped request — safe to use everywhere else in the function. */
export interface MizAiRequest {
  message: string;
  conversationId: string | null;
  history: IncomingHistoryTurn[];
  location: IncomingLocation | null;
  selectedCity: IncomingSelectedCity | null;
  locale: string;
  foodProfileContext: RawFoodProfileContext | null;
}

/** Client-supplied minimized Food Profile snapshot, before server re-validation. */
export interface RawFoodProfileContext {
  dietType?: unknown;
  strictRestrictions?: unknown;
  allergies?: unknown;
  intolerances?: unknown;
  dislikedIngredients?: unknown;
  likedCuisines?: unknown;
  curiousCuisines?: unknown;
  spiceLevel?: unknown;
  adventurousness?: unknown;
}

export interface FoodProfileAllergy {
  code: string;
  severity: string;
}

/** Server-trusted, re-validated Food Profile summary — the only shape tools ever see. */
export interface TrustedFoodProfileContext {
  dietType: string | null;
  strictRestrictions: string[];
  allergies: FoodProfileAllergy[];
  intolerances: string[];
  dislikedIngredients: string[];
  likedCuisines: string[];
  curiousCuisines: string[];
  spiceLevel: string | null;
  adventurousness: string | null;
}

export type PlaceType =
  | "restaurant"
  | "cafe"
  | "bakery"
  | "bar"
  | "fast_food";

export interface SearchNearbyPlacesArgs {
  placeTypes: PlaceType[];
  query?: string;
  radiusMeters?: number;
  openNow?: boolean;
  minimumRating?: number;
  sortBy?: "relevance" | "distance" | "rating";
}

export type FoodProfileSection =
  | "diet"
  | "restrictions"
  | "allergies"
  | "intolerances"
  | "ingredients"
  | "cuisines"
  | "flavors"
  | "eating_style";

export interface GetUserFoodProfileArgs {
  sections?: FoodProfileSection[];
}

export interface NormalizedPlace {
  id: string;
  name: string;
  address: string;
  latitude: number;
  longitude: number;
  rating: number | null;
  reviewCount: number | null;
  openNow: boolean | null;
  primaryType: string | null;
  types: string[];
  distanceMeters: number | null;
  photoReference: null;
}

export interface SearchNearbyPlacesResult {
  places: NormalizedPlace[];
  searchCenter: { source: "current_location" | "selected_city"; city: string | null };
  appliedFilters: { radiusMeters: number; openNow: boolean | null };
}

/** Trusted context assembled server-side, never influenced by model output. */
export interface ToolExecutionContext {
  location: IncomingLocation | null;
  selectedCity: IncomingSelectedCity | null;
  foodProfileContext: TrustedFoodProfileContext | null;
  locale: string;
  /** Derived from the Supabase JWT, never a client-supplied field. `null` for guests. */
  userId: string | null;
  /** Absolute request deadline. Provider/tool timeouts may never exceed it. */
  deadlineMs: number;
  /** Opaque correlation id used in safe logs; never derived from user input. */
  requestId: string;
}

export type MizAiErrorCode =
  | "AI_CONFIGURATION_ERROR"
  | "AI_TIMEOUT"
  | "AI_UNAVAILABLE"
  | "AI_RATE_LIMIT"
  | "AI_QUOTA_EXCEEDED"
  | "PLACES_CONFIGURATION_ERROR"
  | "PLACES_TIMEOUT"
  | "PLACES_UNAVAILABLE"
  | "PLACES_QUOTA_EXCEEDED"
  | "LOCATION_REQUIRED"
  | "NO_RESULTS"
  | "INVALID_TOOL_CALL"
  | "INVALID_TOOL_ARGUMENTS"
  | "TOOL_LOOP_LIMIT"
  | "SERVER_ERROR"
  | "INVALID_REQUEST";

export interface ToolExecutionRecord {
  name: string;
  status: "success" | "error";
}

export interface MizAiResponse {
  message: string;
  conversationId: string | null;
  places: NormalizedPlace[];
  toolExecutions: ToolExecutionRecord[];
  requiresLocation: boolean;
  requiresClarification: boolean;
  clarificationQuestion: string | null;
  usage: { inputTokens: number | null; outputTokens: number | null };
}

export interface MizAiErrorResponse {
  success: false;
  errorCode: MizAiErrorCode;
  userMessage: string;
  retryAvailable: boolean;
  technicalMessage: null;
}
