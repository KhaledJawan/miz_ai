import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_radii.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';

/// Every flavor attribute uses the same 0-4 intensity scale (absence in
/// [selections] means "not answered"). `spicy` gets dedicated labels per
/// the brief ("Not spicy/Mild/Medium/Hot/Very hot"); the rest share a
/// generic low-to-high scale.
const _kSpicyCode = 'spicy';

class FlavorsStep extends StatelessWidget {
  const FlavorsStep({
    required this.catalog,
    required this.selections,
    required this.onChanged,
    super.key,
  });

  final List<CatalogEntry> catalog;
  final Map<int, int> selections;
  final void Function(int flavorId, int level) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.flavorsStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final flavor in catalog) ...[
          _FlavorRow(
            label: catalogLabel(flavor.code, languageCode),
            level: selections[flavor.id] ?? 0,
            isSpicy: flavor.code == _kSpicyCode,
            onChanged: (level) => onChanged(flavor.id, level),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ],
    );
  }
}

class _FlavorRow extends StatelessWidget {
  const _FlavorRow({
    required this.label,
    required this.level,
    required this.isSpicy,
    required this.onChanged,
  });

  final String label;
  final int level;
  final bool isSpicy;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final l10n = context.l10n;
    final labels = isSpicy
        ? [
            l10n.spiceNotSpicy,
            l10n.spiceMild,
            l10n.spiceMedium,
            l10n.spiceHot,
            l10n.spiceVeryHot,
          ]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            for (var i = 0; i < 5; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.xs),
                  child: GestureDetector(
                    onTap: () => onChanged(i),
                    child: Semantics(
                      button: true,
                      selected: level == i,
                      label: labels?[i] ?? '$label ${i + 1}/5',
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: level >= i
                              ? colors.accent
                              : colors.surfaceSoft,
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (labels != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            labels[level],
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: colors.textSecondary),
          ),
        ],
      ],
    );
  }
}
