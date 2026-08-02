# Miz

**An AI-first Food & Restaurant Assistant.** Built by Merlin ICT.

Miz is not a chatbot bolted onto a food app. It's a conversation-driven, UI-first assistant: the AI decides which interface best answers what you're craving — a card grid, a comparison table, a reservation flow — and you make decisions by tapping, not typing walls of text. Typing always remains available; it's never required.

## Status

M0 and M1 are complete. The current product-design migration adopts the rounded Soft Orbit system before Milestone 2 (Conversation + Summary Chips) begins. See [`docs/ROADMAP.md`](docs/ROADMAP.md) for milestone status.

## Stack

| Layer | Choice |
|---|---|
| Client | Flutter (iOS, Android, Web) |
| State | Riverpod (codegen) |
| Navigation | GoRouter |
| Localization | Flutter gen-l10n/ARB — English, Farsi (RTL), German |
| Backend | Supabase (Postgres, Auth, Storage, Realtime) — consumed via API only |
| AI | OpenAI Responses API |
| Offline | Drift (SQLite) + flutter_secure_storage + shared_preferences |
| Architecture | Clean Architecture, feature-first |

## Documentation

Read these **before** touching code — see [`CONTRIBUTING.md`](CONTRIBUTING.md) for the required order.

- [`CLAUDE.md`](CLAUDE.md) — binding rules for any AI agent (or human) working in this repo
- [`AGENTS.md`](AGENTS.md) — specialized agent roster and when to use each
- [`log.md`](log.md) — append-only numbered summaries of repository changes made by agents
- [`docs/PRD.md`](docs/PRD.md) — product requirements, personas, success metrics
- [`docs/DESIGN.md`](docs/DESIGN.md) — design system, Generative UI, Summary Chips
- [`DesignGD.md`](DesignGD.md) — approved Soft Orbit execution specification and page-level redesign direction
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — layering, folder structure, scalability
- [`docs/LOCALIZATION.md`](docs/LOCALIZATION.md) — language catalog, RTL/LTR rules, adding locales
- [`docs/DATABASE.md`](docs/DATABASE.md) — Supabase schema and RLS
- [`docs/API.md`](docs/API.md) — Mizzz independence contract, OpenAI integration contract
- [`docs/ROADMAP.md`](docs/ROADMAP.md) — milestones
- [`docs/LINEAR_BACKLOG.md`](docs/LINEAR_BACKLOG.md) — epics/tasks (mirrors Linear project "Miz")
- [`docs/DECISIONS.md`](docs/DECISIONS.md) — architecture decision records
- [`docs/STYLE_GUIDE.md`](docs/STYLE_GUIDE.md) — Dart/Flutter conventions
- [`docs/SECURITY.md`](docs/SECURITY.md) — secrets, RLS, data deletion
- [`docs/TESTING.md`](docs/TESTING.md) — test strategy
- [`docs/DEPLOYMENT.md`](docs/DEPLOYMENT.md) — build flavors, CI/CD
- [`docs/CHANGELOG.md`](docs/CHANGELOG.md) — notable changes per milestone

## Getting started

```bash
flutter pub get
flutter run --dart-define-from-file=.env.json   # see docs/SECURITY.md for .env.json shape
```

Run tests:

```bash
flutter analyze
flutter test
```

## Project independence

Miz is a standalone product. It never reads Mizzz's (the related Merlin ICT product) database directly — all cross-product data flows through APIs. See [`docs/API.md`](docs/API.md).
