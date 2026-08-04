import { mizAiError } from "./errors.ts";
import type {
  IncomingHistoryTurn,
  IncomingLocation,
  IncomingRequest,
  IncomingSelectedCity,
  MizAiRequest,
  RawFoodProfileContext,
} from "./types.ts";

export const MAX_MESSAGE_LENGTH = 1000;
export const MAX_HISTORY_TURNS = 12;
export const MAX_HISTORY_TURN_LENGTH = 1000;
export const MAX_MENU_CONTEXT_LENGTH = 4000;
/** Stage 4's lightweight menu follow-up chat gets a much tighter sliding
 * window than a normal conversation, regardless of what the client sends —
 * this is what actually keeps its token cost low, not just client
 * discipline. See docs/CENTRAL_FOOD_CATALOG.md-adjacent menu assistant notes. */
export const MAX_MENU_FOLLOWUP_HISTORY_TURNS = 5;
const SUPPORTED_LOCALES = new Set(["en", "de", "fa"]);

function isFiniteNumber(value: unknown): value is number {
  return typeof value === "number" && Number.isFinite(value);
}

function isPlainObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function validateLocation(value: unknown): IncomingLocation | null {
  if (value === undefined || value === null) return null;
  if (!isPlainObject(value)) {
    throw mizAiError("INVALID_REQUEST", "location must be an object");
  }
  const { latitude, longitude, accuracyMeters } = value;
  if (!isFiniteNumber(latitude) || latitude < -90 || latitude > 90) {
    throw mizAiError("INVALID_REQUEST", "location.latitude out of range");
  }
  if (!isFiniteNumber(longitude) || longitude < -180 || longitude > 180) {
    throw mizAiError("INVALID_REQUEST", "location.longitude out of range");
  }
  const result: IncomingLocation = { latitude, longitude };
  if (accuracyMeters !== undefined) {
    if (!isFiniteNumber(accuracyMeters) || accuracyMeters < 0) {
      throw mizAiError("INVALID_REQUEST", "location.accuracyMeters invalid");
    }
    result.accuracyMeters = accuracyMeters;
  }
  return result;
}

function validateSelectedCity(value: unknown): IncomingSelectedCity | null {
  if (value === undefined || value === null) return null;
  if (!isPlainObject(value)) {
    throw mizAiError("INVALID_REQUEST", "selectedCity must be an object");
  }
  const { name, latitude, longitude } = value;
  if (typeof name !== "string" || name.trim().length === 0 || name.length > 120) {
    throw mizAiError("INVALID_REQUEST", "selectedCity.name invalid");
  }
  if (!isFiniteNumber(latitude) || latitude < -90 || latitude > 90) {
    throw mizAiError("INVALID_REQUEST", "selectedCity.latitude out of range");
  }
  if (!isFiniteNumber(longitude) || longitude < -180 || longitude > 180) {
    throw mizAiError("INVALID_REQUEST", "selectedCity.longitude out of range");
  }
  return { name: name.trim(), latitude, longitude };
}

function validateHistory(value: unknown): IncomingHistoryTurn[] {
  if (value === undefined || value === null) return [];
  if (!Array.isArray(value)) {
    throw mizAiError("INVALID_REQUEST", "history must be an array");
  }
  if (value.length > MAX_HISTORY_TURNS) {
    throw mizAiError("INVALID_REQUEST", "history exceeds maximum length");
  }
  return value.map((turn, index) => {
    if (!isPlainObject(turn)) {
      throw mizAiError("INVALID_REQUEST", `history[${index}] must be an object`);
    }
    const { role, text } = turn;
    if (role !== "user" && role !== "assistant") {
      throw mizAiError("INVALID_REQUEST", `history[${index}].role invalid`);
    }
    if (typeof text !== "string" || text.length > MAX_HISTORY_TURN_LENGTH) {
      throw mizAiError("INVALID_REQUEST", `history[${index}].text invalid`);
    }
    // A user turn is always a typed message, so empty text there means a
    // malformed request. An assistant turn can legitimately have no text —
    // this function itself returns `message: ""` when a reply is only a
    // requiresLocation signal or a card-only place list (see
    // gemini_loop.ts) — so a client replaying that turn back as history
    // must not be rejected for it.
    if (role === "user" && text.trim().length === 0) {
      throw mizAiError("INVALID_REQUEST", `history[${index}].text invalid`);
    }
    return { role, text };
  });
}

function validateMenuContext(value: unknown): string | null {
  if (value === undefined || value === null) return null;
  if (typeof value !== "string") {
    throw mizAiError("INVALID_REQUEST", "menuContext must be a string");
  }
  const trimmed = value.trim();
  if (trimmed.length === 0) return null;
  return trimmed.slice(0, MAX_MENU_CONTEXT_LENGTH);
}

function validateFoodProfileContext(value: unknown): RawFoodProfileContext | null {
  if (value === undefined || value === null) return null;
  if (!isPlainObject(value)) {
    throw mizAiError("INVALID_REQUEST", "foodProfileContext must be an object");
  }
  return value as RawFoodProfileContext;
}

/** Validates and clamps the raw client payload. Never trusts a client-supplied user id. */
export function parseMizAiRequest(raw: unknown): MizAiRequest {
  if (!isPlainObject(raw)) {
    throw mizAiError("INVALID_REQUEST", "request body must be a JSON object");
  }
  const body = raw as IncomingRequest;

  if (typeof body.message !== "string") {
    throw mizAiError("INVALID_REQUEST", "message is required");
  }
  const message = body.message.trim();
  if (message.length === 0) {
    throw mizAiError("INVALID_REQUEST", "message must not be empty");
  }
  if (message.length > MAX_MESSAGE_LENGTH) {
    throw mizAiError("INVALID_REQUEST", "message exceeds maximum length");
  }

  let conversationId: string | null = null;
  if (body.conversationId !== undefined && body.conversationId !== null) {
    if (typeof body.conversationId !== "string" || body.conversationId.length > 200) {
      throw mizAiError("INVALID_REQUEST", "conversationId invalid");
    }
    conversationId = body.conversationId;
  }

  let locale = "en";
  if (body.locale !== undefined && body.locale !== null) {
    if (typeof body.locale !== "string" || !SUPPORTED_LOCALES.has(body.locale)) {
      throw mizAiError("INVALID_REQUEST", "locale unsupported");
    }
    locale = body.locale;
  }

  const menuContext = validateMenuContext(body.menuContext);
  let history = validateHistory(body.history);
  if (menuContext !== null && history.length > MAX_MENU_FOLLOWUP_HISTORY_TURNS) {
    // Enforced server-side, not just by client discipline — this is what
    // actually keeps Stage 4's token cost bounded.
    history = history.slice(history.length - MAX_MENU_FOLLOWUP_HISTORY_TURNS);
  }

  return {
    message,
    conversationId,
    history,
    location: validateLocation(body.location),
    selectedCity: validateSelectedCity(body.selectedCity),
    locale,
    foodProfileContext: validateFoodProfileContext(body.foodProfileContext),
    menuContext,
  };
}
