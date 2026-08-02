// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsControllerHash() =>
    r'1ef0485cf0b89e886526f25a63050e0c2db05701';

/// Root-level settings state — `app.dart` watches [darkMode] to drive
/// [ThemeMode]. Session-only until Milestone 6/8 persistence lands.
///
/// Copied from [AppSettingsController].
@ProviderFor(AppSettingsController)
final appSettingsControllerProvider =
    NotifierProvider<AppSettingsController, AppSettings>.internal(
      AppSettingsController.new,
      name: r'appSettingsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appSettingsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppSettingsController = Notifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
