# Architecture — Miz

Related: [`CLAUDE.md`](../CLAUDE.md) §2–3, [`docs/DATABASE.md`](DATABASE.md), [`docs/API.md`](API.md), [`docs/DECISIONS.md`](DECISIONS.md).

## 1. Principles

- **Clean Architecture, feature-first.** Each feature owns its `data/domain/presentation`; cross-cutting concerns live in `core/`.
- **Dependency rule**: `presentation` depends on `domain`; `data` implements `domain`; nothing in `domain` imports Flutter, Supabase, or Dio.
- **Provider-agnostic AI**: the AI layer is a peer of `data/network/storage`, not buried inside a feature — swapping or adding a provider must not touch feature code.
- **Designed for millions of users**: stateless client-facing surface, thin client, backend does the heavy lifting (recommendation logic, AI orchestration) so the client never becomes the bottleneck.

## 2. Layering

```
Presentation   → Flutter widgets, Riverpod-consumed screens/widgets (features/*/presentation)
Domain         → entities, repository interfaces, use-cases (features/*/domain) — pure Dart
Application    → orchestration living in Riverpod notifiers/use-cases; thin by design, most logic sits in domain
Infrastructure → data/ (repository impls), network/, storage/ (core/ + features/*/data)
AI             → ai/core (interfaces) + ai/openai (implementation) — a peer layer, not inside Infrastructure
Data           → Supabase Postgres, Drift (offline), secure storage
Networking     → Dio client with interceptors (auth, logging, retry) in core/network
Storage        → Drift (structured offline cache), flutter_secure_storage (tokens), shared_preferences (simple flags)
Analytics      → core/analytics — interface + no-op implementation now, real vendor wired later without touching call sites
```

## 3. Folder structure

```
lib/
  main.dart
  bootstrap.dart          # env load, Supabase.initialize, runApp(ProviderScope(...))
  app.dart                # MaterialApp.router, theme, router wiring

  core/
    config/               # AppConfig from --dart-define
    localization/         # supported-language registry + BuildContext access
    theme/                # colors, typography, spacing, radii, shadows, app_theme.dart
    router/                # app_router.dart (GoRouter), route name constants
    network/                # dio_client.dart, api_exception.dart, interceptors
    database/                # LIVE: Drift db/tables/daos/seed for the local Food Preference Profile — see docs/DATABASE.md "Local database (Drift)"
    storage/                # secure_storage.dart, prefs.dart (Drift itself lives in core/database/, not here — see ADR-013)
    error/                # failures.dart, exceptions.dart, result.dart
    analytics/                # AnalyticsClient interface + NoopAnalyticsClient
    widgets/                # Miz* design-system kit (see docs/DESIGN.md §2)
    utils/                # formatters, extensions

  ai/
    core/                # AiClient interface, AiMessage/AiResponse/UiMode models
    openai/                # OpenAIResponsesClient

  features/
    food_profile/{domain,data,presentation}/     # Food Preference Profile: onboarding + editable Settings section, LIVE (see docs/DATABASE.md)
    home/{domain,data,presentation}/
    conversation/{domain,data,presentation}/     # chat, thinking, results — Summary Chip flow
    restaurant/{domain,data,presentation}/       # details + discovery
    menu/{domain,data,presentation}/             # browser + cart
    reservation/{domain,data,presentation}/
    checkout_tracking/{domain,data,presentation}/
    profile_settings/{domain,data,presentation}/
    auth/{domain,data,presentation}/
```

Generated localization code and ARB sources live under `lib/l10n/`. `MizApp` owns locale selection and delegates; presentation reads typed copy through `context.l10n`. See [`LOCALIZATION.md`](LOCALIZATION.md).

Each `presentation/` splits into `pages/`, `widgets/`, `providers/`. A feature with no remote data (e.g. `onboarding`) has no `data/` — don't create an empty one.

## 4. State management (Riverpod)

- Codegen (`@riverpod`) throughout; one `Notifier`/`AsyncNotifier` per screen-level concern.
- Repositories are provided as their `domain/` interface type (`restaurantRepositoryProvider` returns `RestaurantRepository`), with the mock/Supabase implementation chosen at the provider definition — this is the seam that lets Milestone 1 ship on mock data and Milestone 6 swap to Supabase without touching a single widget.
- Cross-feature shared state (auth session, theme mode, connectivity) lives in `core/` providers; feature notifiers depend on those, never the reverse.

## 5. Navigation (GoRouter)

Single `GoRouter` instance in `core/router/app_router.dart`. Every screen from `docs/DESIGN.md` §6 has a named route from day one (Phase 1 scaffold); unbuilt milestones route to a shared "coming soon" stub rather than a 404 or a fake finished screen. Auth/onboarding-gate redirects live in the router's `redirect` callback, not scattered through widgets.

## 6. Offline strategy

Cached locally (Drift): profile, preferences, recent restaurants (from Discovery/Results), bookmarks, recent searches, conversation summaries (Summary Chips). Cache-aside pattern: repository reads try Supabase first when online, fall back to Drift when offline; writes go to Drift immediately and sync to Supabase when connectivity returns (`connectivity_plus` gates the sync queue). Conflict rule: server wins on read-sync (Supabase is the source of truth); local writes queue and replay, last-write-wins per row — documented per-table if a feature needs stronger guarantees.

**Exception, already live**: the Food Preference Profile (`core/database/`, `features/food_profile/`) is local-only today, not a cache in front of Supabase — there is no remote counterpart yet. It's opened and seeded once in `bootstrap.dart` before `runApp` (so the app's start route can be resolved synchronously, with no async GoRouter redirect/splash flicker), never mixes data across local users, and every table carries a `local_user_id`/nullable sync-readiness column specifically so a future backend-sync milestone is additive rather than a schema rewrite. See `docs/DATABASE.md` "Local database (Drift)" and ADR-013/ADR-014.

## 7. Backend independence

Miz's Flutter client and any backend logic it needs beyond raw Supabase queries live entirely inside Miz's own project. Miz never connects to Mizzz's database, schema, or internal services directly — any Mizzz data Miz needs is consumed through a versioned HTTP API, same as any third-party integration. See `docs/API.md`.

## 8. Scalability notes

- Supabase Postgres with RLS scales read-heavy workloads via connection pooling (Supavisor) and read replicas as needed; heavy recommendation/AI orchestration is designed to live behind a stateless API layer (Edge Functions or a dedicated service) rather than in the Flutter client, so client logic never becomes a scaling bottleneck.
- AI calls are provider-abstracted (`ai/core`) specifically so cost/latency-driven provider or model changes don't ripple into features.
- Images served via CDN-backed Supabase Storage; client always requests via `cached_network_image`.

## 9. Testing seams

Every repository interface exists precisely so `Testing Agent` (see `AGENTS.md`) can inject a fake/mock at the provider layer — no widget test should need a real Supabase or OpenAI call. See `docs/TESTING.md`.

## 10. Localization and directionality

The settings domain stores an ISO-like language code rather than a translated display label. English (`en`), Farsi (`fa`), and German (`de`) are registered centrally. Flutter's localization layer derives LTR/RTL direction at the application root; widgets use directional start/end layout primitives so Farsi mirrors naturally. ARB generation provides compile-time-safe getters and placeholder types, and each added language requires a complete catalog plus directionality coverage.
