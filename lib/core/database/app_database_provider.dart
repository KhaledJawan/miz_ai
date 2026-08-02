import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';

part 'app_database_provider.g.dart';

/// The single [AppDatabase] instance for the app's lifetime. `bootstrap.dart`
/// opens and seeds the database *before* `runApp` (to resolve the
/// onboarding start route) and overrides this provider with that exact
/// instance, so the widget tree never opens a second connection — see
/// docs/ARCHITECTURE.md and docs/DECISIONS.md ADR-013.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
