import { assertEquals, assertThrows } from "jsr:@std/assert@1";
import { MizAiError } from "./errors.ts";
import { requireValidClientKey } from "./client_auth.ts";

function environment(values: Record<string, string>): (name: string) => string | undefined {
  return (name) => values[name];
}

Deno.test("client auth accepts a named publishable key", () => {
  const request = new Request("https://example.test", {
    headers: { apikey: "sb_publishable_valid" },
  });

  requireValidClientKey(
    request,
    environment({
      SUPABASE_PUBLISHABLE_KEYS: JSON.stringify({ default: "sb_publishable_valid" }),
    }),
  );
});

Deno.test("client auth accepts the local and legacy low-privilege fallbacks", () => {
  for (const name of ["SUPABASE_PUBLISHABLE_KEY", "SUPABASE_ANON_KEY"]) {
    const request = new Request("https://example.test", {
      headers: { apikey: "local-client-key" },
    });
    requireValidClientKey(request, environment({ [name]: "local-client-key" }));
  }
});

Deno.test("client auth rejects a missing or incorrect key", () => {
  const configured = environment({
    SUPABASE_PUBLISHABLE_KEYS: JSON.stringify({ default: "sb_publishable_valid" }),
  });

  for (
    const request of [
      new Request("https://example.test"),
      new Request("https://example.test", { headers: { apikey: "wrong" } }),
    ]
  ) {
    const error = assertThrows(() => requireValidClientKey(request, configured), MizAiError);
    assertEquals((error as MizAiError).code, "INVALID_REQUEST");
    assertEquals((error as MizAiError).httpStatus, 401);
  }
});

Deno.test("client auth fails closed when the project key environment is absent", () => {
  const request = new Request("https://example.test", {
    headers: { apikey: "anything" },
  });

  const error = assertThrows(() => requireValidClientKey(request, environment({})), MizAiError);
  assertEquals((error as MizAiError).code, "AI_CONFIGURATION_ERROR");
  assertEquals((error as MizAiError).httpStatus, 503);
});
