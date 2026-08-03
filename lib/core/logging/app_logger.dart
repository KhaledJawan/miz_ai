import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;

/// The project's only sanctioned logging surface (`CLAUDE.md` §4: no
/// `print()`). Always records to `dart:developer.log` (DevTools' Logging
/// view, safe in every build mode). Debug builds additionally call
/// `debugPrint` so the message shows up directly in the `flutter run` /
/// `flutter attach` console — `dart:developer.log` alone does not print to
/// stdout, only to the VM service stream. Release builds never call
/// `debugPrint`, so nothing extra reaches production console/stdout.
abstract final class AppLogger {
  static void error(
    String message, {
    String name = 'miz_ai',
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
    if (kDebugMode) {
      debugPrint('[$name] ERROR: $message${error != null ? ' | $error' : ''}');
      if (stackTrace != null) debugPrint(stackTrace.toString());
    }
  }

  static void warning(String message, {String name = 'miz_ai'}) {
    developer.log(message, name: name, level: 900);
    if (kDebugMode) debugPrint('[$name] WARN: $message');
  }
}
