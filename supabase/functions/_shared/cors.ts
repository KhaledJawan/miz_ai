// Standard Supabase Edge Function CORS helper. Mobile clients calling via
// supabase-flutter's FunctionsClient don't need this, but the Dashboard's
// function invoker and any future browser-based testing do.
export const CORS_HEADERS: Record<string, string> = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
