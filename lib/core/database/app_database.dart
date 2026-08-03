import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/allergy_dao.dart';
import 'daos/cuisine_preference_dao.dart';
import 'daos/flavor_preference_dao.dart';
import 'daos/food_item_dao.dart';
import 'daos/food_profile_dao.dart';
import 'daos/ingredient_preference_dao.dart';
import 'daos/interaction_dao.dart';
import 'daos/intolerance_dao.dart';
import 'daos/profile_history_dao.dart';
import 'seed/seed_runner.dart';
import 'tables/catalog_tables.dart';
import 'tables/conversation_tables.dart';
import 'tables/food_item_tables.dart';
import 'tables/interaction_tables.dart';
import 'tables/profile_tables.dart';
import 'tables/saved_item_tables.dart';

part 'app_database.g.dart';

/// The app's single local Drift database. Schema version 1 is the first
/// cut of the Food Preference Profile (no prior schema exists yet, so no
/// destructive-migration risk) — see docs/DATABASE.md "Local database
/// (Drift)" and docs/DECISIONS.md ADR-013/ADR-014.
@DriftDatabase(
  tables: [
    FoodProfiles,
    FoodRules,
    UserFoodRules,
    Allergens,
    UserAllergies,
    Intolerances,
    UserIntolerances,
    Ingredients,
    UserIngredientPreferences,
    Cuisines,
    UserCuisinePreferences,
    FlavorAttributes,
    UserFlavorPreferences,
    FoodItems,
    FoodItemIngredients,
    FoodItemAllergens,
    UserFoodItemPreferences,
    UserFoodInteractions,
    UserHiddenEntities,
    ProfileChangeHistory,
    SavedItems,
    ConversationArchives,
  ],
  daos: [
    FoodProfileDao,
    AllergyDao,
    IntoleranceDao,
    IngredientPreferenceDao,
    CuisinePreferenceDao,
    FlavorPreferenceDao,
    FoodItemDao,
    InteractionDao,
    ProfileHistoryDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// In-memory database for tests — never touches disk.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _createIndexes(this);
      await SeedRunner(this).run();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(savedItems);
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_saved_items_user_time '
          'ON saved_items (local_user_id, saved_at DESC)',
        );
      }
      if (from < 3) {
        await migrator.createTable(conversationArchives);
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_conversation_archives_user_time '
          'ON conversation_archives (local_user_id, updated_at DESC)',
        );
      }
    },
  );

  static Future<void> _createIndexes(AppDatabase db) async {
    await db.customStatement(
      'CREATE INDEX IF NOT EXISTS idx_interactions_user_time '
      'ON user_food_interactions (local_user_id, occurred_at DESC)',
    );
    await db.customStatement(
      'CREATE INDEX IF NOT EXISTS idx_interactions_entity '
      'ON user_food_interactions (entity_type, entity_id)',
    );
    await db.customStatement(
      'CREATE INDEX IF NOT EXISTS idx_ingredients_parent '
      'ON ingredients (parent_id)',
    );
    await db.customStatement(
      'CREATE INDEX IF NOT EXISTS idx_saved_items_user_time '
      'ON saved_items (local_user_id, saved_at DESC)',
    );
    await db.customStatement(
      'CREATE INDEX IF NOT EXISTS idx_conversation_archives_user_time '
      'ON conversation_archives (local_user_id, updated_at DESC)',
    );
  }
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'miz_food_profile.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
