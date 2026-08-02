import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/localization/app_language.dart';
import '../../../../core/localization/language_store.dart';
import '../../domain/app_settings.dart';

part 'app_settings_controller.g.dart';

/// Root-level settings state — `app.dart` watches [darkMode] to drive
/// [ThemeMode]. Session-only until Milestone 6/8 persistence lands.
@Riverpod(keepAlive: true)
class AppSettingsController extends _$AppSettingsController {
  @override
  AppSettings build() => AppSettings(
    languageCode: AppLanguage.fromCode(
      ref.watch(initialLanguageCodeProvider),
    ).code,
  );

  void toggleDarkMode() => state = state.copyWith(darkMode: !state.darkMode);

  void setLanguage(AppLanguage language) {
    state = state.copyWith(languageCode: language.code);
    final store = ref.read(languageStoreProvider);
    if (store != null) unawaited(store.writeLanguageCode(language.code));
  }

  void toggleNotifications() =>
      state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);

  void toggleLocationPermission() => state = state.copyWith(
    locationPermissionGranted: !state.locationPermissionGranted,
  );

  void toggleRememberPreferences() =>
      state = state.copyWith(rememberPreferences: !state.rememberPreferences);

  void setRememberPreferences(bool value) =>
      state = state.copyWith(rememberPreferences: value);
}
