import { mizAiError } from "./errors.ts";

type EnvironmentReader = (name: string) => string | undefined;

function configuredPublishableKeys(readEnvironment: EnvironmentReader): string[] {
  const keys: string[] = [];
  const encodedKeys = readEnvironment("SUPABASE_PUBLISHABLE_KEYS");
  if (encodedKeys) {
    try {
      const decoded: unknown = JSON.parse(encodedKeys);
      if (decoded && typeof decoded === "object" && !Array.isArray(decoded)) {
        for (const value of Object.values(decoded)) {
          if (typeof value === "string" && value.trim()) keys.push(value.trim());
        }
      }
    } catch (_error) {
      throw mizAiError("AI_CONFIGURATION_ERROR", "invalid SUPABASE_PUBLISHABLE_KEYS JSON");
    }
  }

  // Local CLI and older projects may expose one key instead of the hosted
  // named-key JSON map. Legacy anon remains low-privilege and RLS-bound.
  for (const name of ["SUPABASE_PUBLISHABLE_KEY", "SUPABASE_ANON_KEY"]) {
    const value = readEnvironment(name)?.trim();
    if (value) keys.push(value);
  }
  return [...new Set(keys)];
}

function equalKey(first: string, second: string): boolean {
  if (first.length !== second.length) return false;
  let difference = 0;
  for (let index = 0; index < first.length; index++) {
    difference |= first.charCodeAt(index) ^ second.charCodeAt(index);
  }
  return difference === 0;
}

/// Validates the public application credential after Supabase's legacy JWT
/// gateway check is disabled for new `sb_publishable_...` keys. This does not
/// authenticate a user; user identity still comes from a valid session JWT.
export function requireValidClientKey(
  request: Request,
  readEnvironment: EnvironmentReader = Deno.env.get,
): void {
  const configuredKeys = configuredPublishableKeys(readEnvironment);
  if (configuredKeys.length === 0) {
    throw mizAiError("AI_CONFIGURATION_ERROR", "no Supabase publishable key configured");
  }

  const suppliedKey = request.headers.get("apikey")?.trim();
  if (!suppliedKey || !configuredKeys.some((key) => equalKey(key, suppliedKey))) {
    throw mizAiError("INVALID_REQUEST", "missing or invalid client apikey", 401);
  }
}
