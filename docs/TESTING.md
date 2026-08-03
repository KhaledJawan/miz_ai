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

Every milestone's manual check-through uses `DesignGD.md` and the approved reference imagery as the visual source — compare side-by-side, not from memory. Check light/dark, empty/unavailable states, 390×844, 320×720, keyboard-open, reduced motion, and Farsi RTL.

Native capability changes also require a real-device or correctly configured simulator check. For current location, verify first-request approval, denial, device-location-disabled, and a simulated position near a supported city. For food vision, verify camera/gallery cancellation, one centered dish, non-food uncertainty, offline/retry, and English/German/Farsi output. For menu vision, verify camera permission/cancel/retake, gallery cancel, one and four pages, unreadable text, offline/retry, and all three locales. For Miz QR, verify live preview/permission denial, invalid and expired payloads, duplicate-frame suppression, and the trusted-verification-required state. Unit/widget tests replace OS and network gateways and never request real permissions or paid provider calls.

The Spatial visual suite keeps approved 390×844 references for Home in light and dark themes, City in dark theme, and Camera in light theme under `test/visual/goldens/`. Regenerate them only for an intentional approved visual change, then inspect the rendered images before accepting the update.
