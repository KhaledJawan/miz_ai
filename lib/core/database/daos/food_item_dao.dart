import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/food_item_tables.dart';

part 'food_item_dao.g.dart';

@DriftAccessor(
  tables: [
    FoodItems,
    FoodItemIngredients,
    FoodItemAllergens,
    UserFoodItemPreferences,
  ],
)
class FoodItemDao extends DatabaseAccessor<AppDatabase>
    with _$FoodItemDaoMixin {
  FoodItemDao(super.db);

  Future<List<FoodItem>> getAllFoodItems() => select(foodItems).get();

  Future<List<FoodItemIngredient>> getIngredientLinks(int foodItemId) =>
      (select(
        foodItemIngredients,
      )..where((row) => row.foodItemId.equals(foodItemId))).get();

  Future<List<FoodItemAllergen>> getAllergenLinks(int foodItemId) => (select(
    foodItemAllergens,
  )..where((row) => row.foodItemId.equals(foodItemId))).get();

  Future<List<UserFoodItemPreference>> getUserPreferences(int localUserId) =>
      (select(
        userFoodItemPreferences,
      )..where((row) => row.localUserId.equals(localUserId))).get();

  Future<void> upsertPreference(UserFoodItemPreferencesCompanion row) =>
      into(userFoodItemPreferences).insertOnConflictUpdate(row);
}
