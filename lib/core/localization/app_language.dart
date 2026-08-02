import 'package:flutter/widgets.dart';

/// Languages shipped by Miz. Add a value here and a matching ARB file to
/// extend the app without changing feature widgets.
enum AppLanguage {
  english(code: 'en', nativeName: 'English'),
  farsi(code: 'fa', nativeName: 'فارسی'),
  german(code: 'de', nativeName: 'Deutsch');

  const AppLanguage({required this.code, required this.nativeName});

  final String code;
  final String nativeName;

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String code) => values.firstWhere(
    (language) => language.code == code,
    orElse: () => AppLanguage.english,
  );
}
