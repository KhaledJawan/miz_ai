import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';
import '../../../domain/food_profile_enums.dart';
import '../onboarding_draft_state.dart';

class AllergiesStep extends StatefulWidget {
  const AllergiesStep({
    required this.catalog,
    required this.selections,
    required this.noKnownAllergies,
    required this.onToggle,
    required this.onSeverityChanged,
    required this.onAddCustom,
    required this.onNoKnownAllergiesChanged,
    super.key,
  });

  final List<CatalogEntry> catalog;
  final Map<String, AllergyDraft> selections;
  final bool noKnownAllergies;
  final void Function(CatalogEntry allergen) onToggle;
  final void Function(String key, AllergySeverity severity) onSeverityChanged;
  final void Function(String customName) onAddCustom;
  final ValueChanged<bool> onNoKnownAllergiesChanged;

  @override
  State<AllergiesStep> createState() => _AllergiesStepState();
}

class _AllergiesStepState extends State<AllergiesStep> {
  final _searchController = TextEditingController();
  final _customController = TextEditingController();
  var _search = '';

  @override
  void dispose() {
    _searchController.dispose();
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    final languageCode = Localizations.localeOf(context).languageCode;
    final filtered = widget.catalog.where(
      (a) => catalogLabel(
        a.code,
        languageCode,
      ).toLowerCase().contains(_search.toLowerCase()),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.allergiesStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        MizOptionTile(
          label: l10n.noKnownAllergies,
          selected: widget.noKnownAllergies,
          onTap: () =>
              widget.onNoKnownAllergiesChanged(!widget.noKnownAllergies),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (!widget.noKnownAllergies) ...[
          MizInput(
            controller: _searchController,
            placeholder: l10n.searchAllergens,
            onChanged: (value) => setState(() => _search = value),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final allergen in filtered) ...[
            _AllergenRow(
              label: catalogLabel(allergen.code, languageCode),
              draft: widget.selections['a${allergen.id}'],
              onToggle: () => widget.onToggle(allergen),
              onSeverityChanged: (severity) =>
                  widget.onSeverityChanged('a${allergen.id}', severity),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: MizInput(
                  controller: _customController,
                  placeholder: l10n.customAllergyHint,
                  onSubmitted: (_) => _submitCustom(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              MizIconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: _submitCustom,
                semanticLabel: l10n.addCustomAllergy,
                background: colors.accent,
                foreground: colors.onAccent,
              ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.allergySafetyNotice,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }

  void _submitCustom() {
    final value = _customController.text.trim();
    if (value.isEmpty) return;
    widget.onAddCustom(value);
    _customController.clear();
  }
}

class _AllergenRow extends StatelessWidget {
  const _AllergenRow({
    required this.label,
    required this.draft,
    required this.onToggle,
    required this.onSeverityChanged,
  });

  final String label;
  final AllergyDraft? draft;
  final VoidCallback onToggle;
  final ValueChanged<AllergySeverity> onSeverityChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = draft != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MizOptionTile(label: label, selected: selected, onTap: onToggle),
        if (selected) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.lg),
            child: Wrap(
              spacing: AppSpacing.xs,
              children: [
                for (final severity in AllergySeverity.values)
                  MizTag(
                    label: _severityLabel(l10n, severity),
                    variant: draft!.severity == severity
                        ? MizTagVariant.accent
                        : MizTagVariant.outline,
                    onTap: () => onSeverityChanged(severity),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _severityLabel(AppLocalizations l10n, AllergySeverity severity) =>
      switch (severity) {
        AllergySeverity.mild => l10n.severityMild,
        AllergySeverity.moderate => l10n.severityModerate,
        AllergySeverity.severe => l10n.severitySevere,
        AllergySeverity.unspecified => l10n.severityUnspecified,
      };
}
