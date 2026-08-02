import 'entities.dart';
import 'food_profile_enums.dart';

/// Everything [FoodEligibilityService] and [ProfileCompletenessService]
/// need, assembled once per evaluation by `FoodProfileProviders` from
/// [FoodProfileRepository] reads. Pure data — no Drift/Flutter imports.
class FoodProfileSnapshot {
  const FoodProfileSnapshot({
    required this.profile,
    required this.foodRules,
    required this.allergies,
    required this.intolerances,
    required this.ingredientPreferences,
    required this.cuisinePreferences,
    required this.flavorPreferences,
    required this.foodItemPreferences,
  });

  final FoodProfile profile;
  final List<UserFoodRuleSelection> foodRules;
  final List<UserAllergy> allergies;
  final List<UserIntolerance> intolerances;
  final List<UserIngredientPreferenceEntry> ingredientPreferences;
  final List<UserCuisinePreferenceEntry> cuisinePreferences;
  final List<UserFlavorPreferenceEntry> flavorPreferences;
  final List<UserFoodItemPreferenceEntry> foodItemPreferences;

  /// Allergen ids the user has flagged as an active allergy (any severity).
  Set<int> get activeAllergenIds => {
    for (final a in allergies)
      if (a.isActive && a.allergenId != null) a.allergenId!,
  };

  /// Allergen ids flagged as an active *severe* allergy — drives the
  /// conservative "may contain" exclusion rule.
  Set<int> get severeAllergenIds => {
    for (final a in allergies)
      if (a.isActive &&
          a.severity == AllergySeverity.severe &&
          a.allergenId != null)
        a.allergenId!,
  };

  /// Ingredient ids the user cannot eat: any [RestrictionType] other than
  /// `none` (strict exclusion, dietary, ethical, religious, intolerance, or
  /// allergy expressed at the ingredient level).
  Set<int> get restrictedIngredientIds => {
    for (final p in ingredientPreferences)
      if (p.restrictionType != RestrictionType.none) p.ingredientId,
  };

  /// Food-rule ids the user marked `required` — a strict dietary/religious
  /// exclusion, not a soft preference.
  Set<int> get requiredFoodRuleIds => {
    for (final r in foodRules)
      if (r.requirementLevel == RequirementLevel.required) r.foodRuleId,
  };
}
