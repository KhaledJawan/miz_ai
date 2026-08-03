import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/food_profile/domain/entities.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_ai_context.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_snapshot.dart';

FoodProfile _profile({
  DietType dietType = DietType.unknown,
  AdventurousnessLevel? adventurousnessLevel,
}) => FoodProfile(
  id: 1,
  localUserId: 1,
  dietType: dietType,
  adventurousnessLevel: adventurousnessLevel,
  onboardingStatus: OnboardingStatus.completed,
  onboardingVersion: 1,
  onboardingStep: 10,
  personalizationEnabled: true,
  profileCompleteness: 1,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

void main() {
  group('buildFoodProfileAiContext', () {
    test('maps diet type, keeping unknown as null', () {
      final withDiet = FoodProfileSnapshot(
        profile: _profile(dietType: DietType.vegan),
        foodRules: const [],
        allergies: const [],
        intolerances: const [],
        ingredientPreferences: const [],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      expect(buildFoodProfileAiContext(withDiet)['dietType'], 'vegan');

      final unknownDiet = FoodProfileSnapshot(
        profile: _profile(),
        foodRules: const [],
        allergies: const [],
        intolerances: const [],
        ingredientPreferences: const [],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      expect(buildFoodProfileAiContext(unknownDiet)['dietType'], isNull);
    });

    test('only required food rules become strict restrictions', () {
      final snapshot = FoodProfileSnapshot(
        profile: _profile(),
        foodRules: const [
          UserFoodRuleSelection(
            id: 1,
            foodRuleId: 1,
            foodRuleCode: 'halalRequired',
            requirementLevel: RequirementLevel.required,
            source: PreferenceSource.explicit,
          ),
          UserFoodRuleSelection(
            id: 2,
            foodRuleId: 2,
            foodRuleCode: 'noAlcohol',
            requirementLevel: RequirementLevel.preferred,
            source: PreferenceSource.explicit,
          ),
        ],
        allergies: const [],
        intolerances: const [],
        ingredientPreferences: const [],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      final context = buildFoodProfileAiContext(snapshot);
      expect(context['strictRestrictions'], ['halalRequired']);
    });

    test('allergies stay a distinct field from disliked ingredients', () {
      final snapshot = FoodProfileSnapshot(
        profile: _profile(),
        foodRules: const [],
        allergies: const [
          UserAllergy(
            id: 1,
            allergenId: 1,
            allergenCode: 'peanuts',
            severity: AllergySeverity.severe,
            isActive: true,
            source: PreferenceSource.explicit,
          ),
        ],
        intolerances: const [],
        ingredientPreferences: const [
          UserIngredientPreferenceEntry(
            id: 1,
            ingredientId: 1,
            ingredientCode: 'mushroom',
            preferenceState: PreferenceState.dislike,
            restrictionType: RestrictionType.none,
            source: PreferenceSource.explicit,
            confidence: 1,
          ),
        ],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      final context = buildFoodProfileAiContext(snapshot);
      expect(context['allergies'], [
        {'code': 'peanuts', 'severity': 'severe'},
      ]);
      expect(context['dislikedIngredients'], ['mushroom']);
      // An allergy must never leak into the plain dislike list.
      expect(
        (context['dislikedIngredients'] as List).contains('peanuts'),
        isFalse,
      );
    });

    test('inactive allergies and intolerances are excluded', () {
      final snapshot = FoodProfileSnapshot(
        profile: _profile(),
        foodRules: const [],
        allergies: const [
          UserAllergy(
            id: 1,
            allergenCode: 'milk',
            severity: AllergySeverity.mild,
            isActive: false,
            source: PreferenceSource.explicit,
          ),
        ],
        intolerances: const [
          UserIntolerance(
            id: 1,
            intoleranceCode: 'lactose',
            severity: AllergySeverity.unspecified,
            isActive: false,
          ),
        ],
        ingredientPreferences: const [],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      final context = buildFoodProfileAiContext(snapshot);
      expect(context['allergies'], isEmpty);
      expect(context['intolerances'], isEmpty);
    });

    test('cuisine preferences split into liked vs. curious', () {
      final snapshot = FoodProfileSnapshot(
        profile: _profile(),
        foodRules: const [],
        allergies: const [],
        intolerances: const [],
        ingredientPreferences: const [],
        cuisinePreferences: const [
          UserCuisinePreferenceEntry(
            id: 1,
            cuisineId: 1,
            cuisineCode: 'italian',
            preferenceState: PreferenceState.love,
            source: PreferenceSource.explicit,
            confidence: 1,
          ),
          UserCuisinePreferenceEntry(
            id: 2,
            cuisineId: 2,
            cuisineCode: 'japanese',
            preferenceState: PreferenceState.curious,
            source: PreferenceSource.explicit,
            confidence: 1,
          ),
          UserCuisinePreferenceEntry(
            id: 3,
            cuisineId: 3,
            cuisineCode: 'fastFood',
            preferenceState: PreferenceState.dislike,
            source: PreferenceSource.explicit,
            confidence: 1,
          ),
        ],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      final context = buildFoodProfileAiContext(snapshot);
      expect(context['likedCuisines'], ['italian']);
      expect(context['curiousCuisines'], ['japanese']);
    });

    test(
      'spice level reads the "spicy" flavor attribute and maps to a label',
      () {
        final snapshot = FoodProfileSnapshot(
          profile: _profile(),
          foodRules: const [],
          allergies: const [],
          intolerances: const [],
          ingredientPreferences: const [],
          cuisinePreferences: const [],
          flavorPreferences: const [
            UserFlavorPreferenceEntry(
              id: 1,
              flavorAttributeId: 1,
              flavorAttributeCode: 'spicy',
              preferenceLevel: 2,
              source: PreferenceSource.explicit,
            ),
          ],
          foodItemPreferences: const [],
        );
        expect(buildFoodProfileAiContext(snapshot)['spiceLevel'], 'medium');
      },
    );

    test('spice level is null when no spicy flavor entry exists', () {
      final snapshot = FoodProfileSnapshot(
        profile: _profile(),
        foodRules: const [],
        allergies: const [],
        intolerances: const [],
        ingredientPreferences: const [],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      expect(buildFoodProfileAiContext(snapshot)['spiceLevel'], isNull);
    });

    test('adventurousness maps from the profile enum', () {
      final snapshot = FoodProfileSnapshot(
        profile: _profile(adventurousnessLevel: AdventurousnessLevel.often),
        foodRules: const [],
        allergies: const [],
        intolerances: const [],
        ingredientPreferences: const [],
        cuisinePreferences: const [],
        flavorPreferences: const [],
        foodItemPreferences: const [],
      );
      expect(buildFoodProfileAiContext(snapshot)['adventurousness'], 'often');
    });
  });
}
