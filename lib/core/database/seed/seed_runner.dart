import 'package:drift/drift.dart';

import '../app_database.dart';
import 'catalog_data.dart';

/// Idempotent catalog seeding, run once from [AppDatabase]'s `onCreate` (and
/// safe to call again on every launch — every insert is select-or-insert by
/// stable `code`, never duplicated). See docs/DATABASE.md "Local database
/// (Drift)".
class SeedRunner {
  SeedRunner(this.db);

  final AppDatabase db;

  Future<void> run() async {
    await db.transaction(() async {
      await _seedAllergens();
      await _seedIntolerances();
      await _seedFoodRules();
      final ingredientIds = await _seedIngredients();
      final cuisineIds = await _seedCuisines();
      await _seedFlavorAttributes();
      final allergenIds = await _allergenIdsByCode();
      await _seedFoodItems(ingredientIds, cuisineIds, allergenIds);
    });
  }

  Future<int> _ensureId<T extends Table, D>(
    TableInfo<T, D> table,
    Expression<bool> Function(T) whereCode,
    Insertable<D> companion,
    int Function(D) idOf,
  ) async {
    final existing = await (db.select(
      table,
    )..where(whereCode)).getSingleOrNull();
    if (existing != null) return idOf(existing);
    return db.into(table).insert(companion);
  }

  Future<void> _seedAllergens() async {
    for (final seed in kAllergenSeeds) {
      await _ensureId(
        db.allergens,
        (t) => t.code.equals(seed.code),
        AllergensCompanion.insert(
          code: seed.code,
          displayNameKey: seed.code,
          category: Value(seed.category),
        ),
        (row) => row.id,
      );
    }
  }

  Future<void> _seedIntolerances() async {
    for (final code in kIntoleranceCodes) {
      await _ensureId(
        db.intolerances,
        (t) => t.code.equals(code),
        IntolerancesCompanion.insert(code: code, displayNameKey: code),
        (row) => row.id,
      );
    }
  }

  Future<void> _seedFoodRules() async {
    for (final seed in kFoodRuleSeeds) {
      await _ensureId(
        db.foodRules,
        (t) => t.code.equals(seed.code),
        FoodRulesCompanion.insert(
          code: seed.code,
          displayNameKey: seed.code,
          category: seed.category,
        ),
        (row) => row.id,
      );
    }
  }

  Future<Map<String, int>> _seedIngredients() async {
    final idsByCode = <String, int>{};
    for (final seed in kIngredientSeeds) {
      final parentId = seed.parentCode == null
          ? null
          : idsByCode[seed.parentCode];
      final id = await _ensureId(
        db.ingredients,
        (t) => t.code.equals(seed.code),
        IngredientsCompanion.insert(
          code: seed.code,
          canonicalName: seed.code,
          displayNameKey: seed.code,
          category: seed.category,
          parentId: Value(parentId),
          isAnimalProduct: Value(seed.isAnimalProduct),
          isMeat: Value(seed.isMeat),
          isSeafood: Value(seed.isSeafood),
          isAlcoholRelated: Value(seed.isAlcoholRelated),
        ),
        (row) => row.id,
      );
      idsByCode[seed.code] = id;
    }
    return idsByCode;
  }

  Future<Map<String, int>> _seedCuisines() async {
    final idsByCode = <String, int>{};
    for (final seed in kCuisineSeeds) {
      idsByCode[seed.code] = await _ensureId(
        db.cuisines,
        (t) => t.code.equals(seed.code),
        CuisinesCompanion.insert(
          code: seed.code,
          displayNameKey: seed.code,
          region: Value(seed.region),
        ),
        (row) => row.id,
      );
    }
    return idsByCode;
  }

  Future<void> _seedFlavorAttributes() async {
    for (final code in kFlavorAttributeCodes) {
      await _ensureId(
        db.flavorAttributes,
        (t) => t.code.equals(code),
        FlavorAttributesCompanion.insert(code: code, displayNameKey: code),
        (row) => row.id,
      );
    }
  }

  Future<Map<String, int>> _allergenIdsByCode() async {
    final rows = await db.select(db.allergens).get();
    return {for (final row in rows) row.code: row.id};
  }

  Future<void> _seedFoodItems(
    Map<String, int> ingredientIds,
    Map<String, int> cuisineIds,
    Map<String, int> allergenIds,
  ) async {
    for (final seed in kFoodItemSeeds) {
      final foodItemId = await _ensureId(
        db.foodItems,
        (t) => t.canonicalName.equals(seed.code),
        FoodItemsCompanion.insert(
          canonicalName: seed.code,
          displayNameKey: seed.code,
          cuisineId: Value(cuisineIds[seed.cuisineCode]),
          localImageAsset: Value(seed.imageAsset),
        ),
        (row) => row.id,
      );

      for (final code in seed.primaryIngredientCodes) {
        final ingredientId = ingredientIds[code];
        if (ingredientId == null) continue;
        await _ensureId(
          db.foodItemIngredients,
          (t) =>
              t.foodItemId.equals(foodItemId) &
              t.ingredientId.equals(ingredientId),
          FoodItemIngredientsCompanion.insert(
            foodItemId: foodItemId,
            ingredientId: ingredientId,
            isPrimary: const Value(true),
          ),
          (row) => row.id,
        );
      }
      for (final code in seed.mayContainIngredientCodes) {
        final ingredientId = ingredientIds[code];
        if (ingredientId == null) continue;
        await _ensureId(
          db.foodItemIngredients,
          (t) =>
              t.foodItemId.equals(foodItemId) &
              t.ingredientId.equals(ingredientId),
          FoodItemIngredientsCompanion.insert(
            foodItemId: foodItemId,
            ingredientId: ingredientId,
            mayContain: const Value(true),
          ),
          (row) => row.id,
        );
      }
      for (final code in seed.allergenCodes) {
        final allergenId = allergenIds[code];
        if (allergenId == null) continue;
        await _ensureId(
          db.foodItemAllergens,
          (t) =>
              t.foodItemId.equals(foodItemId) & t.allergenId.equals(allergenId),
          FoodItemAllergensCompanion.insert(
            foodItemId: foodItemId,
            allergenId: allergenId,
            relationType: const Value('contains'),
          ),
          (row) => row.id,
        );
      }
      for (final code in seed.mayContainAllergenCodes) {
        final allergenId = allergenIds[code];
        if (allergenId == null) continue;
        await _ensureId(
          db.foodItemAllergens,
          (t) =>
              t.foodItemId.equals(foodItemId) & t.allergenId.equals(allergenId),
          FoodItemAllergensCompanion.insert(
            foodItemId: foodItemId,
            allergenId: allergenId,
            relationType: const Value('mayContain'),
          ),
          (row) => row.id,
        );
      }
    }
  }
}
