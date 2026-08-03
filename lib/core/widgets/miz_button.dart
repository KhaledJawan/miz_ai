import 'package:flutter/material.dart';

import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

enum MizButtonVariant { primary, secondary, ghost }

/// Soft Orbit pill button with tokenized primary, secondary, and ghost states.
class MizButton extends StatelessWidget {
  const MizButton({
    required this.label,
    required this.onPressed,
    this.variant = MizButtonVariant.primary,
    this.expand = false,
    this.leading,
    super.key,
  });

  const MizButton.primary({
    required String label,
    required VoidCallback? onPressed,
    bool expand = false,
    Widget? leading,
    Key? key,
  }) : this(
         label: label,
         onPressed: onPressed,
         expand: expand,
         leading: leading,
         key: key,
       );

  const MizButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    bool expand = false,
    Widget? leading,
    Key? key,
  }) : this(
         label: label,
         onPressed: onPressed,
         variant: MizButtonVariant.secondary,
         expand: expand,
         leading: leading,
         key: key,
       );

  const MizButton.ghost({
    required String label,
    required VoidCallback? onPressed,
    bool expand = false,
    Widget? leading,
    Key? key,
  }) : this(
         label: label,
         onPressed: onPressed,
         variant: MizButtonVariant.ghost,
         expand: expand,
         leading: leading,
         key: key,
       );

  final String label;
  final VoidCallback? onPressed;
  final MizButtonVariant variant;
  final bool expand;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final disabled = onPressed == null;

    final (
      Color background,
      Color foreground,
      BoxBorder? border,
    ) = switch (variant) {
      MizButtonVariant.primary => (colors.accent, colors.onAccent, null),
      MizButtonVariant.secondary => (Colors.white, Colors.black, null),
      MizButtonVariant.ghost => (Colors.transparent, colors.accent, null),
    };

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: AppSpacing.sm - 2),
        ],
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: disabled ? foreground.withValues(alpha: 0.45) : foreground,
          ),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: !disabled,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.full),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadii.full),
          onTap: onPressed,
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed)) {
              return foreground.withValues(alpha: 0.12);
            }
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return foreground.withValues(alpha: 0.06);
            }
            return null;
          }),
          child: Container(
            width: expand ? double.infinity : null,
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.circular(AppRadii.full),
              boxShadow: variant == MizButtonVariant.secondary
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 18,
                        spreadRadius: -4,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : null,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
