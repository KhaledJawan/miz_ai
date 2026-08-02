# Testing — Miz

Related: [`CLAUDE.md`](../CLAUDE.md) §12, [`AGENTS.md`](../AGENTS.md) (Testing Agent), [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) §9.

## Test types

| Type | Tool | Covers |
|---|---|---|
| Unit | `flutter_test` + `mocktail` | Notifiers, use-cases, repository logic, pure domain functions (e.g. greeting-by-hour) |
| Widget | `flutter_test` | Individual `Miz*` components and feature widgets — primary state + at least one alternate state |
| Integration | `integration_test` | Critical end-to-end flows: onboarding→home, chat→results, menu→checkout, reservation flow |

## Milestone completion checklist

A milestone is not "done" (per `CLAUDE.md` §12 and `CONTRIBUTING.md`'s workflow) until:

- [ ] `flutter analyze` — zero issues.
- [ ] `flutter test` — all green.
- [ ] Every notifier/use-case added or changed has a unit test.
- [ ] Every new screen has at least one widget test for its primary state transition.
- [ ] The milestone's screens were actually run (via the `run` skill or manual `flutter run`) and visually checked against the approved design at the 390×844 reference frame, in both light and dark theme.
- [ ] No real network call occurs during `flutter test` (verify by running with network disabled if unsure).

## Mocking conventions

- Mock at the repository/client boundary (`domain/` interfaces), using `mocktail`. Never mock a Flutter widget or a Riverpod provider's internals directly — override the provider with a test double instead (`ProviderScope(overrides: [...])`).
- Supabase and OpenAI clients are never instantiated in a unit or widget test — only their `domain/`-facing repository/`AiClient` fakes are.

## Coverage targets

- `domain/` layer (entities, use-cases, notifiers' business logic): high coverage expected — this is where correctness bugs hide.
- `presentation/` layer: at least the primary render path and one interaction per screen; not chasing 100% on pure layout code.
- `data/` layer: cover mapping/error-translation logic; don't test the underlying SDK itself.

## Test file layout

Mirrors source path exactly (`CLAUDE.md` §3): `lib/features/home/domain/greeting.dart` → `test/features/home/domain/greeting_test.dart`.

## Manual QA reference

Every milestone's manual check-through uses the approved prototype (`Miz.dc.html`) as the visual reference — compare side-by-side, not from memory. Check: light + dark theme, empty states (e.g. no favorites), and the smallest supported phone width.
