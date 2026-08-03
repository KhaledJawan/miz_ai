import { mizAiError } from "./errors.ts";
import { executeGetUserFoodProfile, validateGetUserFoodProfileArgs } from "./food_profile.ts";
import type { GeminiFunctionDeclaration } from "./gemini_client.ts";
import { searchNearbyPlaces } from "./places_client.ts";
import { logEvent } from "./observability.ts";
import type { PlaceType, SearchNearbyPlacesArgs, ToolExecutionContext } from "./types.ts";

const PLACE_TYPES: PlaceType[] = [
  "restaurant",
  "cafe",
  "bakery",
  "bar",
  "fast_food",
];

export const SUPPORTED_TOOLS = [
  "search_nearby_places",
  "get_user_food_profile",
] as const;

/**
 * Declared exactly as specified — no `latitude`/`longitude` field exists
 * anywhere in this schema, so Gemini cannot supply coordinates even if it
 * tried; the trusted center always comes from `ToolExecutionContext`
 * (server-derived, never model-derived).
 */
export const TOOL_DECLARATIONS: GeminiFunctionDeclaration[] = [
  {
    type: "function",
    name: "search_nearby_places",
    description:
      "Search real nearby restaurants, cafés, bakeries, bars, or takeaway locations using Google Places through the secured backend.",
    parameters: {
      type: "object",
      properties: {
        placeTypes: {
          type: "array",
          items: { type: "string", enum: PLACE_TYPES },
          minItems: 1,
          maxItems: PLACE_TYPES.length,
          uniqueItems: true,
        },
        query: {
          type: "string",
          minLength: 1,
          maxLength: 200,
          description: "Optional natural-language food, cuisine, or place query",
        },
        radiusMeters: { type: "integer", minimum: 500, maximum: 20000 },
        openNow: { type: "boolean" },
        minimumRating: { type: "number", minimum: 0, maximum: 5 },
        sortBy: { type: "string", enum: ["relevance", "distance", "rating"] },
      },
      required: ["placeTypes"],
      additionalProperties: false,
    },
  },
  {
    type: "function",
    name: "get_user_food_profile",
    description:
      "Return a safe, minimized, structured summary of the user's Food Profile for personalized food recommendations.",
    parameters: {
      type: "object",
      properties: {
        sections: {
          type: "array",
          maxItems: 8,
          uniqueItems: true,
          items: {
            type: "string",
            enum: [
              "diet",
              "restrictions",
              "allergies",
              "intolerances",
              "ingredients",
              "cuisines",
              "flavors",
              "eating_style",
            ],
          },
        },
      },
      additionalProperties: false,
    },
  },
];

export const TOOL_ALLOWLIST = new Set<string>(SUPPORTED_TOOLS);

function rejectUnknownFields(args: Record<string, unknown>, allowed: readonly string[]): void {
  const unknown = Object.keys(args).find((key) => !allowed.includes(key));
  if (unknown !== undefined) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", `unknown argument field: ${unknown}`);
  }
}

function validateSearchNearbyPlacesArgs(raw: unknown): SearchNearbyPlacesArgs {
  if (typeof raw !== "object" || raw === null || Array.isArray(raw)) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "search arguments must be an object");
  }
  const args = raw as Record<string, unknown>;
  rejectUnknownFields(args, [
    "placeTypes",
    "query",
    "radiusMeters",
    "openNow",
    "minimumRating",
    "sortBy",
  ]);
  const placeTypes = args.placeTypes;
  if (!Array.isArray(placeTypes) || placeTypes.length === 0) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "placeTypes must be a non-empty array");
  }
  if (placeTypes.length > PLACE_TYPES.length) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "too many placeTypes");
  }
  const validatedTypes: PlaceType[] = [];
  for (const type of placeTypes) {
    if (typeof type !== "string" || !PLACE_TYPES.includes(type as PlaceType)) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", `unsupported placeType: ${String(type)}`);
    }
    validatedTypes.push(type as PlaceType);
  }
  if (new Set(validatedTypes).size !== validatedTypes.length) {
    throw mizAiError("INVALID_TOOL_ARGUMENTS", "placeTypes must be unique");
  }

  const result: SearchNearbyPlacesArgs = { placeTypes: validatedTypes };

  if (args.query !== undefined) {
    if (
      typeof args.query !== "string" ||
      args.query.trim().length === 0 ||
      args.query.length > 200
    ) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "query invalid");
    }
    result.query = args.query.trim();
  }
  if (args.radiusMeters !== undefined) {
    if (typeof args.radiusMeters !== "number" || !Number.isFinite(args.radiusMeters)) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "radiusMeters invalid");
    }
    if (
      !Number.isInteger(args.radiusMeters) || args.radiusMeters < 500 || args.radiusMeters > 20000
    ) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "radiusMeters out of range");
    }
    result.radiusMeters = args.radiusMeters;
  }
  if (args.openNow !== undefined) {
    if (typeof args.openNow !== "boolean") {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "openNow invalid");
    }
    result.openNow = args.openNow;
  }
  if (args.minimumRating !== undefined) {
    if (typeof args.minimumRating !== "number" || !Number.isFinite(args.minimumRating)) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "minimumRating invalid");
    }
    if (args.minimumRating < 0 || args.minimumRating > 5) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "minimumRating out of range");
    }
    result.minimumRating = args.minimumRating;
  }
  if (args.sortBy !== undefined) {
    if (
      typeof args.sortBy !== "string" ||
      !["relevance", "distance", "rating"].includes(args.sortBy)
    ) {
      throw mizAiError("INVALID_TOOL_ARGUMENTS", "sortBy invalid");
    }
    result.sortBy = args.sortBy as SearchNearbyPlacesArgs["sortBy"];
  }

  return result;
}

