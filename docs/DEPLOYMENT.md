# Deployment — Miz

Related: [`docs/LINEAR_BACKLOG.md`](LINEAR_BACKLOG.md) (Epic M9), [`docs/SECURITY.md`](SECURITY.md).

For the complete new-project checklist and Dashboard settings, see [`docs/SUPABASE_SETUP.md`](SUPABASE_SETUP.md). For the `miz-ai`, `analyze-food`, and `analyze-menu` Edge Functions (structure, secrets, local dev, deploy, manual test steps), see [`docs/EDGE_FUNCTIONS.md`](EDGE_FUNCTIONS.md).

## Environments

| Env | Purpose | Config source |
|---|---|---|
| Local | Development | `.env.json` (git-ignored) via `--dart-define-from-file` |
| Staging | Pre-release QA, points at a staging Supabase project | CI secret store |
| Production | Live app | CI secret store, restricted access |

No environment shares a Supabase project with another — staging data must never leak into or be confused with production data.

Create local configuration from the committed placeholder, fill it with the client-safe project values, and pass it at run/build time:

```bash
cp .env.example.json .env.json
flutter run --dart-define-from-file=.env.json
flutter build apk --debug --dart-define-from-file=.env.json
```

`AppConfig` accepts Supabase only when `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` are both present and the URL uses HTTPS. The legacy `SUPABASE_ANON_KEY` name remains accepted for older local/CI configuration. Builds with neither value remain supported for tests and honest offline/unavailable feature adapters; a partial or malformed configuration fails during bootstrap instead of silently targeting the wrong backend.

## Build flavors

Flutter build flavors (`dev`/`staging`/`prod`) select the environment config at build time; app icon/name can differ per flavor so a tester never confuses a staging build for production on their home screen. Set up when Epic M9 starts — not needed before then since earlier milestones run entirely on mock data with no environment split required.

## CI/CD (target shape, built in M9-2)

On every PR: `flutter analyze`, `flutter test`, `flutter build` (at least one platform) as required checks. On merge to `main`: build + deploy to staging automatically; production deploy is a manual, explicit trigger — never automatic on merge.

## Store submission (M9-3)

- iOS: App Store Connect — privacy nutrition label must accurately reflect data collected (location, preferences) per `docs/SECURITY.md`.
- Android: Play Console — Data Safety section, same accuracy requirement.
- Both: icons/screenshots generated from actual app builds, never mockups, once the design is fully implemented.

## Rollback

Standard app-store rollback constraints apply (can't force-downgrade a user's installed build) — server-side (Supabase schema, Edge Functions, AI contract version) must stay backward-compatible with at least the previous mobile release for the duration of a staged rollout, per the versioning rule in `docs/API.md` §5.

## Pre-release checklist (expand at M9)

- [ ] All `docs/LINEAR_BACKLOG.md` P0/P1 tasks for the release milestone closed.
- [ ] `docs/SECURITY.md` reviewed against current implementation (RLS, secrets, deletion flows).
- [ ] `docs/TESTING.md` milestone checklist green for every shipped milestone.
- [ ] Staging soak test completed with no unresolved crashes.
