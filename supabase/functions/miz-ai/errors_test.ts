import { assertEquals } from "jsr:@std/assert@1";
import { mizAiError, toSafeResponse } from "./errors.ts";

Deno.test("toSafeResponse maps a MizAiError to its code and status, no detail leaked", () => {
  const error = mizAiError("PLACES_QUOTA_EXCEEDED", "raw provider payload with secrets");
  const { body, status } = toSafeResponse(error);
  assertEquals(body.errorCode, "PLACES_QUOTA_EXCEEDED");
  assertEquals(status, 429);
  assertEquals(body.userMessage.includes("secrets"), false);
  assertEquals(body.userMessage.includes("raw provider payload"), false);
  assertEquals(body.technicalMessage, null);
});

Deno.test("toSafeResponse maps every declared code to a distinct safe status", () => {
  const codes = [
    "AI_CONFIGURATION_ERROR",
    "AI_TIMEOUT",
    "AI_UNAVAILABLE",
    "AI_RATE_LIMIT",
    "AI_QUOTA_EXCEEDED",
    "PLACES_CONFIGURATION_ERROR",
    "PLACES_TIMEOUT",
    "PLACES_UNAVAILABLE",
    "PLACES_QUOTA_EXCEEDED",
    "LOCATION_REQUIRED",
    "NO_RESULTS",
    "INVALID_TOOL_CALL",
    "INVALID_TOOL_ARGUMENTS",
    "TOOL_LOOP_LIMIT",
    "SERVER_ERROR",
    "INVALID_REQUEST",
  ] as const;
  for (const code of codes) {
    const { body } = toSafeResponse(mizAiError(code));
    assertEquals(body.errorCode, code);
  }
});

Deno.test("toSafeResponse never echoes an arbitrary thrown error's message", () => {
  const { body, status } = toSafeResponse(
    new Error("stack trace with /etc/passwd and API_KEY=xyz"),
  );
  assertEquals(body.errorCode, "SERVER_ERROR");
  assertEquals(status, 500);
  assertEquals(body.userMessage.includes("API_KEY"), false);
});

Deno.test("toSafeResponse handles a non-Error thrown value safely", () => {
  const { body, status } = toSafeResponse("a plain string throw");
  assertEquals(body.errorCode, "SERVER_ERROR");
  assertEquals(status, 500);
});
