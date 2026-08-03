# Supabase Edge Functions — Miz

Related: [`docs/API.md`](API.md) §3, [`docs/SECURITY.md`](SECURITY.md), [`docs/DEPLOYMENT.md`](DEPLOYMENT.md).

Miz has three Edge Functions: `miz-ai`, the secure Gemini/function-calling chat backend; `analyze-food`, the bounded single-food-photo recognition backend; and `analyze-menu`, the bounded multi-page menu explanation backend. All run on Deno; local development and CI use the Deno and Supabase CLIs directly (`brew install deno`, `brew install supabase/tap/supabase`).

## Structure

```
supabase/
  config.toml                # Supabase CLI project config (local dev stack; not required for functions deploy)
  functions/
    deno.json                # fmt/test config shared by every function
    _shared/cors.ts          # CORS headers (Dashboard/browser testing convenience)
    miz-ai/
      index.ts               # HTTP entry: validate request, resolve identity, run the Gemini loop, return the response
      types.ts                # shared request/response/tool types
      errors.ts               # stable error codes + safe-response mapping (never leaks provider payloads)
      request_schema.ts       # inbound payload validation/clamping
      system_instruction.ts   # the Miz system prompt
      tools.ts                 # tool declarations, allowlist, per-tool argument validation, dispatch
      gemini_client.ts         # thin fetch wrapper for the Gemini Interactions API
      gemini_loop.ts           # bounded function-calling loop (max 3 rounds)
      observability.ts         # safe request-id/timing/tool-code logs, no user content
      places_client.ts         # Google Places (New) searchNearby/searchText
      food_profile.ts          # server-side re-validation of the client-supplied Food Profile context
      *_test.ts                 # Deno.test unit tests, fetch stubbed, zero live network calls
    analyze-food/
      index.ts                  # authenticated single-image entry, budgets, safe response/logging
      request_schema.ts         # MIME/base64/size/locale validation
      gemini_food_client.ts     # multimodal request + typed candidate validation
      types.ts                  # typed food request/result contract
      *_test.ts                 # validation/provider tests with stubbed fetch
    analyze-menu/
      index.ts                  # authenticated HTTP entry, request/body budgets, safe response/logging
      request_schema.ts         # page/MIME/base64/size/locale validation
      gemini_menu_client.ts     # multimodal Interactions request + structured/semantic output validation
      types.ts                  # typed menu request/result contract
      *_test.ts                 # validation/provider tests with stubbed fetch
```

## Required secrets

Set once per Supabase project (already done for this project — these commands are for reference/new environments):

```bash
supabase secrets set GEMINI_API_KEY=your-key-here
supabase secrets set GOOGLE_PLACES_API_KEY=your-key-here
# Optional — defaults to a current non-preview Flash model if unset:
supabase secrets set GEMINI_MODEL=gemini-3.6-flash
```

`SUPABASE_URL` and `SUPABASE_ANON_KEY` are injected automatically by the platform — never set manually. Secrets are read only via `Deno.env.get(...)` inside the function; they are never logged, never echoed in an error response, and never passed through Flutter defines.

## Local development

```bash
cd supabase/functions
deno fmt                    # format
deno fmt --check            # verify formatting in CI
deno check miz-ai/*.ts analyze-food/*.ts analyze-menu/*.ts _shared/*.ts
deno test --allow-env miz-ai/ analyze-food/ analyze-menu/
```

To run the function locally against your linked Supabase project (requires `supabase login` / `supabase link` once):

```bash
supabase functions serve miz-ai --env-file ./supabase/.env.local
```

`./supabase/.env.local` (git-ignored, not committed) should contain the same secret names as above for local testing only.

## Deployment

```bash
supabase link --project-ref YOUR_PROJECT_REF   # once per machine
supabase functions deploy miz-ai
supabase functions deploy analyze-food
supabase functions deploy analyze-menu
```

Deploying does not change the Flutter client — both Flutter adapters target whichever project `.env.json`'s `SUPABASE_URL` points at (see `docs/SUPABASE_SETUP.md`).

`supabase/config.toml` deliberately sets `verify_jwt = false` because current `sb_publishable_...` keys are not JWTs. This does **not** make the endpoint public: `client_auth.ts` validates the request's `apikey` against the platform-provided `SUPABASE_PUBLISHABLE_KEYS` map before reading the request body or calling Gemini. A separate valid user session JWT, when present, is resolved independently for user identity.

## Manual testing

Once secrets are set and the function is deployed, a quick smoke test with `curl` (replace `YOUR_PROJECT_REF` and `YOUR_ANON_KEY`):

