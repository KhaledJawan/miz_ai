# Changelog

Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Dates in `YYYY-MM-DD`. Entries are per-milestone, not per-commit — see [`CONTRIBUTING.md`](../CONTRIBUTING.md).

## [Unreleased] — Colored price indicator, guest-facing polish, and organic catalog growth — 2026-08-04

### Added
- Menu dish prices now show a colored $ mark (green/amber/red for good/high/very-high, relative to the category median) instead of a text badge; `PriceValueIndicator` narrowed from 4 states to a clearer 3-tier `good`/`high`/`very_high` scale.
- Unmatched dishes are now automatically proposed to Mizzz as pending `create_food` candidates (new anon-safe Mizzz RPC `food_catalog_v1_propose_candidate`, deduplicated by normalized name, never auto-approved, never carries a description or dietary claim) — real menu scans now organically grow the review queue instead of only the curated German seed set.

### Changed
- Removed guest-facing wording that exposed backend implementation details: the "Not in Miz's food database yet" badge and the "pairing suggestions... not available from the catalog" note are gone; an unmatched dish now simply shows its name and price with no badge and no explanation.

### Fixed
- (carried from the previous entry) `analyze-menu`/`classify-capture` output-token budgets that were truncating real Gemini responses to nothing.

### Verified
- deno fmt/check clean, all 163 Edge Function tests pass, flutter analyze clean, all 152 Flutter tests pass. The new Mizzz-side RPC was validated end-to-end in a disposable clone (dedup, input validation, anon-role privilege isolation, and a full round-trip through `approve_food_proposal`) before deployment, and the full live pipeline was re-verified against a real restaurant menu photo after both sides went live.

## [Unreleased] — Menu Assistant pipeline and unified camera flow — 2026-08-03

### Added
- Replaced `analyze-menu`'s single Gemini-explains-everything call with a 4-stage low-token pipeline: JSON-only vision extraction (Stage 1); deterministic, zero-LLM-call Mizzz Central Food Catalog fuzzy matching, Safe/Warning/Restricted classification against the user's Food Profile, and a relative price indicator (Stage 2); a typed structured result with no LLM text (Stage 3); and a lightweight `miz-ai` follow-up chat ("Ask Miz about this menu") gated by a new `menuContext` field with its own minimal no-tools system prompt and a tighter 5-turn history cap (Stage 4).
- New `MIZZZ_SUPABASE_URL`/`MIZZZ_SUPABASE_ANON_KEY` Edge Function secrets for the Stage 2 Mizzz catalog client (anon-key only, read-only, lowest privilege).
- New `classify-capture` Edge Function: a minimal-token Gemini call that classifies one still photo as a menu, a single dish, or unrecognized, letting the camera route to the right pipeline automatically.
- Removed the manual Food/Miz QR/Menu mode picker entirely (see ADR-026). The camera is now one live screen: a real live preview watches continuously for a Miz QR code while Take photo/Choose photo are always available; a captured photo is reviewed once, then classified and routed automatically — a single dish calls food recognition immediately with no extra tap, a menu enters the existing multi-page review, and an unrecognized photo shows an honest fallback.

### Fixed
- `analyze-menu` Stage 1 was encoding extracted dishes as a hand-rolled `category|||name<TAB>price` delimited string that was never validated against a real Gemini response and was failing to parse on essentially every real menu photo, always surfacing "the menu was not clear enough." Replaced with a plain nested JSON schema, which structured-output schemas already support natively.

### Still unavailable
- The Mizzz catalog currently holds a curated ~200-dish German seed set awaiting human review (`pending` proposals) — most scanned menus will show dishes as unmatched until that review happens; Miz AI never approves or fabricates a catalog entry itself.
- Matched-dish images are not renderable yet — Mizzz's `food-images` Storage bucket is private and no signed-URL flow exists between the two projects.

### Verified
- `deno fmt`/`deno check` clean, all 157 Edge Function tests pass (`miz-ai`, `analyze-food`, `analyze-menu`, `classify-capture`), `flutter analyze` clean, all 152 Flutter tests pass, and both new functions are deployed to the linked Supabase project.

## [Unreleased] — Camera vision and scanning — 2026-08-03

