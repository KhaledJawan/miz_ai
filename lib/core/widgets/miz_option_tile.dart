import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Large, tappable, vertically-listed selectable row — the food-profile
/// onboarding's answer to "large selectable cards, never tiny chips, never
/// horizontal-only scroll for safety-critical selections." Composed from
/// [MizCard]'s tokens, not a one-off style.
class MizOptionTile extends StatelessWidget {
  const MizOptionTile({
    required this.label,
    this.subtitle,
    this.leading,
    this.trailing,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final String label;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          child: AnimatedContainer(
            duration: AppMotion.fast,
            constraints: const BoxConstraints(minHeight: 60),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? colors.accent.withValues(alpha: 0.08)
                  : colors.surface,
              border: Border.all(
                color: selected ? colors.accent : colors.divider,
                width: selected ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: AppSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(label, style: Theme.of(context).textTheme.bodyLarge),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.textSecondary),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                trailing ?? _DefaultSelectionIndicator(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultSelectionIndicator extends StatelessWidget {
  const _DefaultSelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return AnimatedContainer(
      duration: AppMotion.fast,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? colors.accent : Colors.transparent,
        border: Border.all(
          color: selected ? colors.accent : colors.divider,
          width: 1.5,
        ),
      ),
      child: selected
          ? Icon(Icons.check_rounded, size: 16, color: colors.onAccent)
          : null,
    );
  }
}
