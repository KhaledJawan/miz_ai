import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/catalog_tables.dart';

part 'ingredient_preference_dao.g.dart';

@DriftAccessor(tables: [Ingredients, UserIngredientPreferences])
class IngredientPreferenceDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientPreferenceDaoMixin {
  IngredientPreferenceDao(super.db);

  Future<List<Ingredient>> getAllIngredients() => select(ingredients).get();

  Future<Ingredient?> getIngredientByCode(String code) => (select(
    ingredients,
  )..where((row) => row.code.equals(code))).getSingleOrNull();

  Stream<List<UserIngredientPreference>> watchUserPreferences(
    int localUserId,
  ) => (select(
    userIngredientPreferences,
  )..where((row) => row.localUserId.equals(localUserId))).watch();

  Future<List<UserIngredientPreference>> getUserPreferences(int localUserId) =>
      (select(
        userIngredientPreferences,
      )..where((row) => row.localUserId.equals(localUserId))).get();

  Future<void> upsertPreference(UserIngredientPreferencesCompanion row) =>
      into(userIngredientPreferences).insertOnConflictUpdate(row);

  /// Ingredient ids the user cannot/won't be shown — any [RestrictionType]
  /// other than `none`. Used by [FoodEligibilityService].
  Future<Set<int>> getRestrictedIngredientIds(int localUserId) async {
    final rows =
        await (select(userIngredientPreferences)..where(
              (row) =>
                  row.localUserId.equals(localUserId) &
                  row.restrictionType.equals('none').not(),
            ))
            .get();
    return rows.map((row) => row.ingredientId).toSet();
  }
}
