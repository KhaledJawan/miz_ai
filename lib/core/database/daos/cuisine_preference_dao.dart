import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/catalog_tables.dart';

part 'cuisine_preference_dao.g.dart';

@DriftAccessor(tables: [Cuisines, UserCuisinePreferences])
class CuisinePreferenceDao extends DatabaseAccessor<AppDatabase>
    with _$CuisinePreferenceDaoMixin {
  CuisinePreferenceDao(super.db);

  Future<List<Cuisine>> getAllCuisines() => select(cuisines).get();

  Future<Cuisine?> getCuisineByCode(String code) => (select(
    cuisines,
  )..where((row) => row.code.equals(code))).getSingleOrNull();

  Stream<List<UserCuisinePreference>> watchUserPreferences(int localUserId) =>
      (select(
        userCuisinePreferences,
      )..where((row) => row.localUserId.equals(localUserId))).watch();

  Future<List<UserCuisinePreference>> getUserPreferences(int localUserId) =>
      (select(
        userCuisinePreferences,
      )..where((row) => row.localUserId.equals(localUserId))).get();

  Future<void> upsertPreference(UserCuisinePreferencesCompanion row) =>
      into(userCuisinePreferences).insertOnConflictUpdate(row);
}
