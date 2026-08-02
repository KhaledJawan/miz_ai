import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/food_profile/domain/entities.dart';
import 'package:miz_ai/features/food_profile/domain/food_eligibility_service.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_snapshot.dart';

FoodProfile _emptyProfile() => FoodProfile(
  id: 1,
  localUserId: 1,
  dietType: DietType.omnivore,
  onboardingStatus: OnboardingStatus.completed,
  onboardingVersion: 1,
  onboardingStep: 12,
  personalizationEnabled: true,
  profileCompleteness: 1,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

FoodProfileSnapshot _snapshot({
  List<UserAllergy> allergies = const [],
  List<UserIngredientPreferenceEntry> ingredientPreferences = const [],
  List<UserFoodRuleSelection> foodRules = const [],
}) => FoodProfileSnapshot(
  profile: _emptyProfile(),
  foodRules: foodRules,
  allergies: allergies,
  intolerances: const [],
  ingredientPreferences: ingredientPreferences,
  cuisinePreferences: const [],
  flavorPreferences: const [],
  foodItemPreferences: const [],
);

void main() {
  const service = FoodEligibilityService();

  test('excludes a food that confirmed-contains an active allergen', () {
    final item = const FoodItemEntry(
      id: 1,
      code: 'peanut_noodles',
      allergenIds: [10],
    );
    final snapshot = _snapshot(
      allergies: [
        const UserAllergy(
          id: 1,
          allergenId: 10,
          severity: AllergySeverity.mild,
          isActive: true,
          source: PreferenceSource.explicit,
        ),
      ],
    );

    final result = service.evaluate(
      item: item,
      snapshot: snapshot,
      hasCompleteIngredientData: true,
      hasCompleteAllergenData: true,
    );

    expect(result.status, FoodEligibilityStatus.excluded);
    expect(result.isSafeToShow, isFalse);
    expect(result.blockingReasons.single.code, 'allergyContains');
  });

  test('excludes (never just warns) "may contain" a severe active allergy', () {
    final item = const FoodItemEntry(
      id: 2,
      code: 'stir_fry',
      mayContainAllergenIds: [11],
    );
    final snapshot = _snapshot(
      allergies: [
        const UserAllergy(
          id: 1,
          allergenId: 11,
          severity: AllergySeverity.severe,
          isActive: true,
          source: PreferenceSource.explicit,
        ),
      ],
    );

    final result = service.evaluate(
      item: item,
      snapshot: snapshot,
      hasCompleteIngredientData: true,
      hasCompleteAllergenData: true,
    );

    expect(result.status, FoodEligibilityStatus.excluded);
  });

  test(
    '"may contain" a non-severe active allergy is a warning, not excluded',
    () {
      final item = const FoodItemEntry(
        id: 3,
        code: 'baked_good',
        mayContainAllergenIds: [12],
      );
      final snapshot = _snapshot(
        allergies: [
          const UserAllergy(
            id: 1,
            allergenId: 12,
            severity: AllergySeverity.mild,
            isActive: true,
            source: PreferenceSource.explicit,
          ),
        ],
      );

      final result = service.evaluate(
        item: item,
        snapshot: snapshot,
        hasCompleteIngredientData: true,
        hasCompleteAllergenData: true,
      );

      expect(result.status, FoodEligibilityStatus.warning);
      expect(result.isSafeToShow, isTrue);
    },
  );

  test('a strict ingredient exclusion (e.g. religious) excludes the food', () {
    final item = const FoodItemEntry(
      id: 4,
      code: 'pork_belly',
      primaryIngredientIds: [20],
    );
    final snapshot = _snapshot(
      ingredientPreferences: [
        const UserIngredientPreferenceEntry(
          id: 1,
          ingredientId: 20,
          ingredientCode: 'pork',
          preferenceState: PreferenceState.neutral,
          restrictionType: RestrictionType.religiousExclude,
          source: PreferenceSource.explicit,
          confidence: 1,
        ),
      ],
    );

    final result = service.evaluate(
      item: item,
      snapshot: snapshot,
      hasCompleteIngredientData: true,
      hasCompleteAllergenData: true,
    );

    expect(result.status, FoodEligibilityStatus.excluded);
    expect(result.blockingReasons.single.code, 'restrictedIngredient');
  });

  test('a personal dislike never excludes — ranking signal only', () {
    final item = const FoodItemEntry(
      id: 5,
      code: 'brussels_sprouts',
      primaryIngredientIds: [21],
    );
    final snapshot = _snapshot(
      ingredientPreferences: [
        const UserIngredientPreferenceEntry(
          id: 1,
          ingredientId: 21,
          ingredientCode: 'brusselsSprouts',
          preferenceState: PreferenceState.dislike,
          restrictionType: RestrictionType.none,
          source: PreferenceSource.explicit,
          confidence: 1,
        ),
      ],
    );

    final result = service.evaluate(
      item: item,
      snapshot: snapshot,
      hasCompleteIngredientData: true,
      hasCompleteAllergenData: true,
    );

    expect(result.status, FoodEligibilityStatus.eligible);
    expect(result.isSafeToShow, isTrue);
  });

  test(
    'incomplete ingredient/allergen data is never "eligible" — at least unknown',
    () {
      final item = const FoodItemEntry(id: 6, code: 'mystery_dish');
      final snapshot = _snapshot();

      final result = service.evaluate(
        item: item,
        snapshot: snapshot,
        hasCompleteIngredientData: false,
        hasCompleteAllergenData: true,
      );

      expect(result.status, FoodEligibilityStatus.unknown);
      expect(result.confidence, lessThan(1.0));
    },
  );

  test(
    'a fully known, unrestricted, non-disliked food is eligible with full confidence',
    () {
      final item = const FoodItemEntry(
        id: 7,
        code: 'plain_rice',
        primaryIngredientIds: [30],
      );
      final snapshot = _snapshot();

      final result = service.evaluate(
        item: item,
        snapshot: snapshot,
        hasCompleteIngredientData: true,
        hasCompleteAllergenData: true,
      );

      expect(result.status, FoodEligibilityStatus.eligible);
      expect(result.confidence, 1.0);
    },
  );

  test('blocking allergy takes priority even when data is also incomplete', () {
    final item = const FoodItemEntry(
      id: 8,
      code: 'ambiguous',
      allergenIds: [40],
    );
    final snapshot = _snapshot(
      allergies: [
        const UserAllergy(
          id: 1,
          allergenId: 40,
          severity: AllergySeverity.moderate,
          isActive: true,
          source: PreferenceSource.explicit,
        ),
      ],
    );

    final result = service.evaluate(
      item: item,
      snapshot: snapshot,
      hasCompleteIngredientData: false,
      hasCompleteAllergenData: true,
    );

    expect(result.status, FoodEligibilityStatus.excluded);
  });

  test('an inactive allergy no longer excludes the food', () {
    final item = const FoodItemEntry(
      id: 9,
      code: 'shrimp_toast',
      allergenIds: [50],
    );
    final snapshot = _snapshot(
      allergies: [
        const UserAllergy(
          id: 1,
          allergenId: 50,
          severity: AllergySeverity.severe,
          isActive: false,
          source: PreferenceSource.explicit,
        ),
      ],
    );

    final result = service.evaluate(
      item: item,
      snapshot: snapshot,
      hasCompleteIngredientData: true,
      hasCompleteAllergenData: true,
    );

    expect(result.status, FoodEligibilityStatus.eligible);
  });
}
