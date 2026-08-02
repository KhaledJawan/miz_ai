import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../domain/food_profile_enums.dart';

/// Four sub-questions per the brief: openness to new food, top-3-ranked
/// priorities, meal weight preference, and an optional budget. Budget is
/// the only one of the four allowed to remain unanswered without blocking
/// completeness (see [ProfileCompletenessService] — eating style as a
/// whole is one weighted section, not four).
class EatingStyleStep extends StatelessWidget {
  const EatingStyleStep({
    required this.adventurousnessLevel,
    required this.preferredMealWeight,
    required this.budgetLevel,
    required this.topPriorities,
    required this.onAdventurousnessChanged,
    required this.onMealWeightChanged,
    required this.onBudgetChanged,
    required this.onPriorityToggled,
    super.key,
  });

  final AdventurousnessLevel? adventurousnessLevel;
  final MealWeightPreference? preferredMealWeight;
  final BudgetLevel? budgetLevel;
  final List<EatingPriority> topPriorities;
  final ValueChanged<AdventurousnessLevel> onAdventurousnessChanged;
  final ValueChanged<MealWeightPreference> onMealWeightChanged;
  final ValueChanged<BudgetLevel> onBudgetChanged;
  final ValueChanged<EatingPriority> onPriorityToggled;

  static const _kMaxPriorities = 3;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.eatingStyleStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.adventurousnessQuestion,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final level in AdventurousnessLevel.values) ...[
          MizOptionTile(
            label: _adventurousnessLabel(l10n, level),
            selected: adventurousnessLevel == level,
            onTap: () => onAdventurousnessChanged(level),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.topPrioritiesQuestion,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.topPrioritiesHint,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final priority in EatingPriority.values)
              MizTag(
                label: _priorityLabel(l10n, priority),
                variant: topPriorities.contains(priority)
                    ? MizTagVariant.accent
                    : MizTagVariant.outline,
                onTap:
                    topPriorities.contains(priority) ||
                        topPriorities.length < _kMaxPriorities
                    ? () => onPriorityToggled(priority)
                    : null,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.mealWeightQuestion,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final weight in MealWeightPreference.values) ...[
          MizOptionTile(
            label: _mealWeightLabel(l10n, weight),
            selected: preferredMealWeight == weight,
            onTap: () => onMealWeightChanged(weight),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.budgetQuestion,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.budgetOptionalHint,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final budget in BudgetLevel.values)
              MizTag(
                label: _budgetLabel(l10n, budget),
                variant: budgetLevel == budget
                    ? MizTagVariant.accent
                    : MizTagVariant.outline,
                onTap: () => onBudgetChanged(budget),
              ),
          ],
        ),
      ],
    );
  }

  String _adventurousnessLabel(
    AppLocalizations l10n,
    AdventurousnessLevel level,
  ) => switch (level) {
    AdventurousnessLevel.almostNever => l10n.adventurousnessAlmostNever,
    AdventurousnessLevel.sometimes => l10n.adventurousnessSometimes,
    AdventurousnessLevel.often => l10n.adventurousnessOften,
    AdventurousnessLevel.almostAlways => l10n.adventurousnessAlmostAlways,
  };

  String _mealWeightLabel(AppLocalizations l10n, MealWeightPreference weight) =>
      switch (weight) {
        MealWeightPreference.light => l10n.mealWeightLight,
        MealWeightPreference.balanced => l10n.mealWeightBalanced,
        MealWeightPreference.filling => l10n.mealWeightFilling,
        MealWeightPreference.dependsOnSituation => l10n.mealWeightDepends,
      };

  String _budgetLabel(AppLocalizations l10n, BudgetLevel budget) =>
      switch (budget) {
        BudgetLevel.low => l10n.budgetLow,
        BudgetLevel.medium => l10n.budgetMedium,
        BudgetLevel.high => l10n.budgetHigh,
        BudgetLevel.noPreference => l10n.budgetNoPreference,
      };

  String _priorityLabel(AppLocalizations l10n, EatingPriority priority) =>
      switch (priority) {
        EatingPriority.taste => l10n.priorityTaste,
        EatingPriority.price => l10n.priorityPrice,
        EatingPriority.health => l10n.priorityHealth,
        EatingPriority.portionSize => l10n.priorityPortionSize,
        EatingPriority.ingredients => l10n.priorityIngredients,
        EatingPriority.appearance => l10n.priorityAppearance,
        EatingPriority.preparationTime => l10n.priorityPreparationTime,
        EatingPriority.popularity => l10n.priorityPopularity,
        EatingPriority.familiarity => l10n.priorityFamiliarity,
        EatingPriority.somethingNew => l10n.prioritySomethingNew,
      };
}
