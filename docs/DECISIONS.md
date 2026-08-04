# Architecture Decision Records — Miz

Short-form ADRs. Each entry: context → decision → consequences. Newest first.

---

## ADR-026: Unified camera flow replaces the three-mode picker; a `classify-capture` step routes automatically

**Context**: The camera shell required picking Food, Miz QR, or Menu before capturing — real user feedback was that this was unnecessary friction, and that a photo should be enough for Miz to figure out what it is on its own. Separately, `analyze-menu`'s Stage 1 vision parser (an in-session redesign toward a low-token 4-stage Menu Assistant pipeline) had a real production bug: it asked Gemini to encode extracted dishes as a hand-rolled `category|||name<TAB>price` delimited string, which was never validated against a real Gemini response and was failing to parse on essentially every real menu photo in practice, always surfacing "the menu was not clear enough."
**Decision**: Fixed `vision_parser.ts` to use a plain nested JSON schema (`categories: [{name, items: [{name, price}]}]`) instead of the delimited-string encoding — structured-output schemas already support nesting natively, so there was no reason to hand-roll a fragile format. Separately, added a new, minimal `classify-capture` Edge Function (its own tiny Gemini call, ~64 output tokens, answering only `menu`/`single_dish`/`unrecognized` — never dietary/allergen/price content) and removed the manual `MizCameraModeSelector` entirely. The camera is now one live screen: a real `mobile_scanner` preview watches continuously for a Miz QR code (decoded on-device, never sent to any Edge Function) while Take photo/Choose photo are always available. A captured photo is reviewed once (one photo, one explicit "Analyze" consent tap before any network call), then `classify-capture` routes automatically — a single dish calls `analyze-food` immediately with no further tap, a menu enters the existing multi-page review (add pages, then the separate "Explain menu" tap, unchanged), and an unrecognized photo shows an honest "couldn't tell what this was" card. `CameraMode` became nullable (`null` until classified) and `CameraWorkflowController.selectMode` was deleted along with the now-dead `MizQrScannerExperience`/`FoodCaptureExperience`/`MizCameraModeSelector` widgets.
**Consequences**: Fewer manual steps end-to-end (no upfront mode choice; food recognition no longer needs a second confirm tap), while QR safety validation and the menu multi-page review are unchanged. Widget tests exercising the camera page can no longer use `pumpAndSettle()` at all, since a real `MobileScanner` preview is now mounted on the very first frame and its continuously-running platform channel/timer never lets `pumpAndSettle()` converge — they use a small bounded manual `pump()` loop instead (see `test/features/camera/presentation/pages/camera_page_test.dart`). The golden reference for the Camera screen changed accordingly and was regenerated. This supersedes ADR-018's and ADR-025's "typed three-mode state machine"/mode-switch framing for Camera; QR local-validation-but-remote-trust and menu/food's own ephemeral-analysis decisions (ADR-024/ADR-025) remain otherwise unchanged.

---

## ADR-021: AI chat runs on Gemini's Interactions API via a `miz-ai` Edge Function, with backend-validated function calling

**Context**: The Spatial chat surface (`ConversationService`) has always been an honest stub — `UnavailableConversationService` throwing until a secure backend exists (docs/API.md §3.2 explicitly anticipated this). The brief called for real Gemini-powered chat with two backend tools (`search_nearby_places` via Google Places, `get_user_food_profile` via the local Food Profile), strictly following "Gemini proposes, backend decides and executes" — Gemini must never reach Google Places, Supabase tables, device location, or private data directly. Both API keys were already provisioned as Supabase Edge Function secrets; no Edge Function infrastructure existed yet in the repo at all.
**Decision**: New `supabase/functions/miz-ai/` (Deno/TypeScript, no framework, official REST fetch calls only — no Node SDK, for guaranteed Deno compatibility). Verified against live docs rather than guessed: Gemini's **Interactions API** (`POST .../v1beta/interactions`, GA and recommended over legacy `generateContent`) for the model call, and Google **Places API (New)** `searchNearby`/`searchText` for place lookups. `GEMINI_MODEL` is configurable, defaulting to `gemini-3.6-flash` (current, non-preview). The function-calling loop (`gemini_loop.ts`) is bounded to 3 rounds, validates every tool name against a hard allowlist and every argument against a schema before executing (`tools.ts`), and injects trusted location server-side — the `search_nearby_places` argument schema has no latitude/longitude field, so Gemini structurally cannot supply coordinates. On the Flutter side, `ConversationService`/`ConversationModels` were widened (structured request/reply, bounded history, `requiresLocation` flow reusing the existing city picker) and `MizAiService` replaces `UnavailableConversationService` only when Supabase is configured — offline/dev builds and every existing test are unaffected. The client's local (not-yet-Supabase-synced) Food Profile is summarized client-side (`buildFoodProfileAiContext`) and re-validated/clamped server-side rather than trusted verbatim, since no server-side Food Profile table exists yet.
**Consequences**: Deno and the Supabase CLI are now dev-time dependencies (installed via Homebrew), with `deno fmt`/`deno check`/`deno test` (62 tests, zero live network calls, `fetch` stubbed) as part of the verification loop alongside `flutter analyze`/`flutter test` (111 tests total, 32 new). Rate limiting beyond request-shape limits (body size, history length, tool-round cap, Places result cap, timeouts) is out of scope for this pass — Edge Function isolates are stateless, so a true per-user limit needs external state not built yet; documented honestly in `docs/EDGE_FUNCTIONS.md` rather than oversold. `docs/API.md` §3 now describes this as the live contract instead of the aspirational OpenAI Responses API framing it previously carried. See `docs/EDGE_FUNCTIONS.md` for deployment/testing commands and `docs/SECURITY.md` for the updated secrets/trust-boundary rules.

