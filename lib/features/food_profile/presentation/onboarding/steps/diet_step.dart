import 'package:flutter/material.dart';

import '../../../../../core/localization/localization.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../domain/food_profile_enums.dart';

const List<DietType> _kSelectableDietTypes = [
  DietType.vegan,
  DietType.vegetarian,
  DietType.pescatarian,
  DietType.flexitarian,
  DietType.omnivore,
  DietType.other,
  DietType.preferNotToSay,
];

class DietStep extends StatelessWidget {
  const DietStep({required this.value, required this.onChanged, super.key});

  final DietType value;
  final ValueChanged<DietType> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.dietStepTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final diet in _kSelectableDietTypes) ...[
          MizOptionTile(
            label: dietTypeLabel(l10n, diet),
            selected: value == diet,
            onTap: () => onChanged(diet),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

String dietTypeLabel(AppLocalizations l10n, DietType diet) => switch (diet) {
  DietType.vegan => l10n.dietVegan,
  DietType.vegetarian => l10n.dietVegetarian,
  DietType.pescatarian => l10n.dietPescatarian,
  DietType.flexitarian => l10n.dietFlexitarian,
  DietType.omnivore => l10n.dietOmnivore,
  DietType.other => l10n.dietOther,
  DietType.preferNotToSay => l10n.dietPreferNotToSay,
  DietType.unknown => l10n.dietOther,
};
