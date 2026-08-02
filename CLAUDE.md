# CLAUDE.md

Binding rules for any AI agent (Claude, Codex, or otherwise) working in this repository. These rules are not suggestions — do not ignore them, do not "helpfully" work around them. If a request conflicts with a rule here, flag the conflict to the user instead of silently picking one side.

## 1. Project goals

Miz is an AI-first Food & Restaurant Assistant by Merlin ICT. It is conversation-driven but **UI-first**: the AI should generate interfaces (cards, comparisons, forms) instead of long text whenever a decision can be made by tapping. See [`docs/PRD.md`](docs/PRD.md) for full product goals and [`docs/DESIGN.md`](docs/DESIGN.md) for the Generative UI / Summary Chip model.

Non-negotiables:
- Production-ready quality at every milestone. No placeholders, no "TODO: implement later" widgets shipped as if done, no ugly interim layouts.
- Miz and Mizzz (a separate Merlin ICT product) are fully independent. Miz never touches Mizzz's database directly — API only. See [`docs/API.md`](docs/API.md).
- The approved Soft Orbit direction in [`DesignGD.md`](DesignGD.md) is the source of truth for visual identity. The older `Miz.dc.html` prototype remains a product-flow reference, not a source for the superseded square-only styling. Fill genuine gaps with professional UX decisions that never reduce usability, and document recurring decisions in [`docs/DECISIONS.md`](docs/DECISIONS.md).

## 2. Architecture

Clean Architecture, feature-first, Riverpod for state, GoRouter for navigation, Supabase for backend, OpenAI Responses API for AI. Full detail in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md). In short:

```
lib/
  core/        theme, router, network, storage, error, analytics, shared widgets
  ai/          provider-agnostic AI client + OpenAI implementation
  features/    one folder per feature, each with data/domain/presentation
```

Never let `presentation/` import a concrete data-source class directly — depend on the `domain/` repository interface, inject the implementation via Riverpod.

## 3. Folder rules

- One feature = one folder under `features/`. A feature that needs `data/`, `domain/`, and `presentation/` gets all three; don't create empty layers "for consistency."
- Shared, cross-feature UI goes in `core/widgets/`, not duplicated per feature.
- Nothing in `features/**` imports from another feature's `data/` or `domain/` internals. Cross-feature reuse goes through `core/` or a promoted shared package.
- Test files mirror the source path: `lib/features/home/domain/greeting.dart` → `test/features/home/domain/greeting_test.dart`.

## 4. Coding rules

- No dead code, no commented-out blocks, no speculative abstractions for hypothetical future requirements. Three similar call sites beat a premature abstraction.
- No `print()` — use the logging wrapper in `core/`.
- No hardcoded strings for user-facing copy that will need localization — but do not build a full i18n pipeline before it's asked for; keep copy centralized enough to extract later (see [`docs/DECISIONS.md`](docs/DECISIONS.md) for the current stance).
- No secrets, API keys, or Supabase service-role keys committed anywhere, ever. See [`docs/SECURITY.md`](docs/SECURITY.md).
- Null safety is not optional-chained away with `!` unless the invariant is truly guaranteed and commented why.

## 5. Flutter rules

- Every screen must be usable on small phones (iPhone SE-class width) without overflow; test against the design's 390×844 frame first.
- Prefer `const` constructors everywhere possible.
- Extract any widget subtree used more than twice, or any subtree over ~40 lines, into its own widget file.
- Images: always use `cached_network_image` for remote photos; never a bare `Image.network`.
- Use the semantic rounded shape hierarchy in [`DesignGD.md`](DesignGD.md): circles for compact actions, capsules for short controls, and rounded rectangles for content surfaces. Never introduce one-off radius values in feature widgets.

## 6. Naming conventions

- Files: `snake_case.dart`. Classes: `UpperCamelCase`. Providers: `camelCaseProvider` (or generated name from `@riverpod`).
- Widgets ported from the design system are prefixed `Miz` (`MizButton`, `MizCard`, `MizTag`, …) and live in `core/widgets/`.
- Route names/paths are centralized in `core/router/app_router.dart` — never hardcode a route string in a widget.