```bash
curl -X POST "https://YOUR_PROJECT_REF.supabase.co/functions/v1/miz-ai" \
  -H "apikey: YOUR_PUBLISHABLE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "What is sushi?",
    "locale": "en"
  }'
```

Expect a JSON body shaped like `{"message": "...", "places": [], "toolExecutions": [], "requiresLocation": false, ...}` with no tool call (a general-knowledge question doesn't need one). Then test a location-dependent query without a location to confirm the `requiresLocation: true` short-circuit:

```bash
curl -X POST "https://YOUR_PROJECT_REF.supabase.co/functions/v1/miz-ai" \
  -H "apikey: YOUR_PUBLISHABLE_KEY" \
  -H "Content-Type: application/json" \
  -d '{"message": "Find a good café nearby", "locale": "en"}'
```

And a full search with a known city (Trier, per `kSupportedCityCoordinates`):

```bash
curl -X POST "https://YOUR_PROJECT_REF.supabase.co/functions/v1/miz-ai" \
  -H "apikey: YOUR_PUBLISHABLE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Find a good café nearby",
    "locale": "en",
    "selectedCity": {"name": "Trier", "latitude": 49.74999, "longitude": 6.63714}
  }'
```

From the app: run with `flutter run --dart-define-from-file=.env.json` (Supabase configured), open a chat, and send "Find sushi near me" — with no city selected yet, Home shows the location-required card; select a city and the same message resends automatically once, on that explicit action.

For food vision, open Camera → Food, take or choose a clear photo of one prepared dish, review the upload notice, then tap Identify food. Successful output shows up to three typed candidates and confidence in the app locale. For menu vision, open Camera (Menu is the default mode), take or choose a clear menu photo, review the upload notice, then tap Explain menu. The request accepts one to four supported image pages; successful output should show typed sections and dish cards. Photos are not written to Supabase Storage or a database.

## Reliability budgets and retries

`analyze-food` and `analyze-menu` each have a 70-second total budget and one provider attempt capped at 60 seconds. Food accepts one image and returns at most three candidates with a 1,024-token cap; menu allows at most four images, uses a 4,096-token cap, and bounds results to 12 sections and 60 dishes. Both reject oversized/unsupported payloads before the provider call, disable interaction storage, and deliberately avoid automatic multimodal retries; the user owns the explicit retry.

- Total Edge Function budget: 58 seconds.
- Gemini: up to 35 seconds per attempt, maximum two attempts. Retry only timeout, network failure, and 5xx; the retry drops conversation history and keeps only the current bounded message.
- Google Places: up to 12 seconds per attempt, maximum two attempts. Retry only timeout, network failure, and 5xx.
- Never retry authentication/configuration errors, 4xx validation failures, permission/location requirements, malformed tool arguments, or rate/quota responses.
- Maximums: 1,000-character message, 12 history turns, 3 tool rounds, 10 Places results, and 1,024 Gemini output tokens.

The model can propose only the two declared tools; server validation rejects unknown fields, unsupported enum values, duplicate list values, and out-of-range numeric filters. Unknown tool names are returned to Gemini as safe tool errors, while invented location-tool aliases without trusted location become `requiresLocation:true`. Provider envelopes and steps are runtime-checked before use. A failed narration never discards already validated Places results.

## Error and logging contract

Errors use `{success:false,errorCode,userMessage,retryAvailable,technicalMessage:null}`. The Flutter adapter also accepts the older nested error shape during rollout. Logs contain only an opaque request id, timestamp, selected model, duration, approved tool name (or `unknown`), success/failure, and stable error code. Prompts, history, food-profile content, exact coordinates, provider payloads, user ids, and API keys are never logged.

## Known limitations

- **Distributed client rate limiting** is not yet implemented — provider 429s are handled distinctly and request/cost budgets are enforced, but Edge Function isolates are stateless; a real per-user limiter needs reviewed external state.
- **No automated live end-to-end test exists in this repo** — Deno tests stub every external call by design (no paid API calls in automated tests). The deployed `analyze-menu` function has been smoke-tested with a non-menu image and returned `readable:false`; `analyze-food` has been smoke-tested with the bundled Margherita pizza and returned bounded candidates. Chat/Places and future deployments still require the documented manual `curl` or in-app checks by whoever controls the live project.
- `requiresClarification`/`clarificationQuestion` are parsed from the wire format for forward compatibility, but Gemini's clarifying questions today arrive as normal assistant text (per the system instruction), not a distinct structured signal — there's no dedicated clarification UI beyond the normal message bubble.
