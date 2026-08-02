# Localization — Miz

Miz ships in English (`en`), Farsi (`fa`), and German (`de`). English and German render left-to-right; Farsi renders right-to-left through Flutter's localization delegates.

## Architecture

- Source translations live in `lib/l10n/app_<code>.arb`.
- `app_en.arb` is the template and defines every key, placeholder type, and description.
- `flutter gen-l10n` generates typed `AppLocalizations` classes under `lib/l10n/`.
- Widgets read copy through `context.l10n`; feature widgets never select a language or parse ARB files themselves.
- `AppLanguage` is the supported-language registry. Settings persist the stable locale code (`en`, `fa`, or `de`) locally through `LanguageStore`, never the translated language name; the profile record can sync the same code in M6.
- `MizApp` owns `locale`, `supportedLocales`, and delegates. Changing `AppSettings.languageCode` rebuilds the app and lets Flutter provide the correct `TextDirection`.
- iOS/macOS `CFBundleLocalizations` and Android's locale config advertise the same supported set to each platform.

Dynamic restaurant names and editorial content remain repository data. UI labels, units, cuisine categories, routes, controls, and accessibility semantics are localized in the client. Live multilingual restaurant content must be modeled explicitly in the API/database contract before M6 rather than embedded in widgets.

## Adding a language

1. Add the locale to `AppLanguage` with a stable code and native display name.
2. Copy `lib/l10n/app_en.arb` to `lib/l10n/app_<code>.arb` and translate every value without changing keys or placeholders.
3. Run `flutter gen-l10n`.
4. Add widget coverage for representative translated text and the locale's expected direction.
5. Run `flutter analyze` and `flutter test`.

Use directional layout APIs (`EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`, start/end) for all new UI. Do not manually wrap individual screens in `Directionality`; locale selection at the app root owns direction.
