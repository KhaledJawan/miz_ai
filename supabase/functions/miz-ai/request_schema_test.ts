import { assertEquals, assertThrows } from "jsr:@std/assert@1";
import { MizAiError } from "./errors.ts";
import { MAX_HISTORY_TURNS, MAX_MESSAGE_LENGTH, parseMizAiRequest } from "./request_schema.ts";

Deno.test("parseMizAiRequest accepts a minimal valid request", () => {
  const result = parseMizAiRequest({ message: "Find sushi near me" });
  assertEquals(result.message, "Find sushi near me");
  assertEquals(result.conversationId, null);
  assertEquals(result.history, []);
  assertEquals(result.location, null);
  assertEquals(result.selectedCity, null);
  assertEquals(result.locale, "en");
});

Deno.test("parseMizAiRequest rejects a non-object body", () => {
  assertThrows(() => parseMizAiRequest("just a string"), MizAiError);
  assertThrows(() => parseMizAiRequest(null), MizAiError);
  assertThrows(() => parseMizAiRequest([1, 2, 3]), MizAiError);
});

Deno.test("parseMizAiRequest rejects an empty or missing message", () => {
  assertThrows(() => parseMizAiRequest({}), MizAiError);
  assertThrows(() => parseMizAiRequest({ message: "" }), MizAiError);
  assertThrows(() => parseMizAiRequest({ message: "   " }), MizAiError);
  assertThrows(() => parseMizAiRequest({ message: 42 }), MizAiError);
});

Deno.test("parseMizAiRequest rejects a message over the maximum length", () => {
  const tooLong = "a".repeat(MAX_MESSAGE_LENGTH + 1);
  assertThrows(() => parseMizAiRequest({ message: tooLong }), MizAiError);
});

Deno.test("parseMizAiRequest accepts a message exactly at the maximum length", () => {
  const atLimit = "a".repeat(MAX_MESSAGE_LENGTH);
  const result = parseMizAiRequest({ message: atLimit });
  assertEquals(result.message.length, MAX_MESSAGE_LENGTH);
});

Deno.test("parseMizAiRequest rejects history longer than the maximum", () => {
  const history = Array.from({ length: MAX_HISTORY_TURNS + 1 }, () => ({
    role: "user",
    text: "hi",
  }));
  assertThrows(() => parseMizAiRequest({ message: "hello", history }), MizAiError);
});

Deno.test("parseMizAiRequest accepts history at the maximum length", () => {
  const history = Array.from({ length: MAX_HISTORY_TURNS }, (_, i) => ({
    role: i % 2 === 0 ? "user" : "assistant",
    text: `turn ${i}`,
  }));
  const result = parseMizAiRequest({ message: "hello", history });
  assertEquals(result.history.length, MAX_HISTORY_TURNS);
});

Deno.test("parseMizAiRequest rejects an invalid history role", () => {
  assertThrows(
    () => parseMizAiRequest({ message: "hi", history: [{ role: "system", text: "x" }] }),
    MizAiError,
  );
});

Deno.test("parseMizAiRequest rejects an empty-text user history turn", () => {
  assertThrows(
    () => parseMizAiRequest({ message: "hi", history: [{ role: "user", text: "" }] }),
    MizAiError,
  );
  assertThrows(
    () => parseMizAiRequest({ message: "hi", history: [{ role: "user", text: "   " }] }),
    MizAiError,
  );
});

Deno.test(
  "parseMizAiRequest accepts an empty-text assistant history turn " +
    '(this function itself returns message: "" for a requiresLocation or card-only reply, ' +
    "and a client resending that turn back as history must not be rejected for it)",
  () => {
    const result = parseMizAiRequest({
      message: "hi",
      history: [{ role: "assistant", text: "" }],
    });
    assertEquals(result.history, [{ role: "assistant", text: "" }]);
  },
);

Deno.test("parseMizAiRequest rejects out-of-range location coordinates", () => {
  assertThrows(
    () => parseMizAiRequest({ message: "hi", location: { latitude: 999, longitude: 0 } }),
    MizAiError,
  );
  assertThrows(
    () => parseMizAiRequest({ message: "hi", location: { latitude: 0, longitude: -200 } }),
    MizAiError,
  );
});

Deno.test("parseMizAiRequest accepts valid location with optional accuracy", () => {
  const result = parseMizAiRequest({
    message: "hi",
    location: { latitude: 49.75, longitude: 6.64, accuracyMeters: 500 },
  });
  assertEquals(result.location, { latitude: 49.75, longitude: 6.64, accuracyMeters: 500 });
});

Deno.test("parseMizAiRequest rejects a selectedCity missing coordinates", () => {
  assertThrows(
    () => parseMizAiRequest({ message: "hi", selectedCity: { name: "Trier" } }),
    MizAiError,
  );
});

Deno.test("parseMizAiRequest accepts a valid selectedCity", () => {
  const result = parseMizAiRequest({
    message: "hi",
    selectedCity: { name: "Trier", latitude: 49.75, longitude: 6.64 },
  });
  assertEquals(result.selectedCity, { name: "Trier", latitude: 49.75, longitude: 6.64 });
});

Deno.test("parseMizAiRequest rejects an unsupported locale", () => {
  assertThrows(() => parseMizAiRequest({ message: "hi", locale: "xx" }), MizAiError);
});

Deno.test("parseMizAiRequest accepts every supported locale", () => {
  for (const locale of ["en", "de", "fa"]) {
    const result = parseMizAiRequest({ message: "hi", locale });
    assertEquals(result.locale, locale);
  }
});

Deno.test("parseMizAiRequest never accepts a client-supplied user id field", () => {
  // deno-lint-ignore no-explicit-any
  const result: any = parseMizAiRequest({ message: "hi", userId: "should-be-ignored" });
  assertEquals("userId" in result, false);
});

Deno.test("parseMizAiRequest passes through an opaque foodProfileContext object", () => {
  const result = parseMizAiRequest({
    message: "hi",
    foodProfileContext: { dietType: "vegan" },
  });
  assertEquals(result.foodProfileContext, { dietType: "vegan" });
});
