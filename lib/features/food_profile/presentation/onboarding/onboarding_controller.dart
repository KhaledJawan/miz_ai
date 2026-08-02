import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities.dart';
import '../../domain/food_profile_enums.dart';
import '../providers/food_profile_providers.dart';
import 'onboarding_draft_state.dart';

part 'onboarding_controller.g.dart';

AllergyDraft _allergyDraftFrom(UserAllergy allergy) => AllergyDraft(
  allergenId: allergy.allergenId,
  customName: allergy.customName,
  severity: allergy.severity,
  notes: allergy.notes,
);

IntoleranceDraft _intoleranceDraftFrom(UserIntolerance intolerance) =>
    IntoleranceDraft(
      intoleranceId: intolerance.intoleranceId,
      customName: intolerance.customName,
      severity: intolerance.severity,
    );

/// Drives the 11-screen Food Preference Profile onboarding. Persists each
/// screen's answers immediately on `advance()` (small transaction per
/// screen, not one at the end) so progress survives an app restart — on
/// rebuild, [build] hydrates the draft from whatever was already saved and
/// resumes at the saved `onboardingStep`. See docs/DECISIONS.md and
/// CLAUDE.md §7 (no business logic in widgets — every mutation goes
/// through this controller).
@riverpod
class FoodProfileOnboardingController
    extends _$FoodProfileOnboardingController {
  @override
  Future<OnboardingDraftState> build() async {
    final repository = ref.watch(foodProfileRepositoryProvider);
    final profile = await repository.ensureProfile();

    final catalogs = await (
      repository.getAllergenCatalog(),
      repository.getIntoleranceCatalog(),
      repository.getFoodRuleCatalog(),
      repository.getIngredientCatalog(),
      repository.getCuisineCatalog(),
      repository.getFlavorAttributeCatalog(),
      repository.getFoodItemCatalog(),
    ).wait;

    final savedAnswers = await (
      repository.getFoodRules(),
      repository.getAllergies(),
      repository.getIntolerances(),
      repository.getIngredientPreferences(),
      repository.getCuisinePreferences(),
      repository.getFlavorPreferences(),
      repository.getFoodItemPreferences(),
    ).wait;

    final savedFoodRules = savedAnswers.$1;
    final savedAllergies = savedAnswers.$2;
    final savedIntolerances = savedAnswers.$3;
    final savedIngredientPrefs = savedAnswers.$4;
    final savedCuisinePrefs = savedAnswers.$5;
    final savedFlavorPrefs = savedAnswers.$6;
    final savedFoodItemPrefs = savedAnswers.$7;

    final resumeStep = profile.onboardingStatus == OnboardingStatus.inProgress
        ? profile.onboardingStep.clamp(0, OnboardingScreen.values.length - 1)
        : 0;

    return OnboardingDraftState(
      screenIndex: resumeStep,
      dietType: profile.dietType,
      foodRules: {
        for (final r in savedFoodRules) r.foodRuleId: r.requirementLevel,
      },
      allergies: {
        for (final a in savedAllergies.where(
          (a) => a.allergenId != null || a.customName != null,
        ))
          _allergyDraftFrom(a).key: _allergyDraftFrom(a),
      },
      noKnownAllergies: savedAllergies.isEmpty && profile.onboardingStep > 3,
      intolerances: {
        for (final i in savedIntolerances.where(
          (i) => i.intoleranceId != null || i.customName != null,
        ))
          _intoleranceDraftFrom(i).key: _intoleranceDraftFrom(i),
      },
      noKnownIntolerances:
          savedIntolerances.isEmpty && profile.onboardingStep > 4,
      ingredientPreferences: {
        for (final p in savedIngredientPrefs)
          p.ingredientId: (p.preferenceState, p.restrictionType),
      },
      cuisinePreferences: {
        for (final c in savedCuisinePrefs) c.cuisineId: c.preferenceState,
      },
      flavorPreferences: {
        for (final f in savedFlavorPrefs)
          f.flavorAttributeId: f.preferenceLevel,
      },
      adventurousnessLevel: profile.adventurousnessLevel,
      preferredMealWeight: profile.preferredMealWeight,
      budgetLevel: profile.budgetLevel,
      topPriorities: profile.topPriorities,
      foodItemPreferences: {
        for (final f in savedFoodItemPrefs) f.foodItemId: f.preferenceState,
      },
      allergenCatalog: catalogs.$1,
      intoleranceCatalog: catalogs.$2,
      foodRuleCatalog: catalogs.$3,
      ingredientCatalog: catalogs.$4,
      cuisineCatalog: catalogs.$5,
      flavorCatalog: catalogs.$6,
      foodItemCatalog: catalogs.$7,
    );
  }

  void _update(OnboardingDraftState Function(OnboardingDraftState) updater) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(updater(current));
  }

  // ---- Diet ----
  void setDietType(DietType dietType) =>
      _update((s) => s.copyWith(dietType: dietType));

  // ---- Food rules ----
  void setFoodRule(int foodRuleId, RequirementLevel? level) => _update((s) {
    final next = {...s.foodRules};
    if (level == null) {
      next.remove(foodRuleId);
    } else {
      next[foodRuleId] = level;
    }
    return s.copyWith(foodRules: next);
  });

  // ---- Allergies ----
  void setAllergy(AllergyDraft draft) => _update((s) {
    final next = {...s.allergies}..[draft.key] = draft;
    return s.copyWith(allergies: next, noKnownAllergies: false);
  });

  void removeAllergy(String key) => _update((s) {
    final next = {...s.allergies}..remove(key);
    return s.copyWith(allergies: next);
  });

  void setNoKnownAllergies(bool value) => _update(
    (s) => s.copyWith(
      noKnownAllergies: value,
      allergies: value ? const {} : s.allergies,
    ),
  );

  // ---- Intolerances ----
  void setIntolerance(IntoleranceDraft draft) => _update((s) {
    final next = {...s.intolerances}..[draft.key] = draft;
    return s.copyWith(intolerances: next, noKnownIntolerances: false);
  });

  void removeIntolerance(String key) => _update((s) {
    final next = {...s.intolerances}..remove(key);
    return s.copyWith(intolerances: next);
  });

  void setNoKnownIntolerances(bool value) => _update(
    (s) => s.copyWith(
      noKnownIntolerances: value,
      intolerances: value ? const {} : s.intolerances,
    ),
  );

  // ---- Ingredient preferences (proteins step + general excludes) ----
  void setIngredientPreference(
    int ingredientId,
    PreferenceState state,
    RestrictionType restriction,
  ) => _update((s) {
    final next = {...s.ingredientPreferences}
      ..[ingredientId] = (state, restriction);
    return s.copyWith(ingredientPreferences: next);
  });

  // ---- Cuisines ----
  void setCuisinePreference(int cuisineId, PreferenceState value) =>
      _update((s) {
        final next = {...s.cuisinePreferences}..[cuisineId] = value;
        return s.copyWith(cuisinePreferences: next);
      });

  // ---- Flavors ----
  void setFlavorPreference(int flavorAttributeId, int level) => _update((s) {
    final next = {...s.flavorPreferences}..[flavorAttributeId] = level;
    return s.copyWith(flavorPreferences: next);
  });

  // ---- Eating style ----
  void setAdventurousness(AdventurousnessLevel level) =>
      _update((s) => s.copyWith(adventurousnessLevel: level));

  void setMealWeight(MealWeightPreference weight) =>
      _update((s) => s.copyWith(preferredMealWeight: weight));

  void setBudget(BudgetLevel level) =>
      _update((s) => s.copyWith(budgetLevel: level));

  void togglePriority(EatingPriority priority) => _update((s) {
    final next = [...s.topPriorities];
    if (next.contains(priority)) {
      next.remove(priority);
    } else if (next.length < 3) {
      next.add(priority);
    }
    return s.copyWith(topPriorities: next);
  });

  // ---- Food samples ----
  void setFoodItemPreference(int foodItemId, PreferenceState value) =>
      _update((s) {
        final next = {...s.foodItemPreferences}..[foodItemId] = value;
        return s.copyWith(foodItemPreferences: next);
      });

  // ---- Navigation / persistence ----

  Future<void> goToScreen(int index) async {
    _update((s) => s.copyWith(screenIndex: index));
    await ref.read(foodProfileRepositoryProvider).setOnboardingStep(index);
  }

  /// Persists the current screen's answers and advances. Returns true once
  /// the final (review) screen has been confirmed, so the page can
  /// navigate to Home.
  Future<bool> advance() async {
    final current = state.valueOrNull;
    if (current == null) return false;
    final repository = ref.read(foodProfileRepositoryProvider);

    switch (current.screen) {
      case OnboardingScreen.welcome:
        break;
      case OnboardingScreen.diet:
        await repository.updateDiet(current.dietType);
      case OnboardingScreen.foodRules:
        await repository.replaceFoodRules([
          for (final entry in current.foodRules.entries)
            UserFoodRuleSelection(
              id: 0,
              foodRuleId: entry.key,
              foodRuleCode: '',
              requirementLevel: entry.value,
              source: PreferenceSource.explicit,
            ),
        ]);
      case OnboardingScreen.allergies:
        await repository.replaceAllergies([
          for (final draft in current.allergies.values)
            UserAllergy(
              id: 0,
              allergenId: draft.allergenId,
              customName: draft.customName,
              severity: draft.severity,
              notes: draft.notes,
              isActive: true,
              source: PreferenceSource.explicit,
            ),
        ]);
      case OnboardingScreen.intolerances:
        await repository.replaceIntolerances([
          for (final draft in current.intolerances.values)
            UserIntolerance(
              id: 0,
              intoleranceId: draft.intoleranceId,
              customName: draft.customName,
              severity: draft.severity ?? AllergySeverity.unspecified,
              isActive: true,
            ),
        ]);
      case OnboardingScreen.proteins:
        for (final entry in current.ingredientPreferences.entries) {
          await repository.upsertIngredientPreference(
            entry.key,
            entry.value.$1,
            entry.value.$2,
          );
        }
      case OnboardingScreen.cuisines:
        for (final entry in current.cuisinePreferences.entries) {
          await repository.upsertCuisinePreference(entry.key, entry.value);
        }
      case OnboardingScreen.flavors:
        for (final entry in current.flavorPreferences.entries) {
          await repository.upsertFlavorPreference(entry.key, entry.value);
        }
      case OnboardingScreen.eatingStyle:
        await repository.updateEatingStyle(
          adventurousnessLevel: current.adventurousnessLevel,
          preferredMealWeight: current.preferredMealWeight,
          budgetLevel: current.budgetLevel,
          topPriorities: current.topPriorities,
        );
      case OnboardingScreen.foodSamples:
        for (final entry in current.foodItemPreferences.entries) {
          await repository.upsertFoodItemPreference(entry.key, entry.value);
        }
      case OnboardingScreen.review:
        await repository.completeOnboarding(onboardingVersion: 1);
        return true;
    }

    if (current.isLastScreen) {
      await repository.completeOnboarding(onboardingVersion: 1);
      return true;
    }

    final nextIndex = current.screenIndex + 1;
    await repository.setOnboardingStep(nextIndex);
    _update((s) => s.copyWith(screenIndex: nextIndex));
    return false;
  }

  Future<void> skipForNow() async {
    await ref.read(foodProfileRepositoryProvider).skipOnboarding();
  }
}
