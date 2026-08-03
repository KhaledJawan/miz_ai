# Security — Miz

Related: [`CLAUDE.md`](../CLAUDE.md) §10, [`docs/DATABASE.md`](DATABASE.md), [`AGENTS.md`](../AGENTS.md) (Security Agent).

## Secrets

- No API key, Supabase service-role key, or OpenAI key is ever committed to the repo, hardcoded in Dart source, or checked into a config file that's tracked by git.
- Client-safe values (Supabase anon/public key, project URL) are passed via `--dart-define-from-file=.env.json`; `.env.json` is git-ignored. A `.env.example.json` (no real values) documents the required keys.
- Bootstrap validates that the URL and publishable key are supplied together and requires HTTPS before initializing the SDK. The publishable key is not a substitute for authorization: every reachable table still requires reviewed RLS.
- `dart run tool/verify_supabase_config.dart` validates the selected project without logging the publishable key. See `docs/SUPABASE_SETUP.md` for project replacement and Dashboard setup.
- Server-side/service-role secrets never enter the Flutter client at all — they live only in Supabase Edge Function environment config or equivalent backend secret storage.
- `GEMINI_API_KEY` and `GOOGLE_PLACES_API_KEY` (plus the optional `GEMINI_MODEL` override) are Supabase Edge Function secrets read only via `Deno.env.get(...)` inside `supabase/functions/`. They are never logged, never included in an error response, and never passed through `--dart-define`. See `docs/EDGE_FUNCTIONS.md`.

## Authentication & session

- Supabase Auth handles sign-up/sign-in/session refresh. Session tokens are stored via `flutter_secure_storage` (Keychain/Keystore-backed), never `shared_preferences` (plaintext-adjacent).
- Session expiry/refresh is handled by the Supabase client SDK; the app never manually persists a long-lived token to bypass this.
- The current change initializes only the Supabase client; it does not enable an authentication UI or authenticated repositories. Secure session-storage wiring remains mandatory before an auth flow ships.

## Data access (RLS)

- Every Supabase table has Row Level Security enabled with an explicit policy before it's queried by the client — see `docs/DATABASE.md` for the per-table policy summary. No table ships "open" even temporarily during development against a shared project.
- Public-read tables (`restaurants`, `menu_items`, `reviews`, `restaurant_photos`) still restrict writes to a service role used only by backend ingestion — the client is read-only for these.

## Location & permissions

- Location is requested only after the user taps the selector's explicit “Use current location” control and sees its privacy explanation, never during onboarding or on cold start.
- Permission state (`location_permission_granted`, `notifications_enabled`) is mirrored in `profiles` but the actual OS permission is the source of truth — the app re-checks OS permission state rather than trusting a stale DB flag to decide whether to prompt again.
- Spatial Home never assumes a city and never asks for location on cold start. Manual selection and the separately stored default city do not contain precise coordinates. Location failures and values are excluded from generic logs/analytics metadata.
- The live device adapter requests only foreground approximate permission after an explicit “Use current location” tap. Latitude/longitude are used transiently on-device to choose the nearest supported service city, then discarded; only the city label may be persisted.
- The AI chat feature extends this same commitment rather than relaxing it: `TransientPositionReader` (`features/location/data/`) reads a coordinate for a single request only when location is already enabled and permission already granted — it never triggers a new permission prompt and never persists the result. When unavailable, the request relies on the user's selected city (name + known coordinates) instead — see `docs/API.md` §3.2.

## Camera, temporary media, and QR

- Device capture is behind `CameraCaptureService` and the native picker opens only after Take photo or Choose photo. Camera files are temporary and deleted on removal/controller disposal; gallery originals are never deleted.
- Food and menu photos are uploaded only after the separate Identify food/Explain menu action and nearby consent copy. Food sends one bounded image only to `analyze-food`; menu sends up to four pages only to `analyze-menu`. Flutter enforces 3 MiB per page and an 8 MiB menu total; each function independently validates MIME, base64 shape, count, and total request size. Images are passed inline to Gemini, are not written to Storage/database, are not included in logs, and provider interaction storage is disabled.
- Text inside any analyzed image is untrusted content, never instructions. Both vision prompts state this explicitly; output uses shallow JSON-schema objects with flat records, then every field is decoded, semantically validated, and length/count bounded before Flutter parses typed models. Invalid records are dropped rather than trusted or allowed to fail the remaining result. Menu allergens remain warnings; food-photo recognition never claims ingredients or allergy safety from appearance.
- Miz QR accepts only the bounded, versioned `miz://v1` payload shape. Local scheme/token/expiry checks are necessary but never sufficient: signature, restaurant publication, branch/table activity, and session authorization require trusted backend verification before navigation.
- Scanned text and payloads are length-bounded and parsed into typed models. Arbitrary QR URLs are not opened and internal database identifiers are not exposed in the public payload.

