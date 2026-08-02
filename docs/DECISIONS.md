# Architecture Decision Records — Miz

Short-form ADRs. Each entry: context → decision → consequences. Newest first.

---

## ADR-017: `sqlite3_flutter_libs` pinned to `0.5.42`, not "latest"

**Context**: ADR-014 added `sqlite3_flutter_libs` to bundle the native SQLite library the Drift-backed Food Preference Profile needs on-device. It was initially pinned to `^0.6.0+eol`, pub.dev's "latest" version — but that release is an **empty stub package** (no `android/` Gradle module, no bundled native library at all; its own description says "Not used anymore, update to version 3.x of package:sqlite3 instead"). On a real Android device this caused the app to hang forever on the native splash screen: `bootstrap.dart` awaits opening the database before `runApp`, and with no native SQLite library to load, that await never resolved and no exception ever surfaced (confirmed via `adb logcat`, which showed the Flutter engine endlessly retrying its first frame with no Dart-side error).
**Decision**: Pin `sqlite3_flutter_libs: ^0.5.42` — the last version that actually ships the Android/iOS/macOS native library bundling — instead of trusting "latest" blindly. This is a private implementation detail of `core/database/`; it is not part of the public `sqlite3` Dart API surface that `drift`/`drift_dev` (ADR-014) constrain, so pinning it independently doesn't reopen the `drift_dev`/`riverpod_generator` `source_gen` conflict documented in ADR-007's successor work.
**Consequences**: Verified by a full uninstall/reinstall on a physical Android device (API 36): the app now renders its first frame and reaches the Welcome screen instead of hanging. This is a reminder that "no compile errors" and "`flutter build apk` succeeds" are not sufficient verification for a new native dependency — only running on a real device caught this, since `flutter test` uses an in-memory Drift database that never touches the native Android bundling path at all. Revisit this pin if `package:sqlite3`'s own native-bundling story (the migration path `sqlite3_flutter_libs`'s README points to) matures enough to drop the separate package entirely.

---

## ADR-016: Food item sample photography is bundled local assets, sourced from Wikimedia Commons

**Context**: The Food Preference Profile onboarding's "visual food selection" step shows ~24 sample food cards (`kFoodItemSeeds` in `lib/core/database/seed/catalog_data.dart`) that the user taps Like/Curious/Never-tried/Dislike on to seed their taste profile. Each seed already declared an `imageAsset` path under `assets/images/food_items/`, but no image files existed and the folder wasn't declared in `pubspec.yaml`, so the step would have shipped with broken images.
**Decision**: Following the exact ADR-009 precedent, sourced one representative photo per dish from Wikimedia Commons (openly licensed — public domain, CC0, CC-BY, or CC-BY-SA; no API key required), resized to a 640px-max-edge JPEG (~33–81KB each, ~1.3MB total) under `assets/images/food_items/`, and added that folder to `pubspec.yaml`'s `flutter: assets:` list. All 24 filenames match `kFoodItemSeeds` exactly, matched by actual dish content (e.g. the classic Naples margherita photo for `margherita_pizza.jpg`, a koobideh skewer plate for `persian_kebab.jpg`) rather than generic stock photography. Two dishes used a close substitute within the same cuisine/category where no exact-match photo carried a clear open license: `black_bean_burrito.jpg` uses a vegetarian burrito (bean-and-vegetable filling, Mexican) rather than one specifically labeled "black bean," and `jollof_rice.jpg` uses a jollof-with-fried-chicken plate (chicken is a common jollof side, not a substitution of the rice itself).
**Consequences**: This is mock/sample content for the onboarding taste-profile step, not an exhaustive food database — it covers 24 illustrative dishes across the cuisines already modeled in `catalog_data.dart`, the same way ADR-009's restaurant photos cover only the mock restaurants. If the onboarding step is later backed by a real food/dish catalog (e.g. Supabase-served), these bundled assets are replaced the same way ADR-009's restaurant photos are slated for replacement in Milestone 6 — not layered under the new logic.

---

## ADR-015: Food onboarding scope: no location step, inline allergy confirmation, a 3-state protein icon model

