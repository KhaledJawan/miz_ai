# Contributing — Miz

## Required reading order

Before implementing anything, per [`CLAUDE.md`](CLAUDE.md) §14:
1. This file + [`CLAUDE.md`](CLAUDE.md) + [`AGENTS.md`](AGENTS.md).
2. [`docs/PRD.md`](docs/PRD.md) and [`docs/DESIGN.md`](docs/DESIGN.md) for the feature's product/UX intent.
3. [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) and, if relevant, [`docs/DATABASE.md`](docs/DATABASE.md)/[`docs/API.md`](docs/API.md).
4. [`docs/ROADMAP.md`](docs/ROADMAP.md) / [`docs/LINEAR_BACKLOG.md`](docs/LINEAR_BACKLOG.md) to confirm the task belongs to the current milestone.

## Milestone workflow

Work one milestone at a time (see `docs/ROADMAP.md`). For each milestone:

1. **Build** the milestone's tasks per the backlog.
2. **Review** — re-read the diff against `docs/DESIGN.md`/`docs/ARCHITECTURE.md` for fidelity and layering violations.
3. **Refactor** — remove duplication, align naming to `docs/STYLE_GUIDE.md`, without changing behavior.
4. **Test** — `flutter analyze` clean, `flutter test` passing, manual run-through per `docs/TESTING.md`.
5. **Document** — update `docs/CHANGELOG.md`, `docs/ROADMAP.md` status, and `docs/DECISIONS.md` for any non-obvious call made along the way.
6. **Commit** — only when explicitly asked (see below).

Do not start the next milestone's tasks until the current milestone's docs are updated to match reality.

## Branching

`main` is always deployable to at least the previous milestone's state. Feature work happens on `feature/<milestone>-<short-name>` branches (e.g. `feature/m1-onboarding`), merged back once the milestone workflow above is complete.

## Commits

- Commits are created only when the user explicitly asks for one.
- Message format: short imperative summary line (<70 chars), blank line, body explaining *why* if not obvious from the diff. Reference the milestone/task id from `docs/LINEAR_BACKLOG.md` when applicable (e.g. `M1-3`).
- Never `--force` push, never `--no-verify`, never amend a commit that wasn't just created in the same session — see `CLAUDE.md` §13.

## Pull requests

- One PR per milestone task (or a tightly related small group), not one PR per milestone. Large PRs are hard to review meaningfully.
- PR description: what changed, why, and a test-plan checklist (mirroring `docs/TESTING.md`'s milestone checklist).

## Code review checklist

- [ ] Matches `docs/STYLE_GUIDE.md` naming/structure.
- [ ] No layering violation (`presentation` importing `data`, feature importing another feature's internals) — see `CLAUDE.md` §2–3.
- [ ] No hardcoded route strings, no magic spacing numbers, no rounded corners.
- [ ] Tests added/updated per `docs/TESTING.md`.
- [ ] Docs updated if behavior, schema, or architecture changed.