### Added
- Completed a cross-project, read-only schema audit and prepared the additive Central Food Catalog v2 in the Mizzz source of truth: controlled observations/proposals, field-level evidence, multilingual aliases/translations, normalized taxonomies, trust and duplicate review, immutable versions/audit, hybrid search and embedding jobs, licensed image moderation, structured imports, additive menu matching, strict RLS, versioned read RPCs for a future Miz AI backend adapter, and transactional SQL coverage. No production migration or direct Miz AI database link was applied.
- Native camera and gallery menu-photo input through `image_picker`, Android lost-picker recovery, iOS/macOS permission declarations, up to four previewed/reorderable pages, explicit upload confirmation, and safe temporary-file cleanup that never deletes gallery originals.
- Secure `analyze-menu` Supabase Edge Function using shallow Gemini multimodal structured output with flat dish records plus strict semantic validation, with request/MIME/size/deadline/output limits, prompt-injection resistance, no image/content logging, and provider interaction storage disabled.
- Typed, localized English/German/Farsi menu results with overview, sections, dish explanations, printed price, dietary tags, possible-allergen warnings, notes, unreadable/error/retry states, and widget/data/controller/Deno coverage.
- Real Food mode camera/gallery preview and explicit upload consent, backed by the deployed `analyze-food` Gemini function with up to three typed localized candidates, confidence, uncertainty/error recovery, strict photo-safety copy, and no ingredient/allergen claims from appearance.
- Real live Miz QR decoding through `mobile_scanner`, strict local version/token/expiry/signature-shape validation, Scan again recovery, and accurate separation between device scanner failure and unavailable trusted restaurant/table verification.
- Capability-specific camera mode resets so an unavailable food/QR backend can no longer leave the other modes stuck on “Camera unavailable.”

### Still unavailable
- Trusted Miz QR authenticity, restaurant publication, branch/table activity, and session verification remain unavailable until the restaurant backend provides a signed source of truth; local decoding never fabricates verification.

### Verified
- `flutter analyze` is clean, all 146 Flutter tests pass, all 100 Edge Function tests pass, the Android debug APK builds and installs with the camera permission declared, `analyze-menu` completed a safe unreadable-image smoke test, and `analyze-food` recognized the bundled Margherita pizza through the live deployed endpoint.

## [Unreleased] — Gemini AI chat via `miz-ai` Edge Function — 2026-08-02

### Added
- Local offline chat history backed by Drift schema v3, with typed message/place snapshot serialization, review and deletion, and automatic archiving before History, New Chat, or system-back navigation.
- Production reliability controls for `miz-ai`: a 58-second total deadline, one selective transient retry for Gemini/Places, simplified retry context, 1,024-token output cap, strict tool schemas, runtime response validation, recoverable unknown-tool handling, explicit location ownership, safe request-scoped observability, partial Places success, and typed-card-only place presentation that drops unverified model narration.
- Structured backend failures and distinct localized Flutter states for AI timeout/unavailable/busy, Places unavailable, no results, location required, and internal request recovery.
- Publishable-key authorization for `miz-ai`: legacy gateway JWT verification is disabled for the new key format, while the function itself validates the platform-injected named publishable keys before any paid Gemini/Places work.
- `supabase/functions/miz-ai/`, a new Deno Edge Function that replaces the honest-unavailable chat stub with real Gemini function calling via the Interactions API (model configurable through `GEMINI_MODEL`, default `gemini-3.6-flash`), running a bounded (max 3 rounds) send/inspect/validate/execute/continue loop.
- Two backend-validated tools: `search_nearby_places` (Google Places API (New), server-injected trusted coordinates only — the schema has no latitude/longitude field) and `get_user_food_profile` (server-revalidated, minimized summary of the local Food Profile, never raw history or precise location).
- `MizAiService` (Flutter), calling only the `miz-ai` Edge Function through `supabase_flutter`'s `FunctionsClient` — never Gemini or Google Places directly — plus widened `ConversationRequest`/`ConversationReply` models, place-result cards, and a location-required flow reusing the existing city picker.
- An additive `city_coordinates.dart` lookup and a permission-safe `TransientPositionReader` (never prompts, never persists) so the chat feature can pass real coordinates without changing the existing string-only `LocationService` contract.
- 78 Deno unit tests (stubbed `fetch`, zero live network calls) and 43 Gemini/conversation Flutter unit/widget tests. New `docs/EDGE_FUNCTIONS.md` plus ADR-021/ADR-022.

