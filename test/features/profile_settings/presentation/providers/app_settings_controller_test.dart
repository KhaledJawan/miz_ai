import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/profile_settings/presentation/providers/app_settings_controller.dart';
import 'package:miz_ai/core/localization/app_language.dart';
import 'package:miz_ai/core/localization/language_store.dart';

void main() {
  test('toggleDarkMode flips darkMode and leaves other fields untouched', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appSettingsControllerProvider).darkMode, isFalse);

    container.read(appSettingsControllerProvider.notifier).toggleDarkMode();

    final state = container.read(appSettingsControllerProvider);
    expect(state.darkMode, isTrue);
    expect(state.notificationsEnabled, isTrue);
  });

  test(
    'toggleNotifications and toggleLocationPermission flip independently',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(appSettingsControllerProvider.notifier);

      notifier.toggleNotifications();
      expect(
        container.read(appSettingsControllerProvider).notificationsEnabled,
        isFalse,
      );

      notifier.toggleLocationPermission();
      final state = container.read(appSettingsControllerProvider);
      expect(state.locationPermissionGranted, isFalse);
      expect(state.notificationsEnabled, isFalse);
    },
  );

  test('setRememberPreferences sets an explicit value', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(appSettingsControllerProvider.notifier);

    notifier.setRememberPreferences(false);
    expect(
      container.read(appSettingsControllerProvider).rememberPreferences,
      isFalse,
    );

    notifier.setRememberPreferences(false);
    expect(
      container.read(appSettingsControllerProvider).rememberPreferences,
      isFalse,
    );
  });

  test('setLanguage stores a stable locale code', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(appSettingsControllerProvider.notifier);

    notifier.setLanguage(AppLanguage.farsi);
    expect(
      container.read(appSettingsControllerProvider).languageCode,
      AppLanguage.farsi.code,
    );

    notifier.setLanguage(AppLanguage.german);
    expect(
      container.read(appSettingsControllerProvider).languageCode,
      AppLanguage.german.code,
    );
  });

  test('setLanguage persists the selected locale code', () async {
    final store = _FakeLanguageStore();
    final container = ProviderContainer(
      overrides: [languageStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);

    container
        .read(appSettingsControllerProvider.notifier)
        .setLanguage(AppLanguage.german);
    await Future<void>.delayed(Duration.zero);

    expect(store.languageCode, AppLanguage.german.code);
  });
}

class _FakeLanguageStore implements LanguageStore {
  String? languageCode;

  @override
  Future<String?> readLanguageCode() async => languageCode;

  @override
  Future<void> writeLanguageCode(String code) async {
    languageCode = code;
  }
}
