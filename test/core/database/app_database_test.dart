import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/local_user.dart';
import 'package:miz_ai/core/database/seed/catalog_data.dart';
import 'package:miz_ai/core/database/seed/seed_runner.dart';
import 'package:miz_ai/core/bookmarks/drift_bookmark_repository.dart';
import 'package:miz_ai/core/bookmarks/saved_item.dart' as domain;
import 'package:miz_ai/features/conversation/data/drift_conversation_history_repository.dart';
import 'package:miz_ai/features/conversation/domain/conversation_models.dart'
    as conversation;

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  group('schema creation', () {
    test('creates all tables and seeds catalog data', () async {
      await SeedRunner(db).run();

      final allergens = await db.select(db.allergens).get();
      final intolerances = await db.select(db.intolerances).get();
      final foodRules = await db.select(db.foodRules).get();
      final ingredients = await db.select(db.ingredients).get();
      final cuisines = await db.select(db.cuisines).get();
      final flavors = await db.select(db.flavorAttributes).get();
      final foodItems = await db.select(db.foodItems).get();

      expect(allergens.length, kAllergenSeeds.length);
      expect(intolerances.length, kIntoleranceCodes.length);
      expect(foodRules.length, kFoodRuleSeeds.length);
      expect(ingredients.length, kIngredientSeeds.length);
      expect(cuisines.length, kCuisineSeeds.length);
      expect(flavors.length, kFlavorAttributeCodes.length);
      expect(foodItems.length, kFoodItemSeeds.length);
    });

    test('ingredient hierarchy resolves parent ids correctly', () async {
      await SeedRunner(db).run();

      final beef = await (db.select(
        db.ingredients,
      )..where((row) => row.code.equals('beef'))).getSingle();
      final meat = await (db.select(
        db.ingredients,
      )..where((row) => row.code.equals('meat'))).getSingle();
      final protein = await (db.select(
        db.ingredients,
      )..where((row) => row.code.equals('protein'))).getSingle();

      expect(beef.parentId, meat.id);
      expect(meat.parentId, protein.id);
      expect(protein.parentId, isNull);
      expect(beef.isMeat, isTrue);
      expect(beef.isAnimalProduct, isTrue);
    });

    test('food items link to their seeded ingredients and allergens', () async {
      await SeedRunner(db).run();

      final pizza =
          await (db.select(db.foodItems)
                ..where((row) => row.canonicalName.equals('margherita_pizza')))
              .getSingle();
      final allergenLinks = await (db.select(
        db.foodItemAllergens,
      )..where((row) => row.foodItemId.equals(pizza.id))).get();

      expect(allergenLinks, isNotEmpty);
    });
  });

  group('seed idempotency', () {
    test('running the seed twice never duplicates rows', () async {
      await SeedRunner(db).run();
      await SeedRunner(db).run();

      final allergens = await db.select(db.allergens).get();
      final ingredients = await db.select(db.ingredients).get();
      final foodItems = await db.select(db.foodItems).get();

      expect(allergens.length, kAllergenSeeds.length);
      expect(ingredients.length, kIngredientSeeds.length);
      expect(foodItems.length, kFoodItemSeeds.length);
    });
  });

  group('FoodProfileDao', () {
    test(
      'ensureProfile creates a row on first call and is idempotent',
      () async {
        final first = await db.foodProfileDao.ensureProfile(kLocalUserId);
        final second = await db.foodProfileDao.ensureProfile(kLocalUserId);

        expect(first.id, second.id);
        expect(first.onboardingStatus, 'notStarted');

        final all = await db.select(db.foodProfiles).get();
        expect(all.length, 1);
      },
    );
  });

  group('AllergyDao', () {
    test(
      'replaceUserAllergies clears and replaces in one transaction',
      () async {
        await SeedRunner(db).run();
        final peanuts = await (db.select(
          db.allergens,
        )..where((row) => row.code.equals('peanuts'))).getSingle();

        await db.allergyDao.replaceUserAllergies(kLocalUserId, [
          UserAllergiesCompanion.insert(
            localUserId: kLocalUserId,
            allergenId: Value(peanuts.id),
            severity: const Value('severe'),
          ),
        ]);

        final severe = await db.allergyDao.getSevereActiveAllergies(
          kLocalUserId,
        );
        expect(severe, hasLength(1));

        await db.allergyDao.replaceUserAllergies(kLocalUserId, []);
        final afterClear = await db.allergyDao.getUserAllergies(kLocalUserId);
        expect(afterClear, isEmpty);
      },
    );
  });

  group('InteractionDao', () {
    test('records interactions and deletes them on request', () async {
      await db.interactionDao.insertInteraction(
        UserFoodInteractionsCompanion.insert(
          localUserId: kLocalUserId,
          sessionId: 'session-1',
          eventType: 'tap',
        ),
      );

      final recent = await db.interactionDao.getRecentInteractions(
        kLocalUserId,
      );
      expect(recent, hasLength(1));

      await db.interactionDao.deleteAllInteractions(kLocalUserId);
      final afterDelete = await db.interactionDao.getRecentInteractions(
        kLocalUserId,
      );
      expect(afterDelete, isEmpty);
    });
  });

  group('saved items', () {
    test(
      'uses one local database for save, offline read, and removal',
      () async {
        final repository = DriftBookmarkRepository(db);
        final savedAt = DateTime.utc(2026, 8, 2);

        await repository.save(
          domain.SavedItem(
            id: 'r1',
            type: domain.SavedItemType.restaurant,
            title: 'Trattoria Nove',
            savedAt: savedAt,
          ),
        );

        final items = await repository.watchAll().first;
        expect(items, hasLength(1));
        expect(items.single.title, 'Trattoria Nove');
        expect(await repository.restaurantIds(), {'r1'});

        await repository.remove(domain.SavedItemType.restaurant, 'r1');
        expect(await repository.watchAll().first, isEmpty);
      },
    );
  });

  group('conversation history', () {
    test('persists typed messages offline and removes an archive', () async {
      final repository = DriftConversationHistoryRepository(db);
      final now = DateTime.utc(2026, 8, 3, 12);
      await repository.save(
        conversation.ConversationArchive(
          id: 'chat-1',
          title: 'Find ramen',
          createdAt: now,
          updatedAt: now,
          messages: const [
            conversation.ConversationMessage(
              id: 'user-1',
              author: conversation.ConversationAuthor.user,
              text: 'Find ramen',
            ),
            conversation.ConversationMessage(
              id: 'miz-1',
              author: conversation.ConversationAuthor.miz,
              text: 'Here are two options.',
              places: [
                conversation.AiPlace(
                  id: 'place-1',
                  name: 'Noodle House',
                  address: 'Main Street 1',
                  latitude: 49,
                  longitude: 6,
                  rating: 4.7,
                ),
              ],
            ),
          ],
        ),
      );

      final archives = await repository.watchAll().first;
      expect(archives, hasLength(1));
      expect(archives.single.title, 'Find ramen');
      expect(archives.single.messages.last.places.single.rating, 4.7);

      await repository.delete('chat-1');
      expect(await repository.watchAll().first, isEmpty);
    });
  });
}
