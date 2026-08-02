# Linear Backlog — Miz

> **Status**: the Linear MCP connector is not authorized in this environment, so this backlog exists as a document, not yet as live Linear issues. Once the user connects Linear (claude.ai connector settings), this content should be pushed verbatim: one Linear **Project** ("Miz"), one **Epic** per milestone below (M0–M9), one Linear **Milestone** per epic matching [`docs/ROADMAP.md`](ROADMAP.md), and one **Issue** per task, with the fields below mapped directly to Linear issue fields (description, labels, priority, estimate). Until then, this is the single source of truth for backlog planning.

Labels used throughout: `flutter-ui`, `backend`, `supabase`, `database`, `ai`, `testing`, `ux`, `docs`, `refactor`, `security`, `infra`.
Priority scale: `P0` (blocking), `P1` (high), `P2` (normal), `P3` (nice-to-have).
Estimate scale: `XS` (<2h), `S` (~half day), `M` (~1–2 days), `L` (~3–5 days), `XL` (>1 week, should be split further before starting).

---

## Epic M0 — Foundation

**Goal**: A new engineer (or agent) can clone the repo, read the docs, and understand exactly what to build and how, with a running-but-empty app shell already navigable end-to-end.

### M0-1 · Write full documentation set
- **Description**: Author README, CLAUDE.md, AGENTS.md, and all `docs/*` files listed in the README's doc index.
- **Goal**: Every architectural, product, and process question a contributor could ask is answered in-repo.
- **Acceptance criteria**: All 16 documents exist, cross-link correctly, contain no placeholder/lorem text.
- **Dependencies**: none.
- **Priority**: P0 · **Labels**: `docs` · **Estimate**: L

### M0-2 · Scaffold Flutter clean-architecture folder structure
- **Description**: Create `core/`, `ai/`, `features/*` folders per `docs/ARCHITECTURE.md` §3, with each feature's `data/domain/presentation` split.
- **Goal**: Every future feature has an obvious, consistent home.
- **Acceptance criteria**: Folder structure matches ARCHITECTURE.md exactly; `flutter analyze` passes on the empty scaffold.
- **Dependencies**: M0-1.
- **Priority**: P0 · **Labels**: `flutter-ui`, `refactor` · **Estimate**: M

### M0-3 · Add and pin core dependencies
- **Description**: Add Riverpod (codegen), GoRouter, Supabase, google_fonts, freezed/json_serializable, dio, flutter_secure_storage, shared_preferences, drift stack, cached_network_image, geolocator, permission_handler, connectivity_plus, mocktail to `pubspec.yaml`.
- **Goal**: All later milestones can start coding without dependency churn.
- **Acceptance criteria**: `flutter pub get` succeeds; `build_runner` runs cleanly on an empty codegen target.
- **Dependencies**: M0-2.
- **Priority**: P0 · **Labels**: `infra` · **Estimate**: S

### M0-4 · Port design tokens into Flutter theme
- **Description**: Implement `core/theme/*` (colors, typography, spacing, radii, shadows, `app_theme.dart`) from the Modernist `styles.css` tokens, light + dark.
- **Goal**: Every screen built afterward inherits correct visual identity automatically.
- **Acceptance criteria**: `ThemeData.light()`/`.dark()` render the correct bg/surface/text/accent colors, Archivo font, and zero corner radius on a smoke-test screen.
- **Dependencies**: M0-3.
- **Priority**: P0 · **Labels**: `flutter-ui`, `ux` · **Estimate**: M

### M0-5 · Build Miz* design-system widget kit
- **Description**: Implement `MizButton`, `MizCard`, `MizTag`, `MizInput`, `MizSegmentedControl`, `MizDivider`, `MizIconButton`, `MizIcons` per `docs/DESIGN.md` §2.
- **Goal**: Feature screens compose from a finished kit instead of hand-rolling styled widgets repeatedly.
- **Acceptance criteria**: Each widget has all documented states (default/pressed/disabled/etc.) and a widget test.
- **Dependencies**: M0-4.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: L