export interface ToolDispatchResult {
  status: "success" | "error";
  result: Record<string, unknown>;
}

/**
 * The only place a tool name/arguments pair turns into real work. `name`
 * is checked against `TOOL_ALLOWLIST` by the caller (gemini_loop.ts)
 * before this is ever reached — this function additionally validates
 * every argument itself, so a name that's on the allowlist but has a
 * malformed payload still fails safely rather than reaching Google.
 */
export async function dispatchTool(
  name: string,
  rawArgs: unknown,
  context: ToolExecutionContext,
): Promise<ToolDispatchResult> {
  if (!TOOL_ALLOWLIST.has(name)) {
    logEvent(context.requestId, "tool_rejected", {
      tool: "unknown",
      errorCode: "INVALID_TOOL_CALL",
    });
    return {
      status: "error",
      result: {
        errorType: "INVALID_TOOL_CALL",
        error: "This tool is unavailable. Use only the declared application tools.",
      },
    };
  }

  const startedAt = Date.now();
  logEvent(context.requestId, "tool_requested", { tool: name });
  try {
    if (name === "search_nearby_places") {
      const args = validateSearchNearbyPlacesArgs(rawArgs);
      const result = await searchNearbyPlaces(args, context);
      logEvent(context.requestId, "tool_completed", {
        tool: name,
        success: true,
        durationMs: Date.now() - startedAt,
      });
      return { status: "success", result: result as unknown as Record<string, unknown> };
    }
    if (name === "get_user_food_profile") {
      const args = validateGetUserFoodProfileArgs(rawArgs);
      const result = executeGetUserFoodProfile(args, context.foodProfileContext);
      logEvent(context.requestId, "tool_completed", {
        tool: name,
        success: true,
        durationMs: Date.now() - startedAt,
      });
      return { status: "success", result };
    }
    return {
      status: "error",
      result: { errorType: "INVALID_TOOL_CALL", error: "This tool is unavailable." },
    };
  } catch (error) {
    if (error && typeof error === "object" && "code" in error) {
      // A MizAiError (e.g. LOCATION_REQUIRED, INVALID_TOOL_CALL) — surface
      // it as a structured tool failure rather than aborting the whole
      // request. The caller (gemini_loop.ts) special-cases
      // LOCATION_REQUIRED to short-circuit into a dedicated response
      // field instead of feeding it back to Gemini; every other tool
      // error is sent back as a function_result so Gemini can react
      // in-conversation ("I couldn't search — please try again").
      const code = (error as { code: string }).code;
      logEvent(context.requestId, "tool_completed", {
        tool: name,
        success: false,
        errorCode: code,
        durationMs: Date.now() - startedAt,
      });
      return { status: "error", result: { errorType: code } };
    }
    logEvent(context.requestId, "tool_completed", {
      tool: name,
      success: false,
      errorCode: "SERVER_ERROR",
      durationMs: Date.now() - startedAt,
    });
    return { status: "error", result: { errorType: "SERVER_ERROR" } };
  }
}
