import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/miz_tag.dart';

class ChipRowItem {
  const ChipRowItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
}

/// Horizontal scrollable chip row — reused for Home's quick chips and
/// context chips (docs/DESIGN.md §4/§5).
class ChipRow extends StatelessWidget {
  const ChipRow({
    required this.items,
    this.variant = MizTagVariant.outline,
    super.key,
  });

  final List<ChipRowItem> items;
  final MizTagVariant variant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final item in items) ...[
            MizTag(label: item.label, variant: variant, onTap: item.onTap),
            const SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}
