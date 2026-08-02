import 'package:drift/drift.dart';

/// Hierarchical ingredient taxonomy (protein > meat > beef, ...) — see
/// docs/DATABASE.md "Local database (Drift)".
class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Ingredients, #id)();
  TextColumn get code => text().unique()();
  TextColumn get canonicalName => text()();
  TextColumn get displayNameKey => text()();
  TextColumn get category => text()();
  BoolColumn get isAnimalProduct =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isMeat => boolean().withDefault(const Constant(false))();
  BoolColumn get isSeafood => boolean().withDefault(const Constant(false))();
  BoolColumn get isAlcoholRelated =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Per-ingredient state: love/like/neutral/dislike/curious/neverTried, plus
/// an independent [restrictionType] (none/strictExclude/dietaryExclude/
/// ethicalExclude/religiousExclude/intolerance/allergy) — strength and
/// restriction are never conflated with the like/dislike axis.
class UserIngredientPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  TextColumn get preferenceState =>
      text().withDefault(const Constant('unknown'))();
  TextColumn get restrictionType =>
      text().withDefault(const Constant('none'))();
  TextColumn get source => text().withDefault(const Constant('explicit'))();
  RealColumn get confidence => real().withDefault(const Constant(1))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId, ingredientId},
  ];
}

class Cuisines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get displayNameKey => text()();
  TextColumn get region => text().nullable()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UserCuisinePreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get cuisineId => integer().references(Cuisines, #id)();
  TextColumn get preferenceState =>
      text().withDefault(const Constant('unknown'))();
  RealColumn get curiosityScore => real().nullable()();
  TextColumn get source => text().withDefault(const Constant('explicit'))();
  RealColumn get confidence => real().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId, cuisineId},
  ];
}

class FlavorAttributes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get displayNameKey => text()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
}

/// [preferenceLevel] is a 0–4 scale (dislike..love). For the `spicy`
/// attribute specifically, the onboarding UI relabels the same 0–4 scale as
/// a tolerance scale (not-spicy..very-hot) rather than adding a bespoke
/// column — see docs/DECISIONS.md.
class UserFlavorPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  IntColumn get flavorAttributeId =>
      integer().references(FlavorAttributes, #id)();
  IntColumn get preferenceLevel => integer().withDefault(const Constant(2))();
  TextColumn get source => text().withDefault(const Constant('explicit'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId, flavorAttributeId},
  ];
}
