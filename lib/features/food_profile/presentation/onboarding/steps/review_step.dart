import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_radii.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/food_profile_enums.dart';
import '../onboarding_draft_state.dart';

/// Read-only summary of every prior screen with a per-section "Edit"
/// action that jumps straight back to that screen (see
/// `FoodProfileOnboardingController.goToScreen`) rather than forcing a
/// full re-walk of the flow.
class ReviewStep extends StatelessWidget {
  const ReviewStep({
    required this.draft,
    required this.onEditSection,
    super.key,
  });

  final OnboardingDraftState draft;
  final void Function(OnboardingScreen screen) onEditSection;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.reviewStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        _ReviewSection(
          title: l10n.dietStepTitle,
          value: _dietSummary(l10n),
          onEdit: () => onEditSection(OnboardingScreen.diet),
        ),
        _ReviewSection(
          title: l10n.foodRulesStepTitle,
          value: _countSummary(l10n, draft.foodRules.length),
          onEdit: () => onEditSection(OnboardingScreen.foodRules),
        ),
        _ReviewSection(
          title: l10n.allergiesStepTitle,
          value: draft.noKnownAllergies
              ? l10n.noKnownAllergies
              : _countSummary(l10n, draft.allergies.length),
          onEdit: () => onEditSection(OnboardingScreen.allergies),
        ),
        _ReviewSection(
          title: l10n.intolerancesStepTitle,
          value: draft.noKnownIntolerances
              ? l10n.noneOfTheAbove
              : _countSummary(l10n, draft.intolerances.length),
          onEdit: () => onEditSection(OnboardingScreen.intolerances),
        ),
        _ReviewSection(
          title: l10n.proteinsStepTitle,
          value: _countSummary(l10n, draft.ingredientPreferences.length),
          onEdit: () => onEditSection(OnboardingScreen.proteins),
        ),
        _ReviewSection(
          title: l10n.cuisinesStepTitle,
          value: _countSummary(l10n, draft.cuisinePreferences.length),
          onEdit: () => onEditSection(OnboardingScreen.cuisines),
        ),
        _ReviewSection(
          title: l10n.flavorsStepTitle,
          value: _countSummary(l10n, draft.flavorPreferences.length),
          onEdit: () => onEditSection(OnboardingScreen.flavors),
        ),
        _ReviewSection(
          title: l10n.eatingStyleStepTitle,
          value:
              draft.adventurousnessLevel != null ||
                  draft.preferredMealWeight != null
              ? l10n.reviewAnswered
              : l10n.reviewNotAnswered,
          onEdit: () => onEditSection(OnboardingScreen.eatingStyle),
        ),
        _ReviewSection(
          title: l10n.foodSamplesStepTitle,
          value: _countSummary(l10n, draft.foodItemPreferences.length),
          onEdit: () => onEditSection(OnboardingScreen.foodSamples),
        ),
      ],
    );
  }

  String _dietSummary(AppLocalizations l10n) =>
      draft.dietType == DietType.unknown
      ? l10n.reviewNotAnswered
      : catalogLabel(draft.dietType.name, 'en');

  String _countSummary(AppLocalizations l10n, int count) =>
      count == 0 ? l10n.reviewNotAnswered : l10n.reviewSelectedCount(count);
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.title,
    required this.value,
    required this.onEdit,
  });

  final String title;
  final String value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.divider),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          TextButton(onPressed: onEdit, child: Text(l10n.reviewEdit)),
        ],
      ),
    );
  }
}
