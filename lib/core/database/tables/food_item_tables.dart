import 'package:drift/drift.dart';

import 'catalog_tables.dart';
import 'profile_tables.dart';

/// Small local food catalog used by the onboarding "visual food selection"
/// step and, later, by [FoodEligibilityService]. Not an exhaustive food
/// database — see docs/DECISIONS.md.
class FoodItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get canonicalName => text()();
  TextColumn get displayNameKey => text()();
  IntColumn get cuisineId => integer().nullable().references(Cuisines, #id)();
  TextColumn get localImageAsset => text().nullable()();
  TextColumn get descriptionKey => text().nullable()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class FoodItemIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodItemId => integer().references(FoodItems, #id)();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  BoolColumn get mayContain => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {foodItemId, ingredientId},
  ];
}

class FoodItemAllergens extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodItemId => integer().references(FoodItems, #id)();
  IntColumn get allergenId => integer().references(Allergens, #id)();
  TextColumn get relationType => text().withDefault(
    const Constant('contains'),
  )(); // contains/mayContain/unknown
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {foodItemId, allergenId},
  ];
}

class UserFoodItemPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get foodItemId => integer().references(FoodItems, #id)();
  TextColumn get preferenceState =>
      text().withDefault(const Constant('unknown'))();
  TextColumn get source => text().withDefault(const Constant('explicit'))();
  RealColumn get confidence => real().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId, foodItemId},
  ];
}
