# Security — Miz

Related: [`CLAUDE.md`](../CLAUDE.md) §10, [`docs/DATABASE.md`](DATABASE.md), [`AGENTS.md`](../AGENTS.md) (Security Agent).

## Secrets

- No API key, Supabase service-role key, or OpenAI key is ever committed to the repo, hardcoded in Dart source, or checked into a config file that's tracked by git.
- Client-safe values (Supabase anon/public key, project URL) are passed via `--dart-define-from-file=.env.json`; `.env.json` is git-ignored. A `.env.example.json` (no real values) documents the required keys.
- Server-side/service-role secrets never enter the Flutter client at all — they live only in Supabase Edge Function environment config or equivalent backend secret storage.

## Authentication & session

- Supabase Auth handles sign-up/sign-in/session refresh. Session tokens are stored via `flutter_secure_storage` (Keychain/Keystore-backed), never `shared_preferences` (plaintext-adjacent).
- Session expiry/refresh is handled by the Supabase client SDK; the app never manually persists a long-lived token to bypass this.

## Data access (RLS)

- Every Supabase table has Row Level Security enabled with an explicit policy before it's queried by the client — see `docs/DATABASE.md` for the per-table policy summary. No table ships "open" even temporarily during development against a shared project.
- Public-read tables (`restaurants`, `menu_items`, `reviews`, `restaurant_photos`) still restrict writes to a service role used only by backend ingestion — the client is read-only for these.

## Location & permissions

- Location is only requested after the onboarding step that explains why (per `docs/DESIGN.md`), never on cold start without context.
- Permission state (`location_permission_granted`, `notifications_enabled`) is mirrored in `profiles` but the actual OS permission is the source of truth — the app re-checks OS permission state rather than trusting a stale DB flag to decide whether to prompt again.

## Data deletion

- **Delete Data**: clears `preferences`, `recent_searches`, `conversation_summaries`, `bookmarks` — see `docs/DATABASE.md` and ADR in `docs/DECISIONS.md` re: order/reservation history retention pending legal review.
- **Delete Account**: cascades through every user-owned row, then deletes the `auth.users` row. Must be a real, verifiable cascade (tested per-table), not a `deleted_at` soft flag that leaves data queryable.
- Both actions require a confirmation step in the UI (destructive, irreversible) before executing.

## Client-side hardening

- No `dynamic`-typed data from an external source (Supabase row, AI response, deep link) is trusted without validation/typed parsing before use — see `docs/API.md` §4 for the error-mapping contract.
- Deep links / route parameters are validated before being used to fetch data (no unvalidated ID passed straight into a query).
- Dependency versions are pinned in `pubspec.lock`; `flutter pub outdated` is checked periodically for known-vulnerable packages.

## AI-specific considerations

- AI responses that drive navigation/UI are schema-validated (`docs/API.md` §3.2) before being acted on — an unexpected or malformed AI response fails safe (falls back to a default screen/error state), it does not execute arbitrary instructions from model output.
- No user PII beyond what's necessary for the current request is sent to the AI provider; conversation context sent is limited to Summary Chips and explicit free-text input, not the user's full profile/order history unless a feature explicitly requires it and that's documented in `docs/API.md`.

## Reporting

Since this is an internal Merlin ICT product in early development, security issues found during development are tracked as `P0`/`security`-labeled tasks in `docs/LINEAR_BACKLOG.md` (or Linear directly once connected), not a public disclosure process — revisit this section before any public release (M9).
