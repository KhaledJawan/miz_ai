# Agent Change Log

## Rules

This file is the append-only record of changes made by agents working in this repository.

1. Every agent that modifies repository files must add one summary entry before finishing its task.
2. Before adding an entry, read this file again and find the highest existing entry number.
3. The next entry number is the highest number plus one. If there are no entries, start at `1000`.
4. Use exactly this single-line format: `NUMBER - AgentName [Concise summary of the completed changes]`.
5. Keep the summary factual and concise. Mention the main implementation, documentation, tests, or verification completed.
6. Never include secrets, credentials, tokens, private user data, or sensitive environment values.
7. Never edit, reorder, renumber, or delete an existing entry. If an entry needs correction, append a new correction entry.
8. Re-read the latest entry immediately before appending so concurrent agents do not intentionally reuse a number. If the intended number is already present, increment again.
9. Add the log entry only after the work is complete, so it describes the final result accurately.

## Entries

1000 - Codex [Created the append-only agent change log and registered its required workflow in the repository instructions and README.]
1001 - Codex [Fixed the Home composer to animate above software-keyboard insets and added a regression test confirming the input remains visible; analyze and all 15 tests pass.]
1002 - Claude [Sourced 7 local restaurant photos (Wikimedia Commons) into assets/images/restaurants/, added Restaurant.imageAsset and wired MockRestaurantRepository; removed the circular "M" avatar mark from HomeHeader, keeping the "Miz" wordmark only. Verified against the current Soft Orbit design (core/widgets, DesignGD.md); flutter analyze clean, all 15 tests pass.]
1003 - Codex [Refined Soft Orbit to a black, white, neutral-gray, and Miz-red interface; removed colorful tokens, multicolor gradients, and tinted shadows; rebuilt the orb, quick actions, offers, backdrop, onboarding accents, and profile treatment; synchronized design docs and ADR-011; analyze and all 15 tests pass.]
1004 - Codex [Fixed clipped shadows around the four Home quick-action cards by disabling grid viewport clipping and added a regression assertion; analyze and all 15 tests pass.]
1005 - Codex [Corrected the remaining Home quick-action shadow clipping by moving elevation outside the rounded Material, increasing grid spacing, and replacing unsupported rounded icon glyphs with supported icons and a text arrow; analyze and all 15 tests pass.]
1006 - Codex [Compacted Home by moving Today's Offers into the removed greeting-card position, deleting Popular Cravings and meal-period chip sections, changing the composer prompt to “What do you want to eat?”, and synchronizing product/design docs; analyze and all 15 tests pass.]
1007 - Codex [Removed the Nearby restaurant rail and its loading state from Home, updated tests to prevent the section returning, and synchronized product/design documentation so nearby browsing lives in Discovery; analyze and all 15 tests pass.]
1008 - Codex [Added typed English, Farsi, and German localization with a working language picker, automatic RTL/LTR layouts, localized UI and semantics, platform locale metadata, extension documentation, and 20 passing tests; analyze and Android debug build pass.]
1009 - Codex [Persisted the selected locale through a tested LanguageStore boundary, added compact German and Farsi Home layout coverage, and reverified analyze, all 21 tests, platform metadata, and the Android debug build.]
1010 - Claude [Replaced the placeholder app-intro onboarding with a full local-only, deterministic (no AI) Food Preference Profile: a live Drift/SQLite database (core/database/, ~19 tables, seeded allergens/intolerances/food rules/ingredients/cuisines/flavors/~24 sample foods with bundled Wikimedia photos), an 11-screen adaptive onboarding flow (features/food_profile/presentation/onboarding/, diet-adaptive protein questions, inline severe-allergy confirmation, per-screen persistence/resume, skip-never-reopens), a permanent editable Food Profile section in Settings reusing the same step widgets with immediate-write persistence, and deterministic FoodEligibilityService/ProfileCompletenessService/InteractionTracker/BehavioralInferenceService (allergy/intolerance/restriction data kept on independent axes from preference/dislike throughout). Removed the superseded features/onboarding/. Added ADR-013/014/015/016 and a new "Local database (Drift)" section in docs/DATABASE.md. flutter analyze clean; 54 tests pass (17 new); Android debug build passes; full onboarding + Settings edit flow visually verified on macOS.]
1011 - Claude [Fixed a real-device hang introduced by entry 1010: sqlite3_flutter_libs was pinned to ^0.6.0+eol, an empty stub package with no bundled native SQLite library, so opening the local database in bootstrap.dart before runApp never resolved and the app was stuck forever on the native splash screen on Android (confirmed via adb logcat: the engine endlessly retried its first frame with no Dart-side exception). Repinned to ^0.5.42, the last version that actually bundles the native library. Added ADR-017 documenting the root cause and fix. Verified with a full uninstall/reinstall on a physical Android device (API 36): app now reaches the Welcome screen. flutter analyze clean; all 54 tests still pass.]