## Data deletion

- Chat History is stored only in the device's Drift database today. Each archive has an explicit delete action; snapshots contain display messages and normalized place cards, never coordinates, profile context, tool traces, debug errors, or credentials.
- **Delete Data**: must clear `preferences`, `recent_searches`, `conversation_summaries`, `conversation_archives`, and `bookmarks` — see `docs/DATABASE.md` and ADR in `docs/DECISIONS.md` re: order/reservation history retention pending legal review. The current local Food Profile reset is narrower and must not be presented as this future account-wide action.
- **Delete Account**: cascades through every user-owned row, then deletes the `auth.users` row. Must be a real, verifiable cascade (tested per-table), not a `deleted_at` soft flag that leaves data queryable.
- Both actions require a confirmation step in the UI (destructive, irreversible) before executing.

## Client-side hardening

- No `dynamic`-typed data from an external source (Supabase row, AI response, deep link) is trusted without validation/typed parsing before use — see `docs/API.md` §4 for the error-mapping contract.
- The shared Central Food Catalog remains in Mizzz's project. Miz AI's Flutter client never receives Mizzz credentials or queries its schema. A future backend adapter may call only the versioned `food_catalog_v1_*` read RPCs, which run as invoker and expose verified, non-archived records through RLS. User searches, OCR, restaurant entries, external APIs, and AI output can create only staged observations/proposals through validated server functions; allergens and other high-risk dietary facts always require human review.
- Deep links / route parameters are validated before being used to fetch data (no unvalidated ID passed straight into a query).
- Dependency versions are pinned in `pubspec.lock`; `flutter pub outdated` is checked periodically for known-vulnerable packages.

## AI-specific considerations

- AI responses that drive navigation/UI are schema-validated (`docs/API.md` §3.2) before being acted on — an unexpected or malformed AI response fails safe (falls back to a default screen/error state), it does not execute arbitrary instructions from model output.
- No user PII beyond what's necessary for the current request is sent to the AI provider; conversation context sent is limited to Summary Chips and explicit free-text input, not the user's full profile/order history unless a feature explicitly requires it and that's documented in `docs/API.md`.
- Gemini **proposes** tool calls only; it never executes them. `tools.ts` checks names against the exact two-name allowlist and rejects missing/unknown fields, wrong types, unsupported enums, duplicates, excessive lengths, and out-of-range numbers before dispatch. Unknown tools and malformed arguments become recoverable tool results rather than executable instructions or fatal exceptions. The search schema has no latitude/longitude field, so model output can never override server-derived trusted location.
- The client-supplied `foodProfileContext` (from the local, unsynced Food Profile) is re-validated and re-clamped server-side (`food_profile.ts`) rather than trusted verbatim — the same length/shape limits the client itself enforces are re-applied, so a malformed payload can't reach Gemini or logs unbounded.
- The Edge Function never echoes or logs raw Gemini/Places payloads, prompts, profile content, coordinates, stack traces, or credentials. Client failures use stable codes and `technicalMessage:null`; operational logs contain only request ids, durations, model name, approved/generic tool labels, and error codes. Layered deadlines, one selective transient retry, runtime response validation, and total cost limits treat provider behavior as untrusted input.
- Real-place presentation is grounded only in normalized Places records. If a turn returns place cards, free-form Gemini narration is discarded so invented descriptions or “highlights” cannot be presented beside trusted provider data.
- `miz-ai` disables only Supabase's legacy JWT gateway check because `sb_publishable_...` values are not JWTs. The handler immediately validates the `apikey` header against the platform-injected named publishable-key map before parsing user input or making a paid provider call; missing, incorrect, or unconfigured keys fail closed.

## Reporting

Since this is an internal Merlin ICT product in early development, security issues found during development are tracked as `P0`/`security`-labeled tasks in `docs/LINEAR_BACKLOG.md` (or Linear directly once connected), not a public disclosure process — revisit this section before any public release (M9).
