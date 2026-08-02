import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';
import '../../../domain/food_profile_enums.dart';

/// Cycles a food rule through none → preferred → required → none on tap,
/// enforcing the brief's "no contradictory options selected together"
/// rule (e.g. `halalRequired` and `halalPreferred`) by clearing the
/// opposite member of a contradictory pair.
class FoodRulesStep extends StatelessWidget {
  const FoodRulesStep({
    required this.catalog,
    required this.selections,
    required this.onChanged,
    super.key,
  });

  final List<CatalogEntry> catalog;
  final Map<int, RequirementLevel> selections;
  final void Function(int foodRuleId, RequirementLevel? level) onChanged;

  static const _contradictoryCodes = {'halalRequired', 'halalPreferred'};

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
          l10n.foodRulesStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.foodRulesStepHint,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final rule in catalog) ...[
          MizOptionTile(
            label: catalogLabel(rule.code, languageCode),
            subtitle: _levelLabel(l10n, selections[rule.id]),
            selected: selections.containsKey(rule.id),
            trailing: selections.containsKey(rule.id)
                ? MizTag(
                    label: _levelShortLabel(l10n, selections[rule.id]!),
                    variant: MizTagVariant.accent,
                  )
                : null,
            onTap: () => _cycle(rule),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }

  void _cycle(CatalogEntry rule) {
    final current = selections[rule.id];
    switch (current) {
      case null:
        if (_contradictoryCodes.contains(rule.code)) {
          _clearContradictory(rule.code);
        }
        onChanged(rule.id, RequirementLevel.preferred);
      case RequirementLevel.preferred:
        onChanged(rule.id, RequirementLevel.required);
      default:
        onChanged(rule.id, null);
    }
  }

  void _clearContradictory(String code) {
    final other = catalog.where(
      (r) => _contradictoryCodes.contains(r.code) && r.code != code,
    );
    for (final r in other) {
      if (selections.containsKey(r.id)) onChanged(r.id, null);
    }
  }

  String? _levelLabel(AppLocalizations l10n, RequirementLevel? level) =>
      switch (level) {
        RequirementLevel.required => l10n.requirementRequired,
        RequirementLevel.preferred => l10n.requirementPreferred,
        RequirementLevel.avoid => l10n.requirementAvoid,
        _ => null,
      };

  String _levelShortLabel(AppLocalizations l10n, RequirementLevel level) =>
      _levelLabel(l10n, level) ?? '';
}