**Context**: The Food Preference Profile brief specifies a location-agnostic 12-step flow (Welcome → Diet → Food Rules → Allergies → Intolerances → Proteins → Cuisines → Flavors → Eating Style → Food Samples → Review → Completion) ending with a dedicated allergy-confirmation step, plus a 6-state preference model per protein (Eat & like / Eat neutral / Dislike / Never eat / Never tried / Curious). The old app-intro onboarding it replaces had a location-permission step with no equivalent in that spec.
**Decision**: Three deliberate scope reductions, made explicitly rather than silently: (1) The location-permission step is dropped entirely — it belongs to Home's contextual "Near you" capsule, not a taste-onboarding flow, and asking for it here is exactly the "unnecessary friction" the brief asks to remove. (2) Severe-allergy confirmation is an inline `AlertDialog` shown before advancing off the Allergies screen (only when a severe allergy is present) rather than a dedicated 12th screen — this keeps the same safety guarantee (the user must explicitly confirm before continuing) with one fewer screen transition. The flow is therefore 11 screens (`OnboardingScreen` enum), not 12. (3) The Proteins step uses 3 icon actions (like / dislike / never-eat-strict-exclude) instead of the spec's 6 states — `PreferenceState`/`RestrictionType` still model the full state space (used elsewhere, e.g. cuisines use `love`/`like`/`neutral`/`curious`/`dislike`), but the Proteins UI itself was simplified to keep the safety-critical distinction (strict exclusion feeds `FoodEligibilityService`) prominent without a 6-way per-row control.
**Consequences**: The 11-screen flow and 3-icon protein model are both easy to expand later (add a screen, add icons) without a data-model change, since the underlying enums already support the fuller state space. Anyone re-reading the original spec against the shipped flow should treat this ADR as the explanation for the discrepancy, not a bug.

---

## ADR-014: Food Preference Profile schema is Drift, table-per-file, enum-as-text

