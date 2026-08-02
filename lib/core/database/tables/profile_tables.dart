import 'package:drift/drift.dart';

/// One row per local user (today: always [kLocalUserId] — see
/// docs/DECISIONS.md ADR-013). All enum-shaped text columns store the
/// Dart enum's stable `.name` string, never an integer index, so reordering
/// enum values later can never corrupt stored data.
class FoodProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  TextColumn get dietType => text().withDefault(const Constant('unknown'))();
  TextColumn get adventurousnessLevel => text().nullable()();
  TextColumn get preferredMealWeight => text().nullable()();
  TextColumn get budgetLevel => text().nullable()();
  TextColumn get topPriorities => text().nullable()(); // JSON string array
  TextColumn get onboardingStatus =>
      text().withDefault(const Constant('notStarted'))();
  IntColumn get onboardingVersion => integer().withDefault(const Constant(0))();
  IntColumn get onboardingStep => integer().withDefault(const Constant(0))();
  BoolColumn get personalizationEnabled =>
      boolean().withDefault(const Constant(true))();
  RealColumn get profileCompleteness => real().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get skippedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId},
  ];
}

/// Canonical food rules (halal, kosher, no pork, ...) — see
/// docs/DATABASE.md "Local database (Drift)".
class FoodRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get displayNameKey => text()();
  TextColumn get category => text()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UserFoodRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get foodRuleId => integer().references(FoodRules, #id)();
  TextColumn get requirementLevel => text()(); // required/preferred/avoid
  TextColumn get source => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId, foodRuleId},
  ];
}

/// Canonical allergens (EU common allergens + custom entries the user adds).
class Allergens extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get displayNameKey => text()();
  TextColumn get category => text().withDefault(const Constant('common'))();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Explicit user allergies. Deliberately never merged with dislikes —
/// see CLAUDE.md's food-profile safety rule and ADR-013.
class UserAllergies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get allergenId => integer().nullable().references(Allergens, #id)();
  TextColumn get customName => text().nullable()();
  TextColumn get severity =>
      text().withDefault(const Constant('unspecified'))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get source => text().withDefault(const Constant('explicit'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Canonical intolerances (lactose, gluten, ...) — kept separate from
/// [Allergens] per the food-profile safety rules.
class Intolerances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get displayNameKey => text()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UserIntolerances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get intoleranceId =>
      integer().nullable().references(Intolerances, #id)();
  TextColumn get customName => text().nullable()();
  TextColumn get severity =>
      text().withDefault(const Constant('unspecified'))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
