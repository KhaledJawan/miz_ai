# Roadmap — Miz

Full task-level detail lives in [`docs/LINEAR_BACKLOG.md`](LINEAR_BACKLOG.md) (mirrors the Linear project "Miz" once the Linear connector is authorized — see note at the top of that file). This document tracks milestone-level status only.

| Milestone | Name | Scope | Status |
|---|---|---|---|
| M0 | Foundation | Docs, Linear backlog, Flutter scaffold, design-system port, navigable route shell | 🟢 Done |
| M1 | Onboarding + Home | First real, pixel-faithful, mock-data screens | 🟢 Done |
| M2 | Conversation & Summary Chips | Scripted chat flow, chips, thinking transition, Results (Generative UI, mock/scripted) | ⚪ Not started |
| M3 | Restaurant Details & Discovery | Details screen, map+list discovery, favorites/bookmarks | ⚪ Not started |
| M4 | Menu & Checkout | Menu browser, cart, checkout | ⚪ Not started |
| M5 | Reservation & Tracking | Reservation flow, order tracking | ⚪ Not started |
| M6 | Supabase Integration | Schema live, auth, repositories swapped from mock → Supabase, RLS | ⚪ Not started |
| M7 | AI Integration | OpenAI Responses API replaces scripted flow for mode selection | ⚪ Not started |
| M8 | Offline & Hardening | Drift offline cache wired, security review, performance pass, full test coverage | ⚪ Not started |
| M9 | Beta Polish & Release Prep | Analytics wired, CI/CD, store submission prep | ⚪ Not started |

Legend: 🔵 in progress · ⚪ not started · 🟢 done

M1's placeholder onboarding (generic intro + location rationale, no lasting data) has since been replaced by the full Food Preference Profile onboarding — a local-only, deterministic (no AI) taste/allergy/preference flow backed by a live Drift database, permanently editable from Settings. See `docs/DATABASE.md` "Local database (Drift)" and ADR-013/014/015. This is additive depth within M1's original scope, not a new milestone.

## Working rule

One milestone at a time. Each milestone closes with: review → refactor → test → document → (commit, if requested) — see [`CONTRIBUTING.md`](../CONTRIBUTING.md). No milestone starts before the previous one's docs are updated to match reality.
