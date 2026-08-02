# Style Guide — Miz

Related: [`CLAUDE.md`](../CLAUDE.md) (binding rules), [`docs/ARCHITECTURE.md`](ARCHITECTURE.md).

## Files & naming

- Files: `snake_case.dart`. One public widget/class per file, filename matches the class (`miz_button.dart` → `MizButton`).
- Classes/enums/typedefs: `UpperCamelCase`. Members/variables/functions: `lowerCamelCase`. Constants: `lowerCamelCase` (Dart convention, not `SCREAMING_CASE`).
- Riverpod providers: codegen names are auto-derived from the annotated function/class (`@riverpod Restaurant currentRestaurant(...)` → `currentRestaurantProvider`); name the function for what it returns, not how.
- Design-system widgets are prefixed `Miz` (`MizButton`, `MizCard`). Feature-specific widgets are not prefixed — their folder gives context (`features/home/presentation/widgets/quick_action_grid.dart`).
- Route path constants live in `core/router/app_router.dart` as `static const` strings; never inline a route string.

## Imports

Order: Dart SDK → Flutter → third-party packages → project-relative (`package:miz_ai/...` or relative within the same feature), each group separated by a blank line, alphabetized within a group. Let `dart format`/`flutter_lints` enforce this — don't hand-tune order beyond that.

## Widget structure

- Prefer small, composed widgets over one large `build()`. If a `build()` method exceeds ~60 lines or nests nested `if`/`sc-if`-equivalent branching more than 2 levels, extract child widgets.
- Stateless by default. Only use `ConsumerStatefulWidget`/local `State` for pure UI concerns (animation controllers, text controllers) — anything that's actually app state belongs in a Riverpod notifier, not `setState`.
- Constructor parameters: `required` named parameters for anything without a sensible default; positional only for the rare single-obvious-argument widget.

## Riverpod

- One notifier per screen-level concern (see `CLAUDE.md` §7). Notifier files live in `presentation/providers/`.
- Prefer `ref.watch(provider.select((s) => s.field))` over watching a whole state object in a widget that only needs one field.
- Async data: `AsyncNotifier`/`FutureProvider`, handled in widgets via `.when(data:, error:, loading:)` — never manually track a boolean `isLoading` flag beside a value.

## Domain models

- `freezed` for entities/value objects — immutability and `copyWith` come for free, and equality is correct without manual overrides.
- Domain entities never import `dart:ui`/Flutter/Supabase/Dio types. If a field needs a UI-only representation (e.g. a `Color`), that mapping happens in `presentation/`, not `domain/`.

## Error handling

- `domain/` repository methods return a `Result<T, Failure>`-shaped type (see `core/error/result.dart`), not thrown exceptions, for expected failure paths (network error, not-found). Reserve actual `throw` for programmer errors (invariant violations).
- Widgets handle `Failure` via the same `.when`-style pattern as async data — no bare `try/catch` scattered through `build()`.

## Comments

- Default to none. Add a comment only for non-obvious *why* (a workaround, a subtle invariant, a spec cross-reference like "matches prototype's `renderVals()` time bands") — never restate *what* the code already says via naming.

## Formatting

- `dart format` is authoritative; don't hand-format around it. `flutter_lints` (already in `pubspec.yaml`) governs lint rules — don't disable a rule inline without a comment explaining why, reviewed case by case.
