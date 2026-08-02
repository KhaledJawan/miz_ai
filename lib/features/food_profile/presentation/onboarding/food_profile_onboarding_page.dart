import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities.dart';
import '../../domain/food_profile_enums.dart';
import 'onboarding_controller.dart';
import 'onboarding_draft_state.dart';
import 'steps/allergies_step.dart';
import 'steps/cuisines_step.dart';
import 'steps/diet_step.dart';
import 'steps/eating_style_step.dart';
import 'steps/flavors_step.dart';
import 'steps/food_rules_step.dart';
import 'steps/food_samples_step.dart';
import 'steps/intolerances_step.dart';
import 'steps/proteins_step.dart';
import 'steps/review_step.dart';
import 'steps/welcome_step.dart';

/// Replaces the old generic 3-step [OnboardingPage] at the same route. One
/// screen per [OnboardingScreen], each screen's answers persisted
/// immediately by [FoodProfileOnboardingController.advance] so progress
/// survives a restart (see that controller's `build()`).
class FoodProfileOnboardingPage extends ConsumerWidget {
  const FoodProfileOnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDraft = ref.watch(foodProfileOnboardingControllerProvider);
    final controller = ref.read(
      foodProfileOnboardingControllerProvider.notifier,
    );
    final l10n = context.l10n;
    final colors = context.mizColors;

