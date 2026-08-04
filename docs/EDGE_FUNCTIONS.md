# Supabase Edge Functions — Miz

Related: [`docs/API.md`](API.md) §3, [`docs/SECURITY.md`](SECURITY.md), [`docs/DEPLOYMENT.md`](DEPLOYMENT.md).

Miz has four Edge Functions: `miz-ai`, the secure Gemini/function-calling chat backend; `analyze-food`, the bounded single-food-photo recognition backend; `analyze-menu`, the bounded multi-page menu explanation backend; and `classify-capture`, a small classification step (menu vs. single dish vs. unrecognized) that lets the camera screen route a photo to the right pipeline automatically, with no manual mode picker. All run on Deno; local development and CI use the Deno and Supabase CLIs directly (`brew install deno`, `brew install supabase/tap/supabase`).

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
      index.ts                  # authenticated HTTP entry: Stage 1 → Stage 2 → Stage 3, safe response/logging
      request_schema.ts         # page/MIME/base64/size/locale/foodProfileContext validation
      vision_parser.ts          # Stage 1 — JSON-only Gemini vision extraction (no dietary/allergen guessing)
      mizzz_catalog_client.ts   # Stage 2 — read-only client for Mizzz's Central Food Catalog v2 HTTP contract
      fuzzy_match.ts            # Stage 2 — Levenshtein-based name matching against Mizzz search candidates
      safety_classifier.ts      # Stage 2 — deterministic Safe/Warning/Restricted + price-value-indicator rules
      stage2_matcher.ts         # Stage 2 orchestration — bounded concurrency, per-item fault isolation
      types.ts                  # Stage 1/2/3 request/result contract (MatchedDish, MenuAnalysisResult, ...)
      *_test.ts                 # validation/provider tests with stubbed fetch
    classify-capture/
      index.ts                  # authenticated single-image entry, budgets, safe response/logging
      request_schema.ts         # MIME/base64/size/locale validation
      gemini_classify_client.ts # minimal-token Gemini call: menu vs. single_dish vs. unrecognized
      types.ts                  # typed classify request/result contract
      *_test.ts                 # validation/provider tests with stubbed fetch