### Changed
- Conversation now uses unmistakable black user bubbles and white Miz replies with a red assistant marker, removes per-message copy controls and the page-level X, dismisses the keyboard on send, keeps the newest response visible, and exposes History/New Chat actions.
- `docs/API.md` §3 and `docs/SECURITY.md` updated to describe the real Gemini/Places architecture and secret handling in place of the prior interim-stub framing.

### Backend-dependent
- No live end-to-end call against real Gemini/Places was made (only the user holds those secrets) — verified via stubbed unit tests plus documented manual `curl`/in-app steps in `docs/EDGE_FUNCTIONS.md`.
- True distributed per-user rate limiting is not implemented (Edge Function isolates are stateless); only request-shape limits (body size, history length, tool-round cap, result cap, timeouts) are enforced today.

### Verified
- `deno fmt`/`deno check`/`deno test` clean (78/78), `flutter analyze` clean, all 122 Flutter tests pass, Android debug build passes for the original integration.

## [Unreleased] — Miz Spatial Glass — 2026-08-02

### Added
- New-project Supabase setup guide and a key-safe local verifier covering the exact client values, replacement flow, RLS requirements, and Auth/Storage/Realtime/CI boundaries.
- Environment-validated Supabase client initialization in the existing composition root, with a git-ignored local configuration and committed placeholder template; the app itself remains intact and no demo Todos screen or unreviewed table query was introduced.
- Real foreground approximate-location support using an injectable `geolocator` device boundary, local nearest-supported-city matching, Android/iOS/macOS permission declarations, and denial/disabled/out-of-area tests.
- Tokenized six-level Spatial Glass material system and reusable glass surface, circle action, composer, location capsule, contextual dismiss, spatial sheet/transition, result card, camera mode selector, rotating prompt, and animated food-atmosphere components.
- Focused Home with only the unassumed city selector, central keyboard-safe multiline input/send, exactly three icon actions, and lifecycle/reduced-motion-aware abstract local food imagery.
- Manual/recent/default city selection with explicit requesting/denied/unavailable capability states and no cold-start location assumption.
- Real conversation route/state architecture with user input, loading, retry, copy, new search, continued composer, and an honest secure-backend-unavailable response rather than fabricated AI output.
- One Drift-backed unified saved-items repository/page for restaurants, cafés, foods, menu items, discoveries, and scanned dishes; existing favorites now use the same source.
- Combined spatial Profile/Settings page preserving the complete editable Food Profile and English/Farsi/German RTL/LTR system.
- Single three-mode camera workflow architecture (Food, Miz QR, Menu), including permission/capture/review/processing/uncertainty/error states, temporary multi-page menu operations, replaceable device/analysis interfaces, and strict version/token/expiry QR validation requiring backend verification.
- Tests for focused Home, rotating/paused prompts, send state, keyboard/small-screen/RTL/reduced motion, navigation/back/deep links, city denial/manual fallback, persistent bookmarks, camera denial/menu page operations, and invalid/expired/unverified QR payloads.

### Changed
- `DesignGD.md` and `docs/DESIGN.md` now define Spatial Glass as the active shell identity. Secondary spatial routes no longer use standard top-left app-bar arrows.
- Extended the approved culinary-AI artwork and control treatment from Home to conversation, bookmarks, city selection, camera, profile/settings, Food Profile, results, sheets, and shared secondary controls. Secondary pages use a calmer static 20%-blurred backdrop; interactive surfaces are solid white, borderless, zero-blur, black-forward, and separated with neutral iOS-style shadows.
- Local Drift schema upgraded non-destructively from v1 to v2 with `saved_items` and its time-sort index.

### Backend-dependent
- Production OS camera adapters, AI recommendations, food recognition, menu OCR/correction, cloud upload consent, and QR signature/restaurant/table verification remain intentionally unavailable. No fake result is shown.

