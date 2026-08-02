import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../domain/catalog_localizations.dart';
import '../../../domain/entities.dart';
import '../../../domain/food_profile_enums.dart';

const List<PreferenceState> _kCuisineCycle = [
  PreferenceState.love,
  PreferenceState.like,
  PreferenceState.curious,
  PreferenceState.dislike,
];

class CuisinesStep extends StatefulWidget {
  const CuisinesStep({
    required this.catalog,
    required this.selections,
    required this.onChanged,
    super.key,
  });

  final List<CatalogEntry> catalog;
  final Map<int, PreferenceState> selections;
  final void Function(int cuisineId, PreferenceState value) onChanged;

  @override
  State<CuisinesStep> createState() => _CuisinesStepState();
}

class _CuisinesStepState extends State<CuisinesStep> {
  final _searchController = TextEditingController();
  var _search = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final filtered = widget.catalog.where(
      (c) => catalogLabel(
        c.code,
        languageCode,
      ).toLowerCase().contains(_search.toLowerCase()),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.cuisinesStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        MizInput(
          controller: _searchController,
          placeholder: l10n.searchCuisines,
          onChanged: (value) => setState(() => _search = value),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final cuisine in filtered) ...[
          MizOptionTile(
            label: catalogLabel(cuisine.code, languageCode),
            selected: widget.selections.containsKey(cuisine.id),
            trailing: widget.selections.containsKey(cuisine.id)
                ? MizTag(
                    label: _stateLabel(l10n, widget.selections[cuisine.id]!),
                    variant: MizTagVariant.accent,
                  )
                : null,
            onTap: () => _cycle(cuisine.id),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }

  void _cycle(int cuisineId) {
    final current = widget.selections[cuisineId];
    if (current == null) {
      widget.onChanged(cuisineId, _kCuisineCycle.first);
      return;
    }
    final index = _kCuisineCycle.indexOf(current);
    if (index == -1 || index == _kCuisineCycle.length - 1) {
      widget.onChanged(cuisineId, PreferenceState.unknown);
    } else {
      widget.onChanged(cuisineId, _kCuisineCycle[index + 1]);
    }
  }

  String _stateLabel(AppLocalizations l10n, PreferenceState state) =>
      switch (state) {
        PreferenceState.love => l10n.preferenceLove,
        PreferenceState.like => l10n.preferenceLike,
        PreferenceState.curious => l10n.preferenceCurious,
        PreferenceState.dislike => l10n.preferenceNotInterested,
        _ => '',
      };
}
