# AGENTS.md

Specialized agent roles for building Miz. These describe *how to think* when working in a given capacity, whether that's an actual spawned subagent or just the hat a single agent should wear for a task. All agents inherit the rules in [`CLAUDE.md`](CLAUDE.md) — nothing below overrides it.

Any agent that changes repository files must also append its completed-work entry to [`log.md`](log.md) using the next available number, as required by `CLAUDE.md` §15.

---

## Flutter UI Agent

**Responsibilities**: Build screens and widgets matching the approved design pixel-for-pixel; implement the `Miz*` design-system widget kit; wire widgets to Riverpod providers (never own business logic itself).

**Input**: A screen/state from the approved Soft Orbit direction (`DesignGD.md` / `docs/DESIGN.md`), plus the relevant `domain/` entities and provider contracts. The older `Miz.dc.html` prototype is a flow/content reference only.

**Output**: Widget files under `features/<feature>/presentation/` or `core/widgets/`, plus a widget test for the primary state.

**Rules**: Use the semantic circle/capsule/rounded-rectangle hierarchy from `DesignGD.md`. Archivo type scale from `core/theme/app_typography.dart`. No inline magic numbers for spacing, radii, colors, shadows, or motion — use theme tokens. No business logic in `build()`.

**When to use**: Any screen or component implementation task.

---

## Backend Agent

**Responsibilities**: Design and implement API-consuming repositories (`data/` layer), request/response models, error mapping into `core/error/failures.dart`.

**Input**: A `domain/` repository interface and the corresponding `docs/API.md` / `docs/DATABASE.md` contract.

**Output**: A `data/` implementation registered behind a Riverpod provider, matching the interface exactly.

**Rules**: Never call Mizzz's database directly — API only. Never leak Supabase/Dio exception types past the `data/` layer; map to domain failures.

**When to use**: Wiring a feature to Supabase or any external API.

---

## Supabase Agent

**Responsibilities**: Schema migrations, RLS policies, Supabase Auth configuration, Storage buckets, Realtime channel setup.

**Input**: `docs/DATABASE.md` schema section for the table(s) in scope.

**Output**: SQL migration files, an updated `docs/DATABASE.md` if the schema changed, RLS policies reviewed against `docs/SECURITY.md`.

**Rules**: Every table ships with RLS enabled and an explicit policy — no table goes live open. Never generate or commit a service-role key.

**When to use**: Any change to the Supabase project's schema, auth rules, or storage.

---

## Database Agent

**Responsibilities**: Offline schema design (Drift), cache invalidation strategy, sync-conflict resolution between offline cache and Supabase.

**Input**: The list of cacheable domains from `docs/ARCHITECTURE.md` (profile, preferences, recent restaurants, bookmarks, recent searches, conversation summaries).

**Output**: Drift table definitions under `core/storage/`, a documented sync strategy in `docs/ARCHITECTURE.md`.

**Rules**: Offline cache is a cache, not a second source of truth — always define what wins on conflict.

**When to use**: Offline support work, local persistence schema changes.

---

## AI Agent

**Responsibilities**: `ai/` module — the provider-agnostic `AiClient` interface and the OpenAI Responses API implementation; prompt/response contracts that drive Generative UI mode selection.

**Input**: The conversation/UI-mode contract from `docs/API.md` and `docs/DESIGN.md`.

**Output**: `ai/core/` interfaces, `ai/openai/` implementation, typed response models — never raw `dynamic` JSON handed to the UI layer.

**Rules**: Only implement what the current milestone requires (see `CLAUDE.md` §11). Every new capability (function calling, structured outputs, voice, Realtime, RAG, vision, MCP) gets an extension point documented in `docs/API.md` before or alongside implementation, not after.

**When to use**: Any AI integration or prompt/response-contract work.

---

## Testing Agent

**Responsibilities**: Unit tests for notifiers/use-cases/repositories, widget tests for screens, integration tests for critical flows (onboarding→home, chat→results, checkout).

**Input**: The feature/module under test plus its `domain/` contracts.

**Output**: Test files mirroring source paths (see `CLAUDE.md` §3), using `mocktail` for external boundaries.

**Rules**: No real network calls in `flutter test`. No milestone marked done without analyze+test passing per `docs/TESTING.md`.

**When to use**: After any feature implementation, before a milestone is marked complete.

---

## UX Agent

**Responsibilities**: Fill genuine UX gaps not covered by the approved design, using professional judgment that never reduces usability; review flows for friction, accessibility, and consistency with `docs/DESIGN.md`.

**Input**: A gap or ambiguity found while implementing a screen.

**Output**: A documented decision in `docs/DECISIONS.md` plus the resulting design note in `docs/DESIGN.md` if the pattern will recur.

**Rules**: Never invent a new visual language — extend the existing Modernist system's tokens/components. When genuinely unsure, prefer the more accessible/more explicit option.

**When to use**: When a screen state exists in product requirements but isn't in the approved prototype.

---

## Documentation Agent

**Responsibilities**: Keep `docs/*` and root `README.md`/`CLAUDE.md`/`AGENTS.md` in sync with what the code actually does; update `docs/CHANGELOG.md` and `docs/ROADMAP.md` at milestone boundaries.

**Input**: A completed milestone or a merged architectural change.

**Output**: Updated docs, cross-links verified, `docs/DECISIONS.md` entry for any non-obvious choice.

**Rules**: Docs describe current reality, not aspiration — if code and docs disagree, that's a bug in one of them, fix both.

**When to use**: End of every milestone (mandatory), and any time behavior diverges from what's documented.

---

## Refactoring Agent

**Responsibilities**: Simplify, deduplicate, and re-align code with `docs/STYLE_GUIDE.md` after a milestone's features are functionally complete.

**Input**: A completed, tested feature.

**Output**: The same feature, functionally identical, with duplication removed and structure aligned to `docs/ARCHITECTURE.md`.

**Rules**: Refactors must not change behavior — if a refactor reveals a bug, fix it as a separate, named change, not silently inside the refactor.

**When to use**: After tests pass for a milestone, before it's marked done (per the "review, refactor, test, document" milestone rule).

---

## Security Agent

**Responsibilities**: Review auth flows, RLS policies, secret handling, and data-deletion flows against `docs/SECURITY.md`; check for OWASP-class issues (injection, insecure storage, improper session handling) in new code.

**Input**: Any change touching auth, storage, network, or user data.

**Output**: A findings list (fixed inline for clear issues, flagged for judgment calls) and an updated `docs/SECURITY.md` if the threat model changed.

**Rules**: Follow the dual-use/defensive-security posture in the top-level system rules — this agent hardens Miz, it doesn't build attack tooling.

**When to use**: Before any milestone touching auth, payments/checkout, or personal data is marked done.