    return Scaffold(
      body: MizBackdrop(
        child: SafeArea(
          child: asyncDraft.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('$error')),
            data: (draft) {
              Future<void> handleNext() async {
                if (draft.screen == OnboardingScreen.allergies &&
                    draft.hasSevereAllergy) {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text(l10n.severeAllergyConfirmTitle),
                      content: Text(l10n.severeAllergyConfirmBody),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                          child: Text(l10n.cancelLabel),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                          child: Text(l10n.continueLabel),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true) return;
                }
                final completed = await controller.advance();
                if (completed && context.mounted) context.go(AppRoutes.home);
              }

              Future<void> handleSkip() async {
                await controller.skipForNow();
                if (context.mounted) context.go(AppRoutes.home);
              }

              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lgPlus,
                  AppSpacing.lg,
                  AppSpacing.lgPlus,
                  AppSpacing.lgPlus,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (!draft.isFirstScreen)
                          MizIconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            semanticLabel: l10n.foodProfileBack,
                            onPressed: () =>
                                controller.goToScreen(draft.screenIndex - 1),
                          ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: draft.isFirstScreen ? 0 : AppSpacing.sm,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppRadii.full,
                              ),
                              child: LinearProgressIndicator(
                                value:
                                    (draft.screenIndex + 1) /
                                    OnboardingScreen.values.length,
                                minHeight: 4,
                                backgroundColor: colors.divider,
                                valueColor: AlwaysStoppedAnimation(
                                  colors.accent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (draft.showSkip)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: AppSpacing.sm,
                            ),
                            child: MizButton.ghost(
                              label: l10n.notNow,
                              onPressed: handleSkip,
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: AppMotion.slow,
                        switchInCurve: AppMotion.enter,
                        switchOutCurve: AppMotion.rearrange,
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.04),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        child: SingleChildScrollView(
                          key: ValueKey(draft.screen),
                          padding: const EdgeInsets.only(top: AppSpacing.lg),
                          child: _stepFor(draft, controller),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    MizButton.primary(
                      label: switch (draft.screen) {
                        OnboardingScreen.welcome => l10n.getStarted,
                        OnboardingScreen.review => l10n.foodProfileComplete,
                        _ => l10n.continueLabel,
                      },
                      expand: true,
                      onPressed: handleNext,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _stepFor(
    OnboardingDraftState draft,
    FoodProfileOnboardingController controller,
  ) {
    return switch (draft.screen) {
      OnboardingScreen.welcome => const WelcomeStep(),
      OnboardingScreen.diet => DietStep(
        value: draft.dietType,
        onChanged: controller.setDietType,
      ),
      OnboardingScreen.foodRules => FoodRulesStep(
        catalog: draft.foodRuleCatalog,
        selections: draft.foodRules,
        onChanged: controller.setFoodRule,
      ),
      OnboardingScreen.allergies => AllergiesStep(
        catalog: draft.allergenCatalog,
        selections: draft.allergies,
        noKnownAllergies: draft.noKnownAllergies,
        onToggle: (allergen) => _toggleAllergy(draft, controller, allergen),
        onSeverityChanged: (key, severity) =>
            _setAllergySeverity(draft, controller, key, severity),
        onAddCustom: (name) =>
            controller.setAllergy(AllergyDraft(customName: name)),
        onNoKnownAllergiesChanged: controller.setNoKnownAllergies,
      ),
      OnboardingScreen.intolerances => IntolerancesStep(
        catalog: draft.intoleranceCatalog,
        selections: draft.intolerances,
        noKnownIntolerances: draft.noKnownIntolerances,
        onToggle: (intolerance) =>
            _toggleIntolerance(draft, controller, intolerance),
        onNoKnownIntolerancesChanged: controller.setNoKnownIntolerances,
      ),
      OnboardingScreen.proteins => ProteinsStep(
        ingredients: draft.visibleProteinIngredients,
        selections: draft.ingredientPreferences,
        onChanged: controller.setIngredientPreference,
      ),
      OnboardingScreen.cuisines => CuisinesStep(
        catalog: draft.cuisineCatalog,
        selections: draft.cuisinePreferences,
        onChanged: controller.setCuisinePreference,
      ),
      OnboardingScreen.flavors => FlavorsStep(
        catalog: draft.flavorCatalog,
        selections: draft.flavorPreferences,
        onChanged: controller.setFlavorPreference,
      ),
      OnboardingScreen.eatingStyle => EatingStyleStep(
        adventurousnessLevel: draft.adventurousnessLevel,
        preferredMealWeight: draft.preferredMealWeight,
        budgetLevel: draft.budgetLevel,
        topPriorities: draft.topPriorities,
        onAdventurousnessChanged: controller.setAdventurousness,
        onMealWeightChanged: controller.setMealWeight,
        onBudgetChanged: controller.setBudget,
        onPriorityToggled: controller.togglePriority,
      ),
      OnboardingScreen.foodSamples => FoodSamplesStep(
        items: _visibleFoodItems(draft),
        cuisineCatalog: draft.cuisineCatalog,
        selections: draft.foodItemPreferences,
        onChanged: controller.setFoodItemPreference,
      ),
      OnboardingScreen.review => ReviewStep(
        draft: draft,
        onEditSection: (screen) => controller.goToScreen(screen.index),
      ),
    };
  }

  void _toggleAllergy(
    OnboardingDraftState draft,
    FoodProfileOnboardingController controller,
    CatalogEntry allergen,
  ) {
    final key = 'a${allergen.id}';
    if (draft.allergies.containsKey(key)) {
      controller.removeAllergy(key);
    } else {
      controller.setAllergy(AllergyDraft(allergenId: allergen.id));
    }
  }

  void _setAllergySeverity(
    OnboardingDraftState draft,
    FoodProfileOnboardingController controller,
    String key,
    AllergySeverity severity,
  ) {
    final current = draft.allergies[key];
    if (current == null) return;
    controller.setAllergy(current.copyWith(severity: severity));
  }

  void _toggleIntolerance(
    OnboardingDraftState draft,
    FoodProfileOnboardingController controller,
    CatalogEntry intolerance,
  ) {
    final key = 'i${intolerance.id}';
    if (draft.intolerances.containsKey(key)) {
      controller.removeIntolerance(key);
    } else {
      controller.setIntolerance(
        IntoleranceDraft(intoleranceId: intolerance.id),
      );
    }
  }

  /// Deterministically hides samples that conflict with confirmed
  /// allergens or strict ingredient exclusions already collected earlier
  /// in the flow — never shows a food the user just told us to avoid.
  List<FoodItemEntry> _visibleFoodItems(OnboardingDraftState draft) {
    final allergenIds = draft.allergies.values
        .map((a) => a.allergenId)
        .whereType<int>()
        .toSet();
    final excludedIngredientIds = draft.ingredientPreferences.entries
        .where((e) => e.value.$2 == RestrictionType.strictExclude)
        .map((e) => e.key)
        .toSet();
    return draft.foodItemCatalog.where((item) {
      if (item.allergenIds.any(allergenIds.contains)) return false;
      if (item.primaryIngredientIds.any(excludedIngredientIds.contains)) {
        return false;
      }
      return true;
    }).toList();
  }
}