### Verified
- `dart format --set-exit-if-changed` clean, `flutter analyze` clean, all 79 unit/widget/golden tests pass, and 390×844 light/dark Spatial Home plus City/Camera reference renders were visually reviewed.
- The supplied Supabase endpoint and publishable key were accepted by the live project, and an Android debug APK builds with `.env.json` injected through `--dart-define-from-file`.
- Android and macOS debug builds include the live location plugin; the updated APK was installed over the existing physical Android-device app without clearing local data, and the package reports the expected ungranted coarse-location runtime permission ready for the first user tap.
- macOS debug launch/build, Android debug APK, and Android release APK build successfully. The web target remains unsupported by the existing native Drift/SQLite FFI configuration.

## [Unreleased] — Food Preference Profile — 2026-08-01

### Added
- A local-only, deterministic (no AI, no external calls) Food Preference Profile: a live Drift/SQLite database (`core/database/`, ~19 tables) with seed data for allergens, intolerances, food rules, ingredients (hierarchical), cuisines, flavor attributes, and ~24 sample foods.
- 11-screen adaptive onboarding (`features/food_profile/presentation/onboarding/`) replacing the old generic app-intro onboarding: Welcome, Diet, Food Rules, Allergies (with inline severe-allergy confirmation), Intolerances, Proteins (diet-adaptive — vegan/vegetarian users are never asked about meat), Cuisines, Flavors, Eating Style, visual Food Samples (real bundled photos), Review. Progress is persisted per screen so the flow resumes after a restart; skipping creates an empty "skipped" profile that never reopens automatically.
- A permanent, always-editable Food Profile section in Settings (`FoodProfilePage`, linked from `ProfileSettingsSheet`) reusing the exact same step widgets as onboarding, writing straight to the database on every change, plus a completeness indicator, personalization toggle, delete-interaction-history, restart-onboarding, and reset-food-profile actions.
- `FoodEligibilityService` (deterministic allergy/restriction filtering, safety rule order, never claims "safe" on unknown data), `ProfileCompletenessService` (fixed weighted scoring), `InteractionTracker`/`InteractionTrackerImpl` (batched, deduped local event log — ready for future behavioral signals), and `BehavioralInferenceService` (low-confidence, capped, never overrides an explicit answer or creates a strict exclusion) — none of them wired to AI; they operate purely on explicit local data today and are structured for a future AI layer to consume without a rewrite.
- Allergy/intolerance/restriction data model keeps every distinct concept (allergy, intolerance, strict exclusion, dietary/ethical/religious exclusion, personal dislike, unknown) on independent axes end-to-end, so a dislike can never suppress a food and an allergy can never be stored as a mere dislike.
- 17 new automated tests: adaptive skip logic, severe-allergy confirmation dialog, per-screen persistence/resume across a simulated restart, skip-never-reopens, and Settings edit-and-persist — on top of the existing database/eligibility/completeness/behavioral-inference suites from the same feature.
- ADR-013 (single fixed local user id), ADR-014 (Drift schema shape), ADR-015 (onboarding scope: no location step, inline allergy confirmation, 3-icon protein model) in `docs/DECISIONS.md`; new "Local database (Drift)" section in `docs/DATABASE.md`.

### Removed
- The old `features/onboarding/` app-intro flow (intro / location rationale / remember-preferences) and its test — fully superseded by the Food Preference Profile onboarding at the same route.

### Fixed
- The app hung indefinitely on the native splash screen on real Android devices: `sqlite3_flutter_libs` was pinned to `^0.6.0+eol`, an empty stub with no bundled native library, so opening the local database in `bootstrap.dart` never resolved and `runApp` was never reached. Pinned to `^0.5.42` instead (the last version that actually bundles the native library) and verified with a full uninstall/reinstall on a physical Android device. See ADR-017.

### Verified
- `flutter analyze` clean; full test suite passing; `flutter build apk --debug` passes; onboarding walkthrough and Settings edit flow verified on macOS and, after the sqlite3_flutter_libs fix, on a physical Android device.

## [Unreleased] — Soft Orbit design migration — 2026-08-01

