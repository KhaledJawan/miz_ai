import 'package:freezed_annotation/freezed_annotation.dart';

import 'food_profile_enums.dart';

part 'entities.freezed.dart';

/// The top-level profile row — one per local user (today: always
/// [kLocalUserId]). Mirrors `food_profiles` — see docs/DATABASE.md.
@freezed
abstract class FoodProfile with _$FoodProfile {
  const factory FoodProfile({
    required int id,
    required int localUserId,
    required DietType dietType,
    AdventurousnessLevel? adventurousnessLevel,
    MealWeightPreference? preferredMealWeight,
    BudgetLevel? budgetLevel,
    @Default([]) List<EatingPriority> topPriorities,
    required OnboardingStatus onboardingStatus,
    required int onboardingVersion,
    required int onboardingStep,
    required bool personalizationEnabled,
    required double profileCompleteness,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
    DateTime? skippedAt,
  }) = _FoodProfile;

  const FoodProfile._();

  bool get isOnboarded =>
      onboardingStatus == OnboardingStatus.completed ||
      onboardingStatus == OnboardingStatus.skipped;
}

/// A catalog entry shared by allergens, intolerances, food rules, cuisines,
/// and flavor attributes — they all share the same `id`/`code`/optional
/// `category` shape. Ingredients are hierarchical and get their own
/// [IngredientEntry] instead.
@freezed
abstract class CatalogEntry with _$CatalogEntry {
  const factory CatalogEntry({
    required int id,
    required String code,
    String? category,
  }) = _CatalogEntry;
}

@freezed
abstract class IngredientEntry with _$IngredientEntry {
  const factory IngredientEntry({
    required int id,
    required String code,
    int? parentId,
    required String category,
    required bool isAnimalProduct,
    required bool isMeat,
    required bool isSeafood,
    required bool isAlcoholRelated,
  }) = _IngredientEntry;
}

@freezed
abstract class UserAllergy with _$UserAllergy {
  const factory UserAllergy({
    required int id,
    int? allergenId,
    String? allergenCode,
    String? customName,
    required AllergySeverity severity,
    String? notes,
    required bool isActive,
    required PreferenceSource source,
  }) = _UserAllergy;

  const UserAllergy._();

  String get label => customName ?? allergenCode ?? 'unknown';
}

@freezed
abstract class UserIntolerance with _$UserIntolerance {
  const factory UserIntolerance({
    required int id,
    int? intoleranceId,
    String? intoleranceCode,
    String? customName,
    required AllergySeverity severity,
    String? notes,
    required bool isActive,
  }) = _UserIntolerance;

  const UserIntolerance._();

  String get label => customName ?? intoleranceCode ?? 'unknown';
}

@freezed
abstract class UserFoodRuleSelection with _$UserFoodRuleSelection {
  const factory UserFoodRuleSelection({
    required int id,
    required int foodRuleId,
    required String foodRuleCode,
    required RequirementLevel requirementLevel,
    required PreferenceSource source,
    String? notes,
  }) = _UserFoodRuleSelection;
}

@freezed
abstract class UserIngredientPreferenceEntry
    with _$UserIngredientPreferenceEntry {
  const factory UserIngredientPreferenceEntry({
    required int id,
    required int ingredientId,
    required String ingredientCode,
    required PreferenceState preferenceState,
    required RestrictionType restrictionType,
    required PreferenceSource source,
    required double confidence,
    String? notes,
  }) = _UserIngredientPreferenceEntry;
}

@freezed
abstract class UserCuisinePreferenceEntry with _$UserCuisinePreferenceEntry {
  const factory UserCuisinePreferenceEntry({
    required int id,
    required int cuisineId,
    required String cuisineCode,
    required PreferenceState preferenceState,
    double? curiosityScore,
    required PreferenceSource source,
    required double confidence,
  }) = _UserCuisinePreferenceEntry;
}

@freezed
abstract class UserFlavorPreferenceEntry with _$UserFlavorPreferenceEntry {
  const factory UserFlavorPreferenceEntry({
    required int id,
    required int flavorAttributeId,
    required String flavorAttributeCode,
    required int preferenceLevel,
    required PreferenceSource source,
  }) = _UserFlavorPreferenceEntry;
}

@freezed
abstract class FoodItemEntry with _$FoodItemEntry {
  const factory FoodItemEntry({
    required int id,
    required String code,
    int? cuisineId,
    String? imageAsset,
    @Default([]) List<int> primaryIngredientIds,
    @Default([]) List<int> mayContainIngredientIds,
    @Default([]) List<int> allergenIds,
    @Default([]) List<int> mayContainAllergenIds,
  }) = _FoodItemEntry;
}

@freezed
abstract class UserFoodItemPreferenceEntry with _$UserFoodItemPreferenceEntry {
  const factory UserFoodItemPreferenceEntry({
    required int id,
    required int foodItemId,
    required PreferenceState preferenceState,
    required PreferenceSource source,
  }) = _UserFoodItemPreferenceEntry;
}

/// A single answered onboarding step's payload, used to persist partial
/// progress and to drive "redo this section" edits from Settings.
enum FoodProfileSection {
  diet,
  foodRules,
  allergies,
  intolerances,
  proteins,
  cuisines,
  flavors,
  eatingStyle,
  foodSamples,
}
