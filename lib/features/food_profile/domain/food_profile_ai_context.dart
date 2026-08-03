import 'food_profile_enums.dart';
import 'food_profile_snapshot.dart';

const _spiceLevelLabels = ['none', 'mild', 'medium', 'hot', 'veryHot'];

/// Builds the minimized Food Profile summary sent to the miz-ai Edge
/// Function as `foodProfileContext`. This is the client-side half of the
/// "local Food Profile, not yet synced to Supabase" architecture: the
/// server re-validates/clamps every field rather than trusting it (see
/// `supabase/functions/miz-ai/food_profile.ts`), so this function only
/// needs to produce a correct, small, JSON-safe map — never precise
/// location, never raw interaction history, and every distinct safety
/// concept (allergy/intolerance/strict restriction/dislike) stays on its
/// own field, matching `FoodEligibilityService`'s separation.
Map<String, dynamic> buildFoodProfileAiContext(FoodProfileSnapshot snapshot) {
  return {
    'dietType': snapshot.profile.dietType == DietType.unknown
        ? null
        : snapshot.profile.dietType.name,
    'strictRestrictions': [
      for (final rule in snapshot.foodRules)
        if (rule.requirementLevel == RequirementLevel.required)
          rule.foodRuleCode,
    ],
    'allergies': [
      for (final allergy in snapshot.allergies)
        if (allergy.isActive)
          {'code': allergy.label, 'severity': allergy.severity.name},
    ],
    'intolerances': [
      for (final intolerance in snapshot.intolerances)
        if (intolerance.isActive) intolerance.label,
    ],
    'dislikedIngredients': [
      for (final pref in snapshot.ingredientPreferences)
        if (pref.preferenceState == PreferenceState.dislike)
          pref.ingredientCode,
    ],
    'likedCuisines': [
      for (final pref in snapshot.cuisinePreferences)
        if (pref.preferenceState == PreferenceState.love ||
            pref.preferenceState == PreferenceState.like)
          pref.cuisineCode,
    ],
    'curiousCuisines': [
      for (final pref in snapshot.cuisinePreferences)
        if (pref.preferenceState == PreferenceState.curious) pref.cuisineCode,
    ],
    'spiceLevel': _spiceLevel(snapshot),
    'adventurousness': snapshot.profile.adventurousnessLevel?.name,
  };
}

String? _spiceLevel(FoodProfileSnapshot snapshot) {
  for (final pref in snapshot.flavorPreferences) {
    if (pref.flavorAttributeCode == 'spicy') {
      final level = pref.preferenceLevel.clamp(0, _spiceLevelLabels.length - 1);
      return _spiceLevelLabels[level];
    }
  }
  return null;
}
