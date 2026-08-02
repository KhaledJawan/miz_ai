import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/food_profile/domain/entities.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_snapshot.dart';
import 'package:miz_ai/features/food_profile/domain/profile_completeness_service.dart';

FoodProfile _profile({
  DietType dietType = DietType.unknown,
  int onboardingStep = 0,
  AdventurousnessLevel? adventurousnessLevel,
}) => FoodProfile(
  id: 1,
  localUserId: 1,
  dietType: dietType,
  adventurousnessLevel: adventurousnessLevel,
  onboardingStatus: OnboardingStatus.inProgress,
  onboardingVersion: 1,
  onboardingStep: onboardingStep,
  personalizationEnabled: true,
  profileCompleteness: 0,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

void main() {
  const service = ProfileCompletenessService();

  test('an empty, freshly-created profile scores 0', () {
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

    expect(service.compute(snapshot), 0.0);
  });

  test('a skipped question does not count as answered', () {
    // dietType stays "unknown" (never explicitly answered) — must not
    // silently earn the diet weight.
    final snapshot = FoodProfileSnapshot(
      profile: _profile(dietType: DietType.unknown),
      foodRules: const [],
      allergies: const [],
      intolerances: const [],
      ingredientPreferences: const [],
      cuisinePreferences: const [],
      flavorPreferences: const [],
      foodItemPreferences: const [],
    );

    expect(service.compute(snapshot), 0.0);
  });

  test('an explicit "no known allergies" answer counts as complete', () {
    // Represented as onboardingStep having advanced past the allergy step
    // even though the allergies list is empty (see service doc comment).
    final snapshot = FoodProfileSnapshot(
      profile: _profile(onboardingStep: 4),
      foodRules: const [],
      allergies: const [],
      intolerances: const [],
      ingredientPreferences: const [],
      cuisinePreferences: const [],
      flavorPreferences: const [],
      foodItemPreferences: const [],
    );

    expect(service.compute(snapshot), closeTo(0.20, 1e-9));
  });

  test('a fully completed profile scores 1.0', () {
    final snapshot = FoodProfileSnapshot(
      profile: _profile(
        dietType: DietType.omnivore,
        onboardingStep: 12,
        adventurousnessLevel: AdventurousnessLevel.often,
      ),
      foodRules: const [
        UserFoodRuleSelection(
          id: 1,
          foodRuleId: 1,
          foodRuleCode: 'noPork',
          requirementLevel: RequirementLevel.avoid,
          source: PreferenceSource.explicit,
        ),
      ],
      allergies: const [
        UserAllergy(
          id: 1,
          allergenId: 1,
          severity: AllergySeverity.mild,
          isActive: true,
          source: PreferenceSource.explicit,
        ),
      ],
      intolerances: const [
        UserIntolerance(
          id: 1,
          intoleranceId: 1,
          severity: AllergySeverity.mild,
          isActive: true,
        ),
      ],
      ingredientPreferences: const [
        UserIngredientPreferenceEntry(
          id: 1,
          ingredientId: 1,
          ingredientCode: 'beef',
          preferenceState: PreferenceState.like,
          restrictionType: RestrictionType.none,
          source: PreferenceSource.explicit,
          confidence: 1,
        ),
      ],
      cuisinePreferences: const [
        UserCuisinePreferenceEntry(
          id: 1,
          cuisineId: 1,
          cuisineCode: 'italian',
          preferenceState: PreferenceState.love,
          source: PreferenceSource.explicit,
          confidence: 1,
        ),
      ],
      flavorPreferences: const [
        UserFlavorPreferenceEntry(
          id: 1,
          flavorAttributeId: 1,
          flavorAttributeCode: 'spicy',
          preferenceLevel: 3,
          source: PreferenceSource.explicit,
        ),
      ],
      foodItemPreferences: const [
        UserFoodItemPreferenceEntry(
          id: 1,
          foodItemId: 1,
          preferenceState: PreferenceState.curious,
          source: PreferenceSource.explicit,
        ),
      ],
    );

    expect(service.compute(snapshot), closeTo(1.0, 1e-9));
  });

  test('score never exceeds 1.0 even with unexpected extra data', () {
    final snapshot = FoodProfileSnapshot(
      profile: _profile(
        dietType: DietType.vegan,
        onboardingStep: 20,
        adventurousnessLevel: AdventurousnessLevel.almostAlways,
      ),
      foodRules: const [
        UserFoodRuleSelection(
          id: 1,
          foodRuleId: 1,
          foodRuleCode: 'noPork',
          requirementLevel: RequirementLevel.avoid,
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

    expect(service.compute(snapshot), lessThanOrEqualTo(1.0));
  });
}
