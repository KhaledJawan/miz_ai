import '../../domain/entities.dart';
import '../../domain/food_profile_enums.dart';

/// The 11 linear onboarding screens. Content *within* a screen adapts to
/// earlier answers (e.g. Proteins hides meat for a vegan diet) rather than
/// whole screens being skipped — see docs/DESIGN.md and the onboarding
/// brief's adaptive-skip examples.
enum OnboardingScreen {
  welcome,
  diet,
  foodRules,
  allergies,
  intolerances,
  proteins,
  cuisines,
  flavors,
  eatingStyle,
  foodSamples,
  review,
}

class AllergyDraft {
  const AllergyDraft({
    this.allergenId,
    this.customName,
    this.severity = AllergySeverity.unspecified,
    this.notes,
  });

  final int? allergenId;
  final String? customName;
  final AllergySeverity severity;
  final String? notes;

  String get key =>
      allergenId != null ? 'a$allergenId' : 'c${customName ?? ''}';

  AllergyDraft copyWith({AllergySeverity? severity, String? notes}) =>
      AllergyDraft(
        allergenId: allergenId,
        customName: customName,
        severity: severity ?? this.severity,
        notes: notes ?? this.notes,
      );
}

class IntoleranceDraft {
  const IntoleranceDraft({this.intoleranceId, this.customName, this.severity});

  final int? intoleranceId;
  final String? customName;
  final AllergySeverity? severity;

  String get key =>
      intoleranceId != null ? 'i$intoleranceId' : 'c${customName ?? ''}';
}

/// In-memory answers for the screen currently being edited (both during
/// onboarding and when a Settings "redo this section" edit reuses the same
/// step widgets). Each screen's `advance()` call persists that screen's
/// slice through [FoodProfileRepository] immediately — see
/// `onboarding_controller.dart`.
class OnboardingDraftState {
  const OnboardingDraftState({
    required this.screenIndex,
    this.dietType = DietType.unknown,
    this.foodRules = const {},
    this.allergies = const {},
    this.noKnownAllergies = false,
    this.intolerances = const {},
    this.noKnownIntolerances = false,
    this.ingredientPreferences = const {},
    this.cuisinePreferences = const {},
    this.flavorPreferences = const {},
    this.adventurousnessLevel,
    this.preferredMealWeight,
    this.budgetLevel,
    this.topPriorities = const [],
    this.foodItemPreferences = const {},
    required this.allergenCatalog,
    required this.intoleranceCatalog,
    required this.foodRuleCatalog,
    required this.ingredientCatalog,
    required this.cuisineCatalog,
    required this.flavorCatalog,
    required this.foodItemCatalog,
  });

  final int screenIndex;
  OnboardingScreen get screen => OnboardingScreen.values[screenIndex];

  final DietType dietType;
  final Map<int, RequirementLevel> foodRules;
  final Map<String, AllergyDraft> allergies;
  final bool noKnownAllergies;
  final Map<String, IntoleranceDraft> intolerances;
  final bool noKnownIntolerances;
  final Map<int, (PreferenceState, RestrictionType)> ingredientPreferences;
  final Map<int, PreferenceState> cuisinePreferences;
  final Map<int, int> flavorPreferences;
  final AdventurousnessLevel? adventurousnessLevel;
  final MealWeightPreference? preferredMealWeight;
  final BudgetLevel? budgetLevel;
  final List<EatingPriority> topPriorities;
  final Map<int, PreferenceState> foodItemPreferences;

  final List<CatalogEntry> allergenCatalog;
  final List<CatalogEntry> intoleranceCatalog;
  final List<CatalogEntry> foodRuleCatalog;
  final List<IngredientEntry> ingredientCatalog;
  final List<CatalogEntry> cuisineCatalog;
  final List<CatalogEntry> flavorCatalog;
  final List<FoodItemEntry> foodItemCatalog;

  bool get hasSevereAllergy =>
      allergies.values.any((a) => a.severity == AllergySeverity.severe);

  bool get isLastScreen => screenIndex == OnboardingScreen.values.length - 1;
  bool get isFirstScreen => screenIndex == 0;
  bool get showSkip => screenIndex == 0;

  /// Meat/seafood ingredients hidden by the current diet answer — the
  /// concrete implementation of "a vegan user should not be asked which
  /// meats they like."
  List<IngredientEntry> get visibleProteinIngredients {
    return ingredientCatalog.where((ingredient) {
      if (ingredient.category != 'meat' && ingredient.category != 'seafood') {
        return true;
      }
      switch (dietType) {
        case DietType.vegan:
        case DietType.vegetarian:
          return false;
        case DietType.pescatarian:
          return ingredient.category == 'seafood';
        default:
          return true;
      }
    }).toList();
  }

  OnboardingDraftState copyWith({
    int? screenIndex,
    DietType? dietType,
    Map<int, RequirementLevel>? foodRules,
    Map<String, AllergyDraft>? allergies,
    bool? noKnownAllergies,
    Map<String, IntoleranceDraft>? intolerances,
    bool? noKnownIntolerances,
    Map<int, (PreferenceState, RestrictionType)>? ingredientPreferences,
    Map<int, PreferenceState>? cuisinePreferences,
    Map<int, int>? flavorPreferences,
    AdventurousnessLevel? adventurousnessLevel,
    MealWeightPreference? preferredMealWeight,
    BudgetLevel? budgetLevel,
    List<EatingPriority>? topPriorities,
    Map<int, PreferenceState>? foodItemPreferences,
  }) {
    return OnboardingDraftState(
      screenIndex: screenIndex ?? this.screenIndex,
      dietType: dietType ?? this.dietType,
      foodRules: foodRules ?? this.foodRules,
      allergies: allergies ?? this.allergies,
      noKnownAllergies: noKnownAllergies ?? this.noKnownAllergies,
      intolerances: intolerances ?? this.intolerances,
      noKnownIntolerances: noKnownIntolerances ?? this.noKnownIntolerances,
      ingredientPreferences:
          ingredientPreferences ?? this.ingredientPreferences,
      cuisinePreferences: cuisinePreferences ?? this.cuisinePreferences,
      flavorPreferences: flavorPreferences ?? this.flavorPreferences,
      adventurousnessLevel: adventurousnessLevel ?? this.adventurousnessLevel,
      preferredMealWeight: preferredMealWeight ?? this.preferredMealWeight,
      budgetLevel: budgetLevel ?? this.budgetLevel,
      topPriorities: topPriorities ?? this.topPriorities,
      foodItemPreferences: foodItemPreferences ?? this.foodItemPreferences,
      allergenCatalog: allergenCatalog,
      intoleranceCatalog: intoleranceCatalog,
      foodRuleCatalog: foodRuleCatalog,
      ingredientCatalog: ingredientCatalog,
      cuisineCatalog: cuisineCatalog,
      flavorCatalog: flavorCatalog,
      foodItemCatalog: foodItemCatalog,
    );
  }
}
