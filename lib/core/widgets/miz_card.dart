import 'package:flutter/material.dart';

import '../theme/app_radii.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

enum MizElevation { none, sm, md, lg }

/// Rounded Soft Orbit content surface.
class MizCard extends StatelessWidget {
  const MizCard({
    required this.child,
    this.elevation = MizElevation.none,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
    super.key,
  });

  final Widget child;
  final MizElevation elevation;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final shadow = switch (elevation) {
      MizElevation.none => null,
      MizElevation.sm => AppShadows.sm(colors.shadow),
      MizElevation.md => AppShadows.md(colors.shadow),
      MizElevation.lg => AppShadows.lg(colors.shadow),
    };

    final radius = BorderRadius.circular(AppRadii.lg);
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.divider),
        borderRadius: radius,
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return colors.text.withValues(alpha: 0.08);
          }
          return null;
        }),
        child: card,
      ),
    );
  }
}
