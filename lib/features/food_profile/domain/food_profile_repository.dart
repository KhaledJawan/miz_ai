import 'entities.dart';
import 'food_profile_enums.dart';

/// The single read/write surface for the whole Food Preference Profile.
/// `presentation/` and the services depend only on this interface — the
/// Drift-backed implementation lives in `data/food_profile_repository_impl.dart`.
/// See docs/ARCHITECTURE.md §4.
abstract interface class FoodProfileRepository {
  // Profile
  Future<FoodProfile> ensureProfile();
  Stream<FoodProfile> watchProfile();
  Future<void> updateDiet(DietType dietType);
  Future<void> updateEatingStyle({
    AdventurousnessLevel? adventurousnessLevel,
    MealWeightPreference? preferredMealWeight,
    BudgetLevel? budgetLevel,
    List<EatingPriority>? topPriorities,
  });
  Future<void> setOnboardingStep(int step);
  Future<void> completeOnboarding({required int onboardingVersion});
  Future<void> skipOnboarding();
  Future<void> restartOnboarding();
  Future<void> setPersonalizationEnabled(bool enabled);
  Future<void> recomputeCompleteness();

  // Catalogs (read-only reference data)
  Future<List<CatalogEntry>> getAllergenCatalog();
  Future<List<CatalogEntry>> getIntoleranceCatalog();
  Future<List<CatalogEntry>> getFoodRuleCatalog();
  Future<List<CatalogEntry>> getCuisineCatalog();
  Future<List<CatalogEntry>> getFlavorAttributeCatalog();
  Future<List<IngredientEntry>> getIngredientCatalog();
  Future<List<FoodItemEntry>> getFoodItemCatalog();

  // Food rules
  Future<List<UserFoodRuleSelection>> getFoodRules();
  Future<void> replaceFoodRules(List<UserFoodRuleSelection> selections);

  // Allergies
  Future<List<UserAllergy>> getAllergies();
  Stream<List<UserAllergy>> watchAllergies();
  Future<void> replaceAllergies(List<UserAllergy> allergies);
  Future<void> clearAllergies();

  // Intolerances
  Future<List<UserIntolerance>> getIntolerances();
  Future<void> replaceIntolerances(List<UserIntolerance> intolerances);

  // Ingredient preferences (covers protein/meat step + ingredient excludes)
  Future<List<UserIngredientPreferenceEntry>> getIngredientPreferences();
  Future<void> upsertIngredientPreference(
    int ingredientId,
    PreferenceState state,
    RestrictionType restriction,
  );

  // Cuisine preferences
  Future<List<UserCuisinePreferenceEntry>> getCuisinePreferences();
  Future<void> upsertCuisinePreference(int cuisineId, PreferenceState state);

  // Flavor preferences
  Future<List<UserFlavorPreferenceEntry>> getFlavorPreferences();
  Future<void> upsertFlavorPreference(int flavorAttributeId, int level);

  // Food item (visual sample) preferences
  Future<List<UserFoodItemPreferenceEntry>> getFoodItemPreferences();
  Future<void> upsertFoodItemPreference(int foodItemId, PreferenceState state);

  // Reset / privacy
  Future<void> resetFoodProfile();
  Future<void> deleteInteractionHistory();
}
