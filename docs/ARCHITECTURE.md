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
    database/                # LIVE: one Drift db for Food Profile + local saved items
    bookmarks/               # shared saved-item entity/repository/provider used by features
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
    location/{domain,data,presentation}/         # city/default/recent states + replaceable OS adapter
    conversation/{domain,data,presentation}/     # typed chat state; backend-unavailable adapter today
    camera/{domain,data,presentation}/           # shared 3-mode state machine + replaceable device/analysis adapters
    bookmarks/presentation/                      # unified local saved-items page
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

Single `GoRouter` instance in `core/router/app_router.dart`. Spatial routes (`/city`, `/chat`, `/chat-history`, `/camera`, `/bookmarks`, `/profile`, `/food-profile`) use one fade/scale transition; Android system back remains native. Conversation deliberately replaces the generic dismiss control with History and New Chat actions. `/chat?q=` validates and length-limits deep-link text before it reaches presentation. Unbuilt milestones route to an honest shared "coming soon" stub rather than a 404 or fake finished screen. The onboarding gate is resolved in `bootstrap.dart` before `runApp`, not scattered through widgets.

## 6. Offline strategy

Cached locally (Drift): profile, preferences, recent restaurants (from Discovery/Results), bookmarks, recent searches, conversation summaries (Summary Chips). Cache-aside pattern: repository reads try Supabase first when online, fall back to Drift when offline; writes go to Drift immediately and sync to Supabase when connectivity returns (`connectivity_plus` gates the sync queue). Conflict rule: server wins on read-sync (Supabase is the source of truth); local writes queue and replay, last-write-wins per row — documented per-table if a feature needs stronger guarantees.

**Exceptions, already live**: the Food Preference Profile, unified saved items, and chat archives use the same local Drift database. None has a remote counterpart yet. The database is opened and seeded once in `bootstrap.dart`; every user-owned table carries `local_user_id`. Schema v2 added `saved_items`; schema v3 adds immutable conversation snapshots non-destructively. Saved-item writes and chat archives are local-first and available offline. Future account sync remains additive rather than creating a second database or replacing local data. See `docs/DATABASE.md` and ADR-013/ADR-014/ADR-019/ADR-023.

## 7. Device and remote capability boundaries

`LocationService`, `CameraCaptureService`, `CameraAnalysisService`, and `ConversationService` are domain-facing interfaces exposed through generated Riverpod providers. `LocationService` has a production device adapter backed by `geolocator`: it requests foreground approximate permission only after an explicit tap, resolves the position locally to the nearest supported service city, and discards the coordinates. `ConversationService` has a production `MizAiService` adapter backed only by the `miz-ai` Edge Function; Gemini/Places secrets and orchestration remain server-side. Camera/gallery selection is backed by `image_picker`; typed food recognition and menu explanation are backed only by the separate `analyze-food` and `analyze-menu` Edge Functions. Miz QR frames are decoded locally by `mobile_scanner`, validated through `MizQrValidator`, and never opened as arbitrary links; remote authenticity/publication/table verification remains deliberately unavailable. Raw provider JSON never reaches presentation. Adapters can be injected without changing widgets or feature state machines; provider secrets never move into feature code.

The composition root now reads the Supabase URL and publishable key through `AppConfig` and initializes `supabase_flutter` before the local database and application widget when both values are present. This establishes the remote-client boundary only; no presentation feature queries Supabase directly, and mock/local repositories remain active until a typed data implementation and reviewed RLS policy exist for that feature.

## 8. Backend independence

Miz's Flutter client and any backend logic it needs beyond raw Supabase queries live entirely inside Miz's own project. Miz never connects its client to Mizzz's database, schema, or internal services directly. The shared Central Food Catalog remains authoritative in Mizzz's existing `catalog.items` schema and is consumed only by Miz's backend through the bounded, versioned `food_catalog_v1_*` HTTPS/PostgREST RPC contract. Miz keeps no second trusted catalog. See `docs/API.md` §2.1.

## 9. Scalability notes

- Supabase Postgres with RLS scales read-heavy workloads via connection pooling (Supavisor) and read replicas as needed; heavy recommendation/AI orchestration is designed to live behind a stateless API layer (Edge Functions or a dedicated service) rather than in the Flutter client, so client logic never becomes a scaling bottleneck.
- AI calls are provider-abstracted (`ai/core`) specifically so cost/latency-driven provider or model changes don't ripple into features.
- Images served via CDN-backed Supabase Storage; client always requests via `cached_network_image`.

## 10. Testing seams

Every repository interface exists precisely so `Testing Agent` (see `AGENTS.md`) can inject a fake/mock at the provider layer — no widget test should need a real Supabase or OpenAI call. See `docs/TESTING.md`.

## 11. Localization and directionality

The settings domain stores an ISO-like language code rather than a translated display label. English (`en`), Farsi (`fa`), and German (`de`) are registered centrally. Flutter's localization layer derives LTR/RTL direction at the application root; widgets use directional start/end layout primitives so Farsi mirrors naturally. ARB generation provides compile-time-safe getters and placeholder types, and each added language requires a complete catalog plus directionality coverage.