---

## ADR-020: Current-city lookup uses foreground approximate device location and local service-area matching

**Context**: Spatial City already exposed “Use current location,” but its default adapter always returned unavailable because no OS location plugin or platform permissions existed. Supabase configuration cannot supply a device's GPS position, and uploading raw coordinates merely to choose one of seven supported cities would add unnecessary privacy and network risk.
**Decision**: Add `geolocator` behind the existing `LocationService` boundary. Request foreground approximate permission only after the explicit user action, acquire one low-accuracy position with a 15-second limit, and match it on-device to the nearest supported city within 120 km using fixed city-center coordinates. Declare only coarse/when-in-use permissions—no background permission—and discard latitude/longitude immediately after matching.
**Consequences**: Trier, Berlin, Hamburg, Munich, Frankfurt, Cologne, and Düsseldorf can be selected automatically without Supabase or reverse-geocoding traffic. Permission denial, disabled services, plugin errors/timeouts, and positions outside the current service radius return honest existing states and preserve manual selection. Supporting arbitrary cities later requires a typed service-catalog/geocoding contract rather than silently selecting a distant city. This supersedes only ADR-018's statement that the default location adapter is unavailable; its camera and backend-capability decisions remain active.

---

## ADR-019: Unified local saved items extend the existing Drift database at schema v2

**Context**: Restaurant favorites were a session-only `Set<String>`, while the Spatial Bookmarks experience must save restaurants, cafés, foods, menu items, discoveries, and scanned dishes offline. Creating a second persistence system would split favorite state and violate the single-database rule.
**Decision**: Add a generic `saved_items` table to the existing `AppDatabase` through a non-destructive schema-v1→v2 migration. `BookmarkRepository` is the only persistence boundary. The unified Bookmarks page and compatibility `FavoritesController` both read/write it.
**Consequences**: Existing Food Profile rows survive the migration; bookmarks sort offline by `saved_at`; remote account sync remains future work with an explicit local-write/server-read conflict rule. Older call sites can keep the favorite controller API while no duplicate bookmark store exists.

---

## ADR-018: Spatial Glass shell with honest device/backend capability adapters

**Context**: The approved redesign replaces dashboard Home with a cinematic intent surface and adds city, conversation, camera, QR, menu scan, bookmarks, and combined profile/settings experiences. The repository has no OS camera/location integration and no secure AI, vision, OCR, or QR-verification backend; fabricated success would be unsafe.
**Decision**: Spatial Glass supersedes Soft Orbit for the immersive shell. Home contains only city, composer/send, three circular actions, and an abstract food background. Secondary pages use contextual circular dismissal and one spatial route transition. Location, conversation, capture, and analysis are injected interfaces whose default adapters report unavailable. Camera is one typed three-mode state machine; Miz QR is locally shape/expiry validated but always backend-verified before trust.
**Consequences**: The complete interaction architecture and honest states are testable now without secrets or fake results. Real device/backend adapters can replace providers without rewriting UI. The permanent Home animation is capped at three isolated image layers and secondary pages remain static for performance and test determinism.

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
## ADR-022: Treat Gemini and tool output as unreliable input behind layered reliability budgets

**Context**: Live use showed two provider behaviors that compile-time schemas cannot prevent: transient Interactions API latency exceeded the former single 20-second deadline, and Gemini invented `get_user_location` even though only two tools were declared. The Edge Function depended too heavily on ideal model behavior, and Flutter collapsed every typed failure into the same unavailable card.

