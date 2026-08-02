import 'package:flutter/material.dart';

import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

enum MizTagVariant { accent, accent2, neutral, outline }

/// Capsule tag used for filters, quick choices, and Summary Chips.
class MizTag extends StatelessWidget {
  const MizTag({
    required this.label,
    this.variant = MizTagVariant.neutral,
    this.onTap,
    this.trailing,
    super.key,
  });

  final String label;
  final MizTagVariant variant;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final (
      Color background,
      Color foreground,
      BoxBorder? border,
    ) = switch (variant) {
      MizTagVariant.accent => (colors.accent100, colors.accent800, null),
      MizTagVariant.accent2 => (colors.accent2_100, colors.accent2_800, null),
      MizTagVariant.neutral => (colors.neutral100, colors.neutral800, null),
      MizTagVariant.outline => (
        colors.surface,
        colors.text,
        Border.all(color: colors.divider),
      ),
    };

    final tag = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        border: border,
        borderRadius: BorderRadius.circular(AppRadii.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: foreground),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.xs),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap == null) return tag;
    return Semantics(
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.full),
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed)) {
              return foreground.withValues(alpha: 0.12);
            }
            return null;
          }),
          child: tag,
        ),
      ),
    );
  }
}