### M0-6 · Set up GoRouter with full route shell
- **Description**: Register every screen route from `docs/DESIGN.md` §6; unbuilt screens point at a shared "coming soon" stub.
- **Goal**: The whole app is navigable end-to-end from day one.
- **Acceptance criteria**: Every route reachable without crash; route names centralized, no hardcoded path strings in widgets.
- **Dependencies**: M0-2.
- **Priority**: P0 · **Labels**: `flutter-ui`, `infra` · **Estimate**: S

### M0-7 · Draft Linear backlog (this document) and push once authorized
- **Description**: Write the full epic/task breakdown; push to Linear via MCP once connected.
- **Goal**: Planning parity between docs and Linear.
- **Acceptance criteria**: Linear project "Miz" exists with matching epics/milestones/issues.
- **Dependencies**: none, blocked on Linear auth for the push step only.
- **Priority**: P1 · **Labels**: `docs` · **Estimate**: M

---

## Epic M1 — Onboarding + Home

**Goal**: First real, production-quality, pixel-faithful feature slice, on mock data.

### M1-1 · Onboarding 3-step flow
- **Description**: Intro / location rationale / remember-preferences toggle, dot progress, skip.
- **Goal**: Matches the approved prototype's `isOnboarding` state exactly.
- **Acceptance criteria**: All 3 steps render correctly, skip works from step 2 onward, `rememberPreferences` value carries into app state.
- **Dependencies**: M0-5, M0-6.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

### M1-2 · Home: time-of-day greeting + context
- **Description**: Greeting/context-chip logic per `docs/DESIGN.md` §5 (morning/lunch/evening/late).
- **Goal**: Home feels "alive," matches prototype's `renderVals()` logic exactly.
- **Acceptance criteria**: Unit test covers all 4 time bands' greeting/context output.
- **Dependencies**: M1-1.
- **Priority**: P0 · **Labels**: `flutter-ui`, `testing` · **Estimate**: S

### M1-3 · Home: quick-action grid, chips, rails, offers banner
- **Description**: 2×2 quick-action grid, quick chips, favorites rail (conditional), nearby rail, offers banner — mock `RESTAURANTS` data ported from the prototype.
- **Goal**: Full Home screen, pixel-faithful.
- **Acceptance criteria**: Matches prototype layout at 390×844; favorites rail hidden when empty; mock repository behind `RestaurantRepository` interface.
- **Dependencies**: M1-2.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: L

### M1-4 · Profile / Settings bottom sheet
- **Description**: Language, dark mode, notifications, location permission, remember-preferences toggles, privacy/about/help rows, logout.
- **Goal**: Dark mode toggle actually flips the live theme.
- **Acceptance criteria**: All toggles persist to a Riverpod-managed settings notifier; dark mode visibly changes the app.
- **Dependencies**: M0-4, M1-1.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

### M1-5 · Widget + unit tests for Milestone 1
- **Description**: Cover onboarding step transitions, home greeting logic, dark mode toggle.
- **Goal**: Milestone closes with green `flutter analyze` + `flutter test`.
- **Acceptance criteria**: Per `docs/TESTING.md` milestone checklist.
- **Dependencies**: M1-1…M1-4.
- **Priority**: P0 · **Labels**: `testing` · **Estimate**: M

---

## Epic M2 — Conversation & Summary Chips

**Goal**: The core Generative UI interaction: scripted Q&A that collapses into editable chips and produces Results.

### M2-1 · Conversation flow engine (scripted FLOW)
- **Description**: Port the prototype's `FLOW` step definitions (cuisine/budget/distance/dietary) into a typed Dart model + notifier.
- **Goal**: Same interaction shape as the prototype, ready to later be swapped for AI-driven mode selection (M7) with the same `AiResponse` shape.
- **Dependencies**: M0-5, M0-6.
- **Priority**: P0 · **Labels**: `flutter-ui`, `ai` · **Estimate**: M

### M2-2 · Summary Chip UI (accumulate, edit, reset-forward)
- **Goal**: Matches `docs/DESIGN.md` §4 exactly, including the edit-resets-later-steps behavior.
- **Acceptance criteria**: Editing chip N clears chips >N and re-enters the flow at N.
- **Dependencies**: M2-1.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

### M2-3 · Thinking transition + Results screen
- **Description**: `mizPulse` loading state, then Results cards (rating/price/distance/ETA/reason) from mock data filtered by collected chips.
- **Dependencies**: M2-1, M1-3 (shares restaurant data).
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: L

