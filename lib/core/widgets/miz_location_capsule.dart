import 'package:flutter/material.dart';

import '../theme/app_glass.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'miz_glass_surface.dart';

class MizLocationCapsule extends StatelessWidget {
  const MizLocationCapsule({
    required this.label,
    required this.semanticLabel,
    required this.onTap,
    this.isSelected = false,
    this.prominent = false,
    super.key,
  });

  final String label;
  final String semanticLabel;
  final VoidCallback onTap;
  final bool isSelected;
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: MizGlassSurface(
        level: MizGlassLevel.elevated,
        prominent: prominent,
        borderRadius: AppRadii.full,
        onTap: onTap,
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected
                  ? Icons.location_on_rounded
                  : Icons.location_searching_rounded,
              size: 16,
              color: isSelected
                  ? colors.accent
                  : prominent
                  ? Colors.black54
                  : colors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: prominent ? Colors.black : null,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: prominent ? Colors.black54 : colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
