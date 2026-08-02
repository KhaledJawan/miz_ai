# Changelog

Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Dates in `YYYY-MM-DD`. Entries are per-milestone, not per-commit — see [`CONTRIBUTING.md`](../CONTRIBUTING.md).

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