### Changed
- Added production-shaped localization for English, Farsi, and German using typed ARB generation, a persistent Settings language picker, root-level locale switching, automatic RTL/LTR direction, directional layouts, localized accessibility labels and restaurant metadata, and an extension guide for future languages.
- Compacted Home by replacing the greeting hero with Today's Offers, removing Popular Cravings, meal-period chips, and the Nearby rail, and changing the composer prompt to “What do you want to eat?”
- Refined the Soft Orbit palette to black, white, neutral gray, and Miz red only; removed multicolor UI accents, rainbow gradients, and colored shadows while keeping food photography naturally full color.
- Replaced the M0/M1 square-only Modernist styling with the approved Soft Orbit system: semantic radii, circular actions, capsules, rounded content surfaces, monochrome/red light and dark palettes, soft elevation, restrained red ambient fields, and tokenized motion.
- Rebuilt Onboarding around the Miz orb, ambient color fields, rounded preference controls, and continuous step transitions.
- Reworked Home with a rounded header, solid-red offer banner, expressive quick-action cards, full-color restaurant photography, richer restaurant facts, and a floating food-intent composer.
- Rebuilt Profile/Settings as a rounded, grouped sheet with a circular profile treatment, semantic icon rows, modern toggles, and verified light/dark states.
- Updated route stubs to use the same system without presenting unfinished milestones as complete.
- Synchronized `CLAUDE.md`, `AGENTS.md`, `README.md`, `docs/DESIGN.md`, and `docs/DECISIONS.md`; ADR-010 supersedes the zero-radius decision.

### Verified
- `flutter analyze` passes with no issues.
- All 21 unit/widget tests pass, including language persistence, English/Farsi/German Home layouts, the Settings language picker, Farsi RTL switching, and German at a compact 320px viewport.
- Visually reviewed Onboarding, Home, restaurant content, Profile/Settings, and dark mode in the running macOS build.

## [Unreleased] — M1 Onboarding + Home — 2026-08-01

### Added
- Onboarding: 3-step flow (intro / location rationale / remember-preferences), dot progress, skip, animated step transitions.
- Home: time-of-day greeting + context (morning/lunch/evening/late), 2×2 quick-action grid, quick chips, context chips, Nearby rail (sorted by distance), conditional Favorites rail, "Today's Offers" banner, floating input bar (mic/camera visibly disabled, text input routes into the M2 conversation stub).
- Profile/Settings bottom sheet: language row, working Dark Mode / Notifications / Location Permission / Remember Preferences toggles, Privacy/About/Help rows, Log Out.
- Mock `RestaurantRepository` with the prototype's 7-restaurant dataset ported verbatim, behind the interface Milestone 6 will swap to Supabase.
- 14 tests (unit + widget) covering greeting time-bands, settings toggles, onboarding step transitions, and Home rendering — `flutter analyze` and `flutter test` both clean.
- Visually verified against the approved design on macOS (resized to the 390-class reference width): onboarding steps 0–2, Home light + dark theme, profile sheet.

### Fixed
- Archivo is now a bundled local font asset instead of fetched via `google_fonts` at runtime — the macOS sandbox blocked the runtime fetch outright (no network entitlement), silently falling back to the system font. See `docs/DECISIONS.md` ADR-008.

## [Unreleased] — M0 Foundation — 2026-08-01

### Added
- Full documentation set: `README.md`, `CLAUDE.md`, `AGENTS.md`, and all `docs/*` files (PRD, DESIGN, ARCHITECTURE, DATABASE, API, ROADMAP, LINEAR_BACKLOG, DECISIONS, STYLE_GUIDE, CONTRIBUTING, SECURITY, TESTING, DEPLOYMENT).
- Design system tokens and screen inventory documented from the approved `Miz.dc.html` prototype ("Modernist" design system).
- Flutter clean-architecture scaffold: `core/`, `ai/`, `features/*` folder structure.
- Core dependencies (Riverpod codegen, GoRouter, Supabase, Drift, etc.).
- GoRouter route shell covering every screen in the design.
- Design-system widget kit (`Miz*` widgets) and light/dark theme.

### Known gaps
- Linear project "Miz" not yet created — connector unauthorized in this environment; backlog tracked in `docs/LINEAR_BACKLOG.md` until it can be pushed.
- No live Supabase project yet (M6).
- No AI integration yet (M7) — Milestone 1–5 features run on scripted/mock data by design.
