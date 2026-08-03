import type { MizAiErrorCode, MizAiErrorResponse } from "./types.ts";

/**
 * The only error surface exposed to Flutter. Every catch site in this
 * function maps whatever it caught to one of these — a provider payload,
 * stack trace, or raw exception message never reaches the client.
 */
export class MizAiError extends Error {
  readonly code: MizAiErrorCode;
  readonly httpStatus: number;
  readonly retryAvailable: boolean;

  constructor(
    code: MizAiErrorCode,
    safeMessage: string,
    httpStatus = 400,
    retryAvailable = false,
  ) {
    super(safeMessage);
    this.code = code;
    this.httpStatus = httpStatus;
    this.retryAvailable = retryAvailable;
  }
}

const SAFE_MESSAGES: Record<MizAiErrorCode, string> = {
  AI_CONFIGURATION_ERROR: "The assistant is temporarily unavailable.",
  AI_TIMEOUT: "The assistant took too long to respond. Please try again.",
  AI_UNAVAILABLE: "The assistant is temporarily unavailable.",
  AI_RATE_LIMIT: "The assistant is busy right now. Please try again shortly.",
  AI_QUOTA_EXCEEDED: "The assistant is busy right now. Please try again shortly.",
  PLACES_CONFIGURATION_ERROR: "Place search is temporarily unavailable.",
  PLACES_TIMEOUT: "Place search took too long. Please try again.",
  PLACES_UNAVAILABLE: "Place search is temporarily unavailable.",
  PLACES_QUOTA_EXCEEDED: "Place search is busy right now. Please try again shortly.",
  LOCATION_REQUIRED: "A location is needed to search nearby places.",
  NO_RESULTS: "No matching places were found.",
  INVALID_TOOL_CALL: "The assistant made an invalid request internally.",
  INVALID_TOOL_ARGUMENTS: "The assistant could not use the requested search filters.",
  TOOL_LOOP_LIMIT: "The assistant could not complete this request. Please rephrase it.",
  SERVER_ERROR: "Something went wrong. Please try again.",
  INVALID_REQUEST: "The request could not be processed.",
};

const STATUS_BY_CODE: Record<MizAiErrorCode, number> = {
  AI_CONFIGURATION_ERROR: 503,
  AI_TIMEOUT: 504,
  AI_UNAVAILABLE: 503,
  AI_RATE_LIMIT: 429,
  AI_QUOTA_EXCEEDED: 429,
  PLACES_CONFIGURATION_ERROR: 503,
  PLACES_TIMEOUT: 504,
  PLACES_UNAVAILABLE: 503,
  PLACES_QUOTA_EXCEEDED: 429,
  LOCATION_REQUIRED: 200, // handled as a normal structured response, not a hard error
  NO_RESULTS: 200,
  INVALID_TOOL_CALL: 502,
  INVALID_TOOL_ARGUMENTS: 422,
  TOOL_LOOP_LIMIT: 502,
  SERVER_ERROR: 500,
  INVALID_REQUEST: 400,
};

const RETRYABLE_CODES = new Set<MizAiErrorCode>([
  "AI_TIMEOUT",
  "AI_UNAVAILABLE",
  "AI_RATE_LIMIT",
  "AI_QUOTA_EXCEEDED",
  "PLACES_TIMEOUT",
  "PLACES_UNAVAILABLE",
  "PLACES_QUOTA_EXCEEDED",
  "SERVER_ERROR",
]);

export function mizAiError(
  code: MizAiErrorCode,
  detail?: string,
  httpStatus = STATUS_BY_CODE[code],
): MizAiError {
  // `detail` is deliberately not logged here: expected model/tool failures
  // are recoverable. The request boundary logs only code/timing metadata.
  void detail;
  return new MizAiError(code, SAFE_MESSAGES[code], httpStatus, RETRYABLE_CODES.has(code));
}

export function toSafeResponse(error: unknown): { body: MizAiErrorResponse; status: number } {
  if (error instanceof MizAiError) {
    return {
      body: {
        success: false,
        errorCode: error.code,
        userMessage: error.message,
        retryAvailable: error.retryAvailable,
        technicalMessage: null,
      },
      status: error.httpStatus,
    };
  }
  // Unexpected values are reported to the client as SERVER_ERROR only.
  // The request boundary records safe correlation metadata.
  void error;
  return {
    body: {
      success: false,
      errorCode: "SERVER_ERROR",
      userMessage: SAFE_MESSAGES.SERVER_ERROR,
      retryAvailable: true,
      technicalMessage: null,
    },
    status: 500,
  };
}
