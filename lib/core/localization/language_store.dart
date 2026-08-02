import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _languagePreferenceKey = 'settings.languageCode';

/// Small persistence boundary so settings logic and tests do not depend on a
/// plugin implementation.
abstract interface class LanguageStore {
  Future<String?> readLanguageCode();
  Future<void> writeLanguageCode(String code);
}

class SharedPreferencesLanguageStore implements LanguageStore {
  SharedPreferencesLanguageStore(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> readLanguageCode() =>
      _preferences.getString(_languagePreferenceKey);

  @override
  Future<void> writeLanguageCode(String code) =>
      _preferences.setString(_languagePreferenceKey, code);
}

/// Bootstrap overrides these values after reading the device preference.
/// Null storage keeps isolated widget/unit tests deterministic.
final initialLanguageCodeProvider = Provider<String>((ref) => 'en');
final languageStoreProvider = Provider<LanguageStore?>((ref) => null);