## 7. Riverpod rules

- Use `@riverpod` codegen (`riverpod_annotation` + `riverpod_generator`), not the legacy manual provider syntax, for anything beyond a trivial constant provider.
- One controller/notifier owns one feature's screen-level state. Don't let a home-screen notifier reach into reservation state.
- Repositories are exposed as providers returning the `domain/` interface type, never the concrete implementation type, so swapping mock → Supabase is a one-line change at the provider definition.
- No business logic inside widgets — widgets read providers and call notifier methods; logic lives in the notifier/use-case.

## 8. UI rules

- Match the approved Soft Orbit direction on layout, spacing, shape, type scale, color, depth, and motion. Use the semantic theme tokens and required transitions in [`DesignGD.md`](DesignGD.md); do not mix the retired square system into redesigned screens.
- Every interactive element needs visible pressed/focused/disabled states and a Semantics label for accessibility. Disabled mic/camera controls remain visibly present, visibly inert, and labeled "coming soon."
- Dark mode is a first-class theme, not an afterthought — both light and dark tokens must be defined together in `core/theme/`.

## 9. Performance rules

- No unbounded lists without `ListView.builder`/lazy construction.
- No rebuilding the entire screen from a single top-level provider watch — scope `ref.watch` to the smallest widget that needs it (`Consumer`/`.select`).
- Profile any screen with an animation or scroll-heavy list before calling a milestone done.

## 10. Security rules

- All secrets via `--dart-define`/`--dart-define-from-file`, never literals in source. See [`docs/SECURITY.md`](docs/SECURITY.md).
- Supabase access is governed by Row Level Security; no table ships without an explicit RLS policy reviewed in [`docs/DATABASE.md`](docs/DATABASE.md).
- Auth tokens live in `flutter_secure_storage`, never `shared_preferences`.
- User-initiated "Delete Data" / "Delete Account" (see Settings in [`docs/PRD.md`](docs/PRD.md)) must actually cascade-delete, not soft-flag-and-forget — verify against the schema in `docs/DATABASE.md`.

## 11. AI rules

- All AI calls go through the `ai/` module's provider-agnostic `AiClient` interface — features never call OpenAI's SDK/HTTP directly.
- Only implement what the current milestone needs. Function calling, structured outputs, voice, Realtime API, RAG, vision, and MCP are architected for (interfaces/extension points exist) but not built until a milestone specifically calls for them. See [`docs/API.md`](docs/API.md).
- AI responses that drive UI must be validated/typed before being trusted to select a screen mode — never `dynamic`-cast an AI response straight into navigation.

## 12. Testing rules

- No milestone is "done" without: `flutter analyze` clean, `flutter test` passing, and the affected screens run and visually checked (see [`docs/TESTING.md`](docs/TESTING.md)).
- Business logic (notifiers, use-cases, repositories) gets unit tests. Screens get at least one widget test covering their primary state transition.
- Mock external services (Supabase, OpenAI) at the repository/client boundary — never hit real network in `flutter test`.

## 13. Git rules

- Do not commit unless explicitly asked. When asked, follow [`CONTRIBUTING.md`](CONTRIBUTING.md) for commit message and branch conventions.
- Never `git push --force`, never skip hooks, never amend a commit that wasn't just created in the same session.

## 14. Process rule (applies above all the others)

Before implementing any feature:
1. Read the relevant docs above.
2. Verify architecture and dependencies against `docs/ARCHITECTURE.md`.
3. Verify design consistency against `docs/DESIGN.md` / the approved prototype.
4. Update documentation if the feature changes any of the above.

Only then write code. Work milestone by milestone (see `docs/ROADMAP.md`); after each milestone: review, refactor, test, document — only then move to the next.

## 15. Agent change log

Every agent that modifies repository files must append one completed-work summary to [`log.md`](log.md) before finishing. Follow the format, next-number lookup, append-only behavior, concurrency check, and secret-handling rules defined at the top of that file. Re-read `log.md` immediately before adding the entry and use the highest existing entry number plus one; the sequence starts at `1000`.
