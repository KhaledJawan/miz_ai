/** Safe, request-scoped logging. Callers may pass only bounded operational
 * metadata — never prompts, profile content, coordinates, provider payloads,
 * credentials, or user identifiers. */
export function logEvent(
  requestId: string,
  event: string,
  fields: Record<string, string | number | boolean | null> = {},
): void {
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    requestId,
    event,
    ...fields,
  }));
}