**Context**: The generic 3-step app-intro onboarding (`features/onboarding/`) collected nothing Miz could act on. Replacing it with a real Food Preference Profile needs a local, relational, queryable store — allergies, intolerances, ingredient/cuisine/flavor preferences, sample-food reactions, and a local interaction log, each with independent axes (e.g. an allergy is never just a "dislike") that a future deterministic eligibility engine can query cheaply.
**Decision**: Use Drift (already the project's documented choice for the offline cache — ADR-003), not Hive/Isar/SharedPreferences/a hand-rolled sqlite wrapper. ~19 Dart-defined tables (not `.drift` SQL files, consistent with the rest of the codebase being Dart/freezed-first), split across `core/database/tables/{profile,catalog,food_item,interaction}_tables.dart` by concern, with matching `daos/` files. Every enum-shaped column (severity, preference state, restriction type, requirement level, event type, onboarding status, diet type, …) is stored as the Dart enum's stable `.name` string, never its integer index, via a shared `enumFromName<T>(values, name, fallback)` helper that falls back instead of throwing on an unknown/legacy value. Seed data (allergens, intolerances, food rules, ingredients, cuisines, flavor attributes, ~24 sample foods) lives in plain-Dart `seed/catalog_data.dart` (no Drift/Flutter imports, so both `SeedRunner` and tests read it directly) and runs idempotently, keyed by stable `code`, inside the schema's `onCreate` migration.
**Consequences**: `schemaVersion` starts at `1` — there is no prior local schema, so there is no destructive-migration risk yet; every future column/table addition must be a stepped `onUpgrade` migration that never drops existing rows (CLAUDE.md non-negotiables), and `test/core/database/app_database_test.dart` exercises schema creation, the ingredient hierarchy, food-item↔ingredient/allergen links, and seed idempotency against an in-memory database. Storing enums as text costs a small amount of row size versus an integer, in exchange for Dart enums being freely reorderable later without a data migration — judged worth it for a table set this central to user safety data. See `docs/DATABASE.md` "Local database (Drift)".

---

## ADR-013: Single fixed local user id; no auth required to build a food profile

**Context**: The Food Preference Profile must work fully offline with no mandatory sign-in, must never mix data across local "users," and — per the brief — should be schema-ready for a future backend sync without over-engineering a real multi-account/auth system now, since none exists in the app yet.
**Decision**: Every food-profile table carries a `local_user_id` column, but the app currently has exactly one fixed value for it: `kLocalUserId = 1` (`core/database/local_user.dart`), no `uuid` package, no secure-storage-backed identity. `bootstrap.dart` opens/seeds the single local database and resolves the app's start route (`ensureProfile().isOnboarded ? home : onboarding`) once, before `runApp`, overriding `appDatabaseProvider`/`initialLocationProvider` the same way the existing `initialLanguageCodeProvider` pattern already works — never an async GoRouter redirect.
**Consequences**: Adding real multi-account support later is a real migration (populate genuine per-account ids, backfill `local_user_id`) rather than a schema rewrite, because every query already filters by it. Until then, installing the app fresh, clearing app data, or reinstalling all produce a brand-new empty profile under the same `local_user_id = 1` — there is intentionally no cross-install profile continuity without a future account system. `user_food_interactions.synced_at` is nullable and unused today, present only so a future sync worker doesn't require a schema change to start marking rows as synced.

---

## ADR-013: Food item sample photography is bundled local assets, sourced from Wikimedia Commons

**Context**: The Food Preference Profile onboarding's "visual food selection" step shows ~24 sample food cards (`kFoodItemSeeds` in `lib/core/database/seed/catalog_data.dart`) that the user taps Like/Curious/Never-tried/Dislike on to seed their taste profile. Each seed already declared an `imageAsset` path under `assets/images/food_items/`, but no image files existed and the folder wasn't declared in `pubspec.yaml`, so the step would have shipped with broken images.
**Decision**: Following the exact ADR-009 precedent, sourced one representative photo per dish from Wikimedia Commons (openly licensed — public domain, CC0, CC-BY, or CC-BY-SA; no API key required), resized to a 640px-max-edge JPEG (~33–81KB each, ~1.3MB total) under `assets/images/food_items/`, and added that folder to `pubspec.yaml`'s `flutter: assets:` list. All 24 filenames match `kFoodItemSeeds` exactly, matched by actual dish content (e.g. the classic Naples margherita photo for `margherita_pizza.jpg`, a koobideh skewer plate for `persian_kebab.jpg`) rather than generic stock photography. Two dishes used a close substitute within the same cuisine/category where no exact-match photo carried a clear open license: `black_bean_burrito.jpg` uses a vegetarian burrito (bean-and-vegetable filling, Mexican) rather than one specifically labeled "black bean," and `jollof_rice.jpg` uses a jollof-with-fried-chicken plate (chicken is a common jollof side, not a substitution of the rice itself).
**Consequences**: This is mock/sample content for the onboarding taste-profile step, not an exhaustive food database — it covers 24 illustrative dishes across the cuisines already modeled in `catalog_data.dart`, the same way ADR-009's restaurant photos cover only the mock restaurants. If the onboarding step is later backed by a real food/dish catalog (e.g. Supabase-served), these bundled assets are replaced the same way ADR-009's restaurant photos are slated for replacement in Milestone 6 — not layered under the new logic.

---

## ADR-012: Typed ARB localization owns language and direction

**Context**: Miz must launch with English, Farsi, and German while staying easy to extend. The original Settings language row stored the visible word “English,” did not change the app locale, and feature widgets embedded English copy and left/right layout assumptions.
**Decision**: Use Flutter `gen-l10n` with English as the ARB template, a central `AppLanguage` registry, and stable locale codes in settings. `MizApp` owns locale/delegate wiring; widgets use typed `context.l10n` access and directional start/end layout primitives. Farsi receives RTL from Flutter at the root. UI chrome and restaurant metadata are localized now; repository-authored restaurant content remains a separate live-content contract.
**Consequences**: Adding a language means registering one locale and supplying one complete ARB catalog, without changing feature widgets. Generated localization files are checked and tested with the app. The locale code persists immediately through a small `LanguageStore` boundary and later syncs to the profile record in M6. Persian currently uses platform Noto-compatible font fallback while Archivo remains the Latin brand face.

---

## ADR-011: The interface palette is monochrome with Miz red only

**Context**: The first Soft Orbit implementation used coral, mango, mint, sky, and lilac across gradients, cards, the Miz orb, ambient fields, and illustrations. Product review found that palette too colorful and its tinted shadows distracting.
**Decision**: Limit interface colors to black, white, neutral gray, and Miz red. Preserve full-color food photography as content, not chrome. Remove rainbow and multicolor gradients; use solid surfaces and at most one faint red ambient field. Shadows are always neutral black. The Miz orb becomes concentric black/red/white, quick actions become monochrome with one red featured state, and promotional emphasis uses solid red.
**Consequences**: The rounded Soft Orbit shape, spacing, motion, and generative UI model remain unchanged. Semantic color tokens no longer expose mango, mint, sky, or lilac. Future status states must combine monochrome/red treatment with icons and explicit labels so meaning never depends on hue alone.

---

## ADR-010: Soft Orbit replaces the square-only Modernist visual system

**Context**: The original M0/M1 prototype used a strict zero-radius, grayscale, editorial system. Product direction changed after review: the desired Miz experience is warmer, more modern, more dimensional, and centered on circular actions, capsules, rounded content surfaces, soft ambient color, natural food photography, and continuous transitions. The supplied visual references establish the desired atmosphere and interaction quality, while Miz must remain a UI-first food product rather than become a generic AI chat interface.
**Decision**: Adopt `DesignGD.md`'s Soft Orbit system as the approved visual source of truth. Preserve Archivo, the UI-first Generative UI model, Summary Chips, Clean Architecture, accessibility requirements, and typed AI contracts. Replace zero-radius components with semantic radii; replace forced grayscale photography with warm full-color imagery; add tokenized Aurora accents, soft elevation, selective translucent floating surfaces, and reduced-motion-aware transitions.
**Consequences**: ADR-005 is superseded. `Miz.dc.html` remains useful for flow/content reference but no longer governs shape or styling. Shared theme/components migrate before feature screens so old and new visual languages are not mixed within a released screen. All affected light/dark, loading, empty, error, responsive, and accessibility states require new visual QA.

---

## ADR-009: Mock restaurant photography is bundled local assets, sourced from Wikimedia Commons

**Context**: `MizImageSlot` (docs/DESIGN.md §1, ADR-007) rendered an icon+label placeholder because mock data had no image URLs. That's honest but makes Home's Nearby/Favorites rails look unfinished, and the design's photography treatment (`grayscale(1) contrast(1.08)`) was never actually exercised.
**Decision**: Sourced one representative dish/drink photo per mock restaurant from Wikimedia Commons (openly licensed, no API key required), resized to a 640px-max-edge JPEG (~40–85KB each) under `assets/images/restaurants/`, and added an optional `imageAsset` field to the `Restaurant` entity populated in `MockRestaurantRepository`. `MizImageSlot` now accepts an optional `imageAsset`: when present it renders the asset through a `ColorFiltered` grayscale+contrast matrix matching the CSS filter exactly; when absent it still falls back to the icon+label placeholder (so a future feature adding restaurants without a photo doesn't regress to a broken image).
**Consequences**: This is mock-only content for M1–M5, matched to each restaurant's dish by content (truffle tagliatelle, a stacked cheeseburger, an omakase plate, a buddha bowl, tiramisu, latte art, a wine glass) rather than being generic stock photography. It's replaced outright in Milestone 6 by `hero_image_url`/`restaurant_photos` served from Supabase Storage (docs/DATABASE.md) — the `imageAsset` field and the asset folder are deleted at that point, not layered under the new logic.

---

## ADR-008: Archivo is a bundled asset, not fetched via google_fonts at runtime

**Context**: `google_fonts` fetches font files from `fonts.gstatic.com` on first use and caches them. Running the M1 build on macOS surfaced this immediately: the sandboxed debug build has no `com.apple.security.network.client` entitlement, so the fetch failed outright (`SocketException: Operation not permitted`) and the app silently fell back to the system font — visually wrong with no error surfaced to the user, and it would only get worse offline (docs/PRD.md's offline requirement) or on a cold start with no connectivity.
**Decision**: Self-host Archivo (Regular 400, ExtraBold 800 — the only two weights the type scale uses) as local assets under `assets/fonts/`, declared in `pubspec.yaml`'s `fonts:` section, referenced via plain `fontFamily: 'Archivo'` in `core/theme/app_typography.dart`. Dropped the `google_fonts` package dependency entirely.
**Consequences**: Typography now renders identically offline, in every platform sandbox, and on first launch with no network — consistent with the app's own offline-first architecture (docs/ARCHITECTURE.md §6). Adding a new weight/style later means downloading the static font file and adding one more `fonts:` entry, not a dependency change. Desktop platforms (macOS/Windows/Linux) still need `com.apple.security.network.client` (or equivalent) added to their entitlements before Milestone 6/7 (Supabase/OpenAI calls) — that's tracked as part of those milestones' setup, not needed for M0/M1.

---

## ADR-007: M0 dependencies trimmed to what M1–M2 actually need; pinned to Riverpod 2.x

**Context**: `docs/ARCHITECTURE.md`'s original dependency list included Supabase, Drift, geolocator, permission_handler, flutter_secure_storage, connectivity_plus, dio, cached_network_image up front. Adding them all in M0 pulls in native platform config (permissions, entitlements, native SQLite/geolocation plugins) for capabilities no milestone before M3–M8 actually exercises, and `flutter pub add` also surfaced a real ecosystem conflict: `riverpod_annotation ^4.0.6` (Riverpod 3.x) has a dependency chain that's currently incompatible with `flutter_test`'s bundled `matcher`/`test_api` versions when `riverpod_generator` is also present, and `riverpod_generator`'s `source_gen` requirement conflicts with `json_serializable`'s.
**Decision**: (1) Pin `flutter_riverpod`/`riverpod_annotation`/`riverpod_generator` to the mature 2.x line (`2.6.1`/`2.6.1`/`2.6.5`), which resolves cleanly against this Flutter SDK (3.44.8 / Dart 3.12.2). Revisit the 3.x line once the ecosystem (riverpod_generator + json_serializable + flutter_test) settles. (2) Add only what M1–M2 need now — `flutter_riverpod`, `riverpod_annotation`/`riverpod_generator`, `go_router`, `google_fonts`, `freezed`/`freezed_annotation`, `build_runner`, `mocktail`. (3) Defer `supabase_flutter`, `drift`+`sqlite3_flutter_libs`, `geolocator`, `permission_handler`, `flutter_secure_storage`, `shared_preferences`, `connectivity_plus`, `dio`, `cached_network_image`, `json_serializable`/`json_annotation` to the milestone that first needs each (M3 photos, M6 Supabase, M8 offline) per `docs/LINEAR_BACKLOG.md`.
**Consequences**: `docs/ARCHITECTURE.md`'s dependency list is aspirational for the full project, not literal for M0 — each deferred package gets added in the task that first needs it, keeping every milestone's dependency footprint explainable. Restaurant "photos" in M1–M2 use a placeholder `image-slot`-style widget (grayscale box + label, matching the approved prototype's own placeholder treatment) rather than `cached_network_image`, since mock data has no real image URLs yet.

---

## ADR-006: Delete Data vs Delete Account scope is unconfirmed with legal

**Context**: `docs/DATABASE.md` proposes Delete Data clears preferences/searches/chips/bookmarks but keeps order/reservation history, while Delete Account cascades everything.
**Decision**: Ship this split as the default for M1–M8, but flag it as legal-review-pending before M9 release.
**Consequences**: If legal requires order history deletion too, `orders`/`order_items` need an anonymization strategy instead of hard delete (financial record requirements vary by jurisdiction) — revisit before M9.

---

## ADR-005: Zero border-radius is intentional, not a placeholder (superseded by ADR-009)

**Context**: Every `.btn`/`.card`/`.tag`/`.input` in the approved design has `radius: 0`. This can look like an unfinished/default style to someone unfamiliar with the design.
**Decision**: This was the M0/M1 decision and is retained for history only. ADR-009 replaces it with the approved Soft Orbit system.
**Consequences**: Existing square components must migrate through central tokens and shared widgets, not through isolated per-screen rounding.

---

## ADR-004: AI provider abstraction via `ai/` as a peer layer

**Context**: The brief requires OpenAI Responses API now, with an explicit requirement to support multiple providers and several future capabilities (voice, Realtime, RAG, vision, MCP, function calling) later without rearchitecting.
**Decision**: `ai/` sits alongside `core/`, not inside any feature or inside `core/network`. Features depend only on `ai/core`'s `AiClient` interface.
**Consequences**: Adding a provider or capability is additive (new file(s) under `ai/`), never a change to feature code. Slight upfront overhead (an interface for a single current implementation) accepted deliberately.

---

## ADR-003: Drift for offline cache, not Hive/Isar

**Context**: Offline requirements (`docs/PRD.md`) are relational-shaped: profile, preferences, recent restaurants, bookmarks, recent searches, conversation summaries — with clear foreign-key-like relationships (bookmarks reference restaurants, etc.).
**Decision**: Use Drift (SQLite, type-safe queries) over Hive/Isar (document/object stores) for the offline cache.
**Consequences**: Slightly more setup (schema + generated DAOs) than a key-value store, but querying/joining cached data (e.g. "bookmarked restaurants I've also searched recently") is native SQL instead of manual joins in Dart.

---

## ADR-002: Riverpod codegen (`@riverpod`) over manual provider syntax

**Context**: Riverpod supports both legacy manual providers and codegen-based `@riverpod` annotations.
**Decision**: Codegen throughout, per `CLAUDE.md` §7.
**Consequences**: Requires `build_runner` in the dev loop; in exchange, providers are less error-prone (no manual generic wiring) and match current Riverpod idiom, which matters for a project intended to scale in team size.

---

## ADR-001: Feature-first + Clean Architecture, not layer-first

**Context**: Could organize `lib/` by technical layer at the top (`presentation/`, `domain/`, `data/` each containing all features) or by feature at the top (each feature containing its own layers).
**Decision**: Feature-first at the top level (`features/<name>/{data,domain,presentation}`), per the brief's explicit "feature-first architecture" requirement and to keep each feature independently reviewable/removable.
**Consequences**: Cross-feature shared code must be deliberately promoted to `core/` rather than casually imported across feature boundaries — enforced in `CLAUDE.md` §3.
