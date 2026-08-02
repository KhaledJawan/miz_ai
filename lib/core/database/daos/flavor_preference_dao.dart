import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/catalog_tables.dart';

part 'flavor_preference_dao.g.dart';

@DriftAccessor(tables: [FlavorAttributes, UserFlavorPreferences])
class FlavorPreferenceDao extends DatabaseAccessor<AppDatabase>
    with _$FlavorPreferenceDaoMixin {
  FlavorPreferenceDao(super.db);

  Future<List<FlavorAttribute>> getAllFlavorAttributes() =>
      select(flavorAttributes).get();

  Stream<List<UserFlavorPreference>> watchUserPreferences(int localUserId) =>
      (select(
        userFlavorPreferences,
      )..where((row) => row.localUserId.equals(localUserId))).watch();

  Future<List<UserFlavorPreference>> getUserPreferences(int localUserId) =>
      (select(
        userFlavorPreferences,
      )..where((row) => row.localUserId.equals(localUserId))).get();

  Future<void> upsertPreference(UserFlavorPreferencesCompanion row) =>
      into(userFlavorPreferences).insertOnConflictUpdate(row);
}
