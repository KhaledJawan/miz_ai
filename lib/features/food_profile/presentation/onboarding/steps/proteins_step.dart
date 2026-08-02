import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_motion.dart';
import '../../../../../core/theme/app_radii.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';
import '../../../domain/food_profile_enums.dart';

const List<String> _kCommonCategories = [
  'meat',
  'seafood',
  'plantProtein',
  'eggs',
  'dairy',
];

/// Only shows meat/seafood relevant to the current diet (see
/// [OnboardingDraftState.visibleProteinIngredients]) and, per the brief,
/// keeps unusual items under "More options" rather than showing them
/// prominently.
class ProteinsStep extends StatefulWidget {
  const ProteinsStep({
    required this.ingredients,
    required this.selections,
    required this.onChanged,
    super.key,
  });

  final List<IngredientEntry> ingredients;
  final Map<int, (PreferenceState, RestrictionType)> selections;
  final void Function(
    int ingredientId,
    PreferenceState state,
    RestrictionType restriction,
  )
  onChanged;

  @override
  State<ProteinsStep> createState() => _ProteinsStepState();
}

class _ProteinsStepState extends State<ProteinsStep> {
  var _showMore = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final common = widget.ingredients
        .where((i) => _kCommonCategories.contains(i.category))
        .toList();
    final more = widget.ingredients
        .where(
          (i) => !_kCommonCategories.contains(i.category) && i.parentId != null,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.proteinsStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final ingredient in common.where((i) => i.parentId != null)) ...[
          _ProteinRow(
            ingredient: ingredient,
            selection: widget.selections[ingredient.id],
            onChanged: widget.onChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (more.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => setState(() => _showMore = !_showMore),
            child: Text(
              _showMore ? l10n.showFewerOptions : l10n.showMoreOptions,
            ),
          ),
          if (_showMore)
            for (final ingredient in more) ...[
              _ProteinRow(
                ingredient: ingredient,
                selection: widget.selections[ingredient.id],
                onChanged: widget.onChanged,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ],
    );
  }
}

class _ProteinRow extends StatelessWidget {
  const _ProteinRow({
    required this.ingredient,
    required this.selection,
    required this.onChanged,
  });

  final IngredientEntry ingredient;
  final (PreferenceState, RestrictionType)? selection;
  final void Function(
    int ingredientId,
    PreferenceState state,
    RestrictionType restriction,
  )
  onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final current = selection?.$1;
    final restriction = selection?.$2 ?? RestrictionType.none;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.divider),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              catalogLabel(ingredient.code, languageCode),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          _ProteinActionIcon(
            icon: Icons.favorite_rounded,
            semanticLabel: l10n.eatAndLike,
            selected:
                current == PreferenceState.like &&
                restriction == RestrictionType.none,
            onTap: () => onChanged(
              ingredient.id,
              PreferenceState.like,
              RestrictionType.none,
            ),
          ),
          _ProteinActionIcon(
            icon: Icons.thumb_down_rounded,
            semanticLabel: l10n.dislikeIngredient,
            selected:
                current == PreferenceState.dislike &&
                restriction == RestrictionType.none,
            onTap: () => onChanged(
              ingredient.id,
              PreferenceState.dislike,
              RestrictionType.none,
            ),
          ),
          _ProteinActionIcon(
            icon: Icons.block_rounded,
            semanticLabel: l10n.neverEat,
            selected: restriction == RestrictionType.strictExclude,
            onTap: () => onChanged(
              ingredient.id,
              PreferenceState.dislike,
              RestrictionType.strictExclude,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProteinActionIcon extends StatelessWidget {
  const _ProteinActionIcon({
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