**Decision**: Keep the provider boundary but harden every runtime edge. Gemini and Places now share a 58-second request deadline, each may retry once only for timeout/network/5xx, and the Gemini retry removes history. Tool names use an exact two-name allowlist; argument validation rejects unknown fields, wrong types/enums, duplicates, lengths, and numeric ranges. Unknown tools become function-result errors, missing location becomes a backend-owned structured flag (including explicit handling for invented location aliases), provider envelopes are runtime-validated, tool rounds/results/output are capped, and validated Places results survive a failed final narration. Errors use a stable safe structure and Flutter preserves each code as an actionable localized state. Logs contain only opaque correlation ids and bounded operational metadata.

**Consequences**: Model updates, malformed calls, temporary latency, empty responses, and unexpected steps can no longer directly execute work or crash the request. Retries are deliberately finite and non-transient failures are not retried, controlling both cost and latency. Distributed per-user throttling still requires external shared state and remains a separate future security/reliability change.

---

## ADR-023: Conversation threads archive locally as typed snapshots

**Context**: Conversation was an in-memory transcript with visually identical author surfaces, repeated copy buttons, a close/X action that discarded the thread, and a New Search action that cleared it without history. The composer also kept the keyboard open after send, obscuring the incoming response on a phone.

**Decision**: Give user and Miz turns distinct monochrome author treatments, remove per-message copy controls and the conversation X, dismiss the keyboard and scroll after send, and replace destructive reset behavior with History and New Chat. Non-empty threads are upserted through a feature-owned repository into Drift schema v3 as a typed JSON snapshot; History can review or delete them offline. The archive stores message/place display data only and excludes precise location, profile context, tool traces, debug failures, and secrets.

**Consequences**: Starting a new chat no longer loses the previous thread, and the author/keyboard behavior is immediately understandable. The local archive remains a cache rather than a server source of truth; authenticated cross-device sync and resumable backend conversations remain future work with the documented server-wins/queued-local-write conflict rule.

---

## ADR-024: Menu photos use explicit, ephemeral multimodal analysis

**Context**: The camera shell exposed Menu mode but used unavailable device/analysis adapters and could not explain a real photographed menu. Menu images may contain personal background details, malicious printed instructions, unclear prices, and incomplete allergen information.

**Decision**: Make Menu the default camera mode and use the native camera/gallery picker only after an explicit source tap. Keep one to four pages locally for review, then upload only after the separate Explain menu action and nearby privacy notice. Send bounded inline images to a dedicated `analyze-menu` Edge Function; never persist them in Storage/database or log image/content data. Treat photographed text as untrusted content, disable provider interaction storage, require schema-constrained output plus semantic validation, and expose possible allergens only as uncertain warnings. Do not automatically retry paid image requests.

**Consequences**: Users can understand real menus without exposing Gemini credentials or silently uploading photos, while failures remain retryable and typed. Gallery originals are protected from cleanup. A user-visible manual retry may be needed for transient failures. Food recognition and local QR decoding subsequently shipped under ADR-025; trusted QR verification remains separate.

---

## ADR-025: Food vision is ephemeral; Miz QR decoding is local but trust is remote

**Context**: Food and Miz QR modes were UI-state placeholders. Food capture always called an unavailable adapter, QR showed a decorative frame without decoding camera frames, and an unavailable state in one mode could leak into another. Food photos can reveal background details and cannot prove ingredients or allergy safety. QR payloads can be malicious, expired, forged, or unrelated web links.

**Decision**: Use the existing explicit camera/gallery review pattern for one food photo, uploading only after Identify food to a dedicated bounded `analyze-food` Edge Function. Disable provider storage, exclude image/content data from logs, treat image text as untrusted, return at most three validated candidates, and prohibit ingredient/allergy-safety claims from appearance. Decode only QR format frames locally through `mobile_scanner`; never auto-open arbitrary URLs. Accept only bounded `miz://v1` restaurant/table payloads locally, suppress duplicate detections, and keep signature/publication/table/session verification behind a future trusted backend. Reset capability-specific failures when switching modes.

**Consequences**: Food recognition and the QR camera are real device capabilities with accurate localized result/error states. No Gemini or signing secret reaches Flutter, no photo is retained, and a malformed model candidate cannot control UI. A locally valid Miz QR still cannot navigate until the restaurant backend supplies authoritative signed records; the app reports that limitation as verification unavailable, never camera unavailable or verified.