```

### The unified camera flow

There is no manual mode picker in the app. A single live camera screen watches
for a Miz QR code continuously (decoded on-device, never sent to any Edge
Function) while "Take Photo"/"Choose from Library" are always available. A
still capture is reviewed once (one photo, one explicit consent tap) and then:

1. The client calls `classify-capture` with that one photo.
2. `kind: "menu"` routes to the existing multi-page `analyze-menu` flow (the
   user can still add more pages before the final "Explain menu" tap).
3. `kind: "single_dish"` calls `analyze-food` immediately, no further tap.
4. `kind: "unrecognized"` shows an honest "couldn't tell what this was" card.

`classify-capture` never returns dietary/allergen/price information — it
answers exactly one question (what kind of photo is this) so `analyze-menu`
and `analyze-food` stay the only places that reason about food content.

Menu Assistant Stage 4 (a lightweight follow-up chat once the user asks a question about a scanned menu) is **not** a separate function — it reuses `miz-ai` with a distinct, minimal system prompt and no tools; see "Menu Assistant Stage 4" below.

## Required secrets

Set once per Supabase project (already done for `GEMINI_API_KEY`/`GOOGLE_PLACES_API_KEY`/`GEMINI_MODEL` on this project — these commands are for reference/new environments):

```bash
supabase secrets set GEMINI_API_KEY=your-key-here
supabase secrets set GOOGLE_PLACES_API_KEY=your-key-here
# Optional — defaults to a current non-preview Flash model if unset:
supabase secrets set GEMINI_MODEL=gemini-3.6-flash
```

`SUPABASE_URL` and `SUPABASE_ANON_KEY` are injected automatically by the platform — never set manually. Secrets are read only via `Deno.env.get(...)` inside the function; they are never logged, never echoed in an error response, and never passed through Flutter defines.

### Mizzz Central Food Catalog secrets (`analyze-menu` Stage 2) — provisioned

`analyze-menu` calls Mizzz's separate Supabase project's Central Food Catalog v2 HTTP contract (`food_catalog_v1_search`/`food_catalog_v1_detail`, and `food_catalog_v1_propose_candidate` — see "New dishes are proposed automatically" below) via `mizzz_catalog_client.ts`. This requires two additional secrets on the **Miz AI** project, sourced from the **Mizzz** project's dashboard (Settings → API) — already set on the linked project:

```bash
supabase secrets set MIZZZ_SUPABASE_URL=https://your-mizzz-project-ref.supabase.co
supabase secrets set MIZZZ_SUPABASE_ANON_KEY=your-mizzz-anon-key
```

Use Mizzz's `anon` key only — never a service-role key (see `docs/SECURITY.md`). All three RPCs are granted to `anon`/`authenticated` at the lowest privilege on the Mizzz side. If these secrets are ever unset, every `analyze-menu` request still completes (Stage 1 vision extraction still runs), but Stage 2 matching fails closed: `mizzz_catalog_client.ts` throws `AI_CONFIGURATION_ERROR` for that one dish's lookup, which `stage2_matcher.ts` catches per-item — every extracted dish simply renders unmatched (`matchedFoodId: null`, `safetyStatus: null`) rather than failing the whole scan.

### New dishes are proposed automatically (Stage 2)

When a dish genuinely doesn't match anything in the Mizzz catalog (a real search ran and returned nothing confident enough — not a network/config failure, which is never treated as "new"), `stage2_matcher.ts` calls the Mizzz-side RPC `food_catalog_v1_propose_candidate(name, category, language, price)` with only the extracted name/category/price — never a description or any dietary claim, since Miz AI's vision step never invents food facts. Mizzz deduplicates by normalized name (the same dish scanned across many restaurants' menus creates one pending proposal, not one per scan) and always creates a `pending` `create_food` proposal, never an auto-approved one — see `mizzz/docs/CENTRAL_FOOD_CATALOG.md` "Phase 64" for the full RPC contract and validation. This call is best-effort and never blocks or fails the scan; its result isn't surfaced to the client at all. Guests never see any "not in our database" wording — an unmatched dish just renders with its name and price and no safety badge (see "The unified camera flow" below and `menu_camera_experience.dart`).

## Local development

```bash
cd supabase/functions
deno fmt                    # format
deno fmt --check            # verify formatting in CI
deno check miz-ai/*.ts analyze-food/*.ts analyze-menu/*.ts classify-capture/*.ts _shared/*.ts
deno test --allow-env miz-ai/ analyze-food/ analyze-menu/ classify-capture/
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
supabase functions deploy classify-capture
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

For food/menu vision, open Camera — there is no mode picker; a live view watches for a Miz QR code while "Take Photo"/"Choose from Library" are always available. Take or choose one photo, review the upload notice, then tap Analyze: `classify-capture` decides whether it's a menu or a single dish and routes automatically. A single dish calls `analyze-food` immediately and shows up to three typed candidates and confidence in the app locale, no further tap. A menu reaches the existing multi-page review (add up to four pages total, then tap Explain menu); successful output shows typed categories, each dish with its price next to a colored $ mark (green = good/typical, amber = a little pricier than average, red = high — relative to the median of other matched items in the same category on this same scan, never a claim about objective fair pricing) and, only when a confident Mizzz catalog match was found, a Safe/Warning/Restricted badge. An unmatched dish shows no badge at all — Miz never tells the guest it couldn't find the dish in an internal database. Tapping "Ask Miz about this menu" opens a Stage 4 follow-up chat pre-loaded with a deterministic summary of the scan — see below. Photos are not written to Supabase Storage or a database.

### Menu Assistant Stage 4 (follow-up chat)

Once the user taps "Ask Miz about this menu", the client calls the existing `miz-ai` function with an additional `menuContext` field — a plain-text summary of the just-scanned menu built client-side by `buildMenuContextSummary` (`lib/features/camera/domain/menu_context_summary.dart`). Any request carrying a non-null `menuContext` is treated server-side as a Menu Assistant follow-up: `system_instruction.ts`'s `buildMenuFollowUpSystemInstruction` replaces the normal system prompt (it must never contradict or re-derive the already-computed Safe/Warning/Restricted classifications), no tools are offered (`search_nearby_places`/`get_user_food_profile` are irrelevant here), and `request_schema.ts` clamps history to the last 5 turns instead of the normal 12 regardless of what the client sends:

```bash
curl -X POST "https://YOUR_PROJECT_REF.supabase.co/functions/v1/miz-ai" \
  -H "apikey: YOUR_PUBLISHABLE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Which dessert here is safe for me?",
    "locale": "en",
    "menuContext": "Desserts:\n- Apfelstrudel - 5.5 - safe for the users profile\n"
  }'
```

**Known gap:** `food_catalog_v1_detail` returns an `imagePath`, but Mizzz's `food-images` Storage bucket is private (see `mizzz/supabase/phase60_central_food_catalog_menu_images_review.sql`) — Miz AI has no signed-URL-issuing credential for it yet, so `imagePath` is carried through the response for future use but is **not currently rendered** as an image anywhere in the app. Dish cards show name/description/price/safety only.

## Reliability budgets and retries

`analyze-food` and `analyze-menu` each have a 70-second total budget. Food makes one provider attempt capped at 60 seconds, accepts one image, and returns at most three candidates with a 1,024-token cap. Menu allows at most four images; Stage 1's vision extraction is capped at 12 categories and 20 items per category, and Stage 2's Mizzz catalog matching is separately capped at 40 total dishes across all categories (a `truncated` note is added when the scan had more) with 5-way bounded concurrency and a per-item try/catch, so one failed catalog lookup never fails the rest of the scan. `classify-capture` has its own much smaller 30-second total budget, one attempt capped at 20 seconds, and a 64-output-token cap — it answers exactly one question (menu vs. single dish vs. unrecognized), never dietary/allergen/price content. All three functions reject oversized/unsupported payloads before any provider call, disable interaction storage, and deliberately avoid automatic multimodal retries; the user owns the explicit retry.

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
- **Mizzz catalog coverage is currently small and mostly unreviewed.** As of this writing, Mizzz's catalog holds a curated ~200-dish German seed set, but those entries are `pending` `create_food` proposals awaiting human review (see `mizzz/docs/CENTRAL_FOOD_CATALOG.md`) — `food_catalog_v1_search` only returns `verified` items, so most dishes on a scanned menu will render unmatched until review happens on the Mizzz side. This is expected, not a bug: Miz AI never approves or fabricates a catalog entry itself. Every unmatched dish is now also proposed as a new pending candidate (see "New dishes are proposed automatically" above), so real menu scans organically grow the review queue over time.
- **Catalog images are not renderable yet** — see "Menu Assistant Stage 4" above; `food-images` is a private Mizzz Storage bucket and no signed-URL flow exists between the two projects yet.
