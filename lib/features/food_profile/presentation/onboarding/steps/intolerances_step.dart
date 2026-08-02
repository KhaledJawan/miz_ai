import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';
import '../onboarding_draft_state.dart';

class IntolerancesStep extends StatelessWidget {
  const IntolerancesStep({
    required this.catalog,
    required this.selections,
    required this.noKnownIntolerances,
    required this.onToggle,
    required this.onNoKnownIntolerancesChanged,
    super.key,
  });

  final List<CatalogEntry> catalog;
  final Map<String, IntoleranceDraft> selections;
  final bool noKnownIntolerances;
  final void Function(CatalogEntry intolerance) onToggle;
  final ValueChanged<bool> onNoKnownIntolerancesChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.intolerancesStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.intolerancesStepHint,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: context.mizColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        MizOptionTile(
          label: l10n.noneOfTheAbove,
          selected: noKnownIntolerances,
          onTap: () => onNoKnownIntolerancesChanged(!noKnownIntolerances),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (!noKnownIntolerances)
          for (final intolerance in catalog) ...[
            MizOptionTile(
              label: catalogLabel(intolerance.code, languageCode),
              selected: selections.containsKey('i${intolerance.id}'),
              onTap: () => onToggle(intolerance),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}
