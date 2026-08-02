import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// App settings. Language is persisted locally now; the remaining values sync
/// to `profiles`/local storage in Milestone 6/8 — see docs/DATABASE.md.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('Alex') String userName,
    @Default('en') String languageCode,
    @Default(false) bool darkMode,
    @Default(true) bool notificationsEnabled,
    @Default(true) bool locationPermissionGranted,
    @Default(true) bool rememberPreferences,
  }) = _AppSettings;
}
