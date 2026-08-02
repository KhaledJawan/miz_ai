import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_motion.dart';
import '../../../../../core/theme/app_radii.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';
import '../../../domain/food_profile_enums.dart';

/// Locally-bundled sample food photos, already pre-filtered by the
/// controller to exclude anything conflicting with the user's allergies
/// or strict exclusions (see `FoodProfileOnboardingController`). Offers
/// Like/Curious/Never tried/Dislike — "Never show" lives permanently in
/// the Food Profile settings "Hidden foods" section instead, fed by real
/// hide interactions rather than a one-off onboarding tap.
class FoodSamplesStep extends StatelessWidget {
  const FoodSamplesStep({
    required this.items,
    required this.cuisineCatalog,
    required this.selections,
    required this.onChanged,
    super.key,
  });

  final List<FoodItemEntry> items;
  final List<CatalogEntry> cuisineCatalog;
  final Map<int, PreferenceState> selections;
  final void Function(int foodItemId, PreferenceState state) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.foodSamplesStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.foodSamplesStepHint,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final item in items) ...[
          _FoodSampleCard(
            item: item,
            cuisineLabel: _cuisineLabel(item.cuisineId, languageCode),
            state: selections[item.id],
            onChanged: (state) => onChanged(item.id, state),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }

  String? _cuisineLabel(int? cuisineId, String languageCode) {
    if (cuisineId == null) return null;
    final match = cuisineCatalog.where((c) => c.id == cuisineId);
    if (match.isEmpty) return null;
    return catalogLabel(match.first.code, languageCode);
  }
}

class _FoodSampleCard extends StatelessWidget {
  const _FoodSampleCard({
    required this.item,
    required this.cuisineLabel,
    required this.state,
    required this.onChanged,
  });

  final FoodItemEntry item;
  final String? cuisineLabel;
  final PreferenceState? state;
  final ValueChanged<PreferenceState> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.divider),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: item.imageAsset != null
                ? Image.asset(item.imageAsset!, fit: BoxFit.cover)
                : ColoredBox(color: colors.surfaceSoft),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  catalogLabel(item.code, languageCode),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (cuisineLabel != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    cuisineLabel!,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _SampleActionIcon(
                      icon: Icons.favorite_rounded,
                      semanticLabel: l10n.foodSampleLike,
                      selected: state == PreferenceState.like,
                      onTap: () => onChanged(PreferenceState.like),
                    ),
                    _SampleActionIcon(
                      icon: Icons.explore_rounded,
                      semanticLabel: l10n.foodSampleCurious,
                      selected: state == PreferenceState.curious,
                      onTap: () => onChanged(PreferenceState.curious),
                    ),
                    _SampleActionIcon(
                      icon: Icons.help_outline_rounded,
                      semanticLabel: l10n.foodSampleNeverTried,
                      selected: state == PreferenceState.neverTried,
                      onTap: () => onChanged(PreferenceState.neverTried),
                    ),
                    _SampleActionIcon(
                      icon: Icons.thumb_down_rounded,
                      semanticLabel: l10n.foodSampleDislike,
                      selected: state == PreferenceState.dislike,
                      onTap: () => onChanged(PreferenceState.dislike),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SampleActionIcon extends StatelessWidget {
  const _SampleActionIcon({
    required this.icon,
    required this.semanticLabel,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String semanticLabel;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.full),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          width: 40,
          height: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: AppSpacing.xs),
          decoration: BoxDecoration(
            color: selected
                ? colors.accent.withValues(alpha: 0.12)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: selected ? colors.accent : colors.textTertiary,
          ),
        ),
      ),
    );
  }
}