### M2-4 · Free-text input bar → flow entry
- **Description**: Text input at the bottom of Home/Discovery/Menu/Results/Restaurant screens routes into the conversation flow (keyword-matched pre-AI, per prototype's `handleSubmitInput`).
- **Dependencies**: M2-1.
- **Priority**: P1 · **Labels**: `flutter-ui` · **Estimate**: S

---

## Epic M3 — Restaurant Details & Discovery

### M3-1 · Restaurant details screen
- **Description**: Hero photo, rating/price/distance/open badge, reserve/order actions, menu highlights, photo grid, review, "Ask Miz" toggle.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: L

### M3-2 · Discovery screen (map placeholder + filterable list)
- **Description**: Filter chips (cuisine/all), list of restaurant rows with inline order/reserve actions.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

### M3-3 · Favorites / bookmarks
- **Description**: Toggle + persistence (local state now, `bookmarks` table in M6).
- **Priority**: P1 · **Labels**: `flutter-ui` · **Estimate**: S

---

## Epic M4 — Menu & Checkout

### M4-1 · Menu browser (search, category filter)
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

### M4-2 · Cart state + sticky cart bar
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: S

### M4-3 · Checkout (delivery/pickup, order placement)
- **Description**: Real payment gateway is out of scope (see `docs/PRD.md`); this milestone builds the UI and order-creation flow only.
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

---

## Epic M5 — Reservation & Tracking

### M5-1 · Reservation flow (date → time → guests → confirm)
- **Priority**: P0 · **Labels**: `flutter-ui` · **Estimate**: M

### M5-2 · Order tracking (status steps, live map placeholder)
- **Priority**: P1 · **Labels**: `flutter-ui` · **Estimate**: M

---

## Epic M6 — Supabase Integration

### M6-1 · Provision Supabase project + schema migration
- **Description**: Implement `docs/DATABASE.md` schema as SQL migrations.
- **Priority**: P0 · **Labels**: `supabase`, `database` · **Estimate**: L

### M6-2 · RLS policies for every table
- **Priority**: P0 · **Labels**: `supabase`, `security` · **Estimate**: M

### M6-3 · Auth (sign up / sign in / session)
- **Priority**: P0 · **Labels**: `supabase`, `backend` · **Estimate**: M

### M6-4 · Swap mock repositories → Supabase repositories
- **Description**: One-file swap per repository interface, per `docs/ARCHITECTURE.md` §4.
- **Priority**: P0 · **Labels**: `backend` · **Estimate**: L

---

## Epic M7 — AI Integration

### M7-1 · OpenAI Responses API client (`ai/openai/`)
- **Priority**: P0 · **Labels**: `ai` · **Estimate**: M

### M7-2 · Replace scripted FLOW with AI-driven mode selection
- **Description**: `AiClient.respond` produces the same `AiResponse` shape M2 already renders.
- **Dependencies**: M2, M7-1.
- **Priority**: P0 · **Labels**: `ai` · **Estimate**: L

---

## Epic M8 — Offline & Hardening

### M8-1 · Drift offline cache (profile, prefs, recents, bookmarks, conversation summaries)
- **Priority**: P0 · **Labels**: `database` · **Estimate**: L

### M8-2 · Security review (auth, RLS, secrets, delete-data/account flows)
- **Priority**: P0 · **Labels**: `security` · **Estimate**: M

### M8-3 · Performance pass (list virtualization, rebuild scoping, profiling)
- **Priority**: P1 · **Labels**: `flutter-ui`, `refactor` · **Estimate**: M

### M8-4 · Full test-suite pass to `docs/TESTING.md` coverage targets
- **Priority**: P0 · **Labels**: `testing` · **Estimate**: L

---

## Epic M9 — Beta Polish & Release Prep

### M9-1 · Wire real analytics vendor behind `core/analytics`
- **Priority**: P2 · **Labels**: `infra` · **Estimate**: S

### M9-2 · CI/CD pipeline (analyze/test/build on PR)
- **Priority**: P1 · **Labels**: `infra` · **Estimate**: M

### M9-3 · Store submission prep (icons, screenshots, privacy listing)
- **Priority**: P1 · **Labels**: `infra`, `ux` · **Estimate**: M
