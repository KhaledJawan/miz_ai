import 'food_profile_enums.dart';
import 'food_profile_snapshot.dart';

/// Deterministic, weighted completeness score (0.0–1.0). No AI, no
/// heuristics beyond the fixed weights below. A section counts as complete
/// only when the user gave an explicit answer — "no allergies" (explicitly
/// selected) counts; a skipped question never does. See docs/PRD.md
/// "Profile completeness" and the onboarding brief's weighting table.
class ProfileCompletenessService {
  const ProfileCompletenessService();

  static const double _dietWeight = 0.15;
  static const double _restrictionsWeight = 0.15;
  static const double _allergiesWeight = 0.20;
  static const double _intolerancesWeight = 0.10;
  static const double _ingredientsWeight = 0.15;
  static const double _cuisinesWeight = 0.10;
  static const double _flavorsWeight = 0.05;
  static const double _eatingStyleWeight = 0.05;
  static const double _foodSamplesWeight = 0.05;

  double compute(FoodProfileSnapshot snapshot) {
    var score = 0.0;

    if (snapshot.profile.dietType != DietType.unknown) {
      score += _dietWeight;
    }
    if (snapshot.foodRules.isNotEmpty) {
      score += _restrictionsWeight;
    }
    // "No known allergies" is stored as an explicit empty-but-answered
    // marker via the profile's onboardingStep progression; here we treat
    // any allergy row (including an explicit "none" sentinel with
    // allergenId/customName both null and isActive=false) as answered.
    if (snapshot.allergies.isNotEmpty || snapshot.profile.onboardingStep > 3) {
      score += _allergiesWeight;
    }
    if (snapshot.intolerances.isNotEmpty ||
        snapshot.profile.onboardingStep > 4) {
      score += _intolerancesWeight;
    }
    if (snapshot.ingredientPreferences.isNotEmpty) {
      score += _ingredientsWeight;
    }
    if (snapshot.cuisinePreferences.isNotEmpty) {
      score += _cuisinesWeight;
    }
    if (snapshot.flavorPreferences.isNotEmpty) {
      score += _flavorsWeight;
    }
    if (snapshot.profile.adventurousnessLevel != null) {
      score += _eatingStyleWeight;
    }
    if (snapshot.foodItemPreferences.isNotEmpty) {
      score += _foodSamplesWeight;
    }

    return score.clamp(0.0, 1.0);
  }
}
