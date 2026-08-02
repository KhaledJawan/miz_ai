import 'package:flutter/material.dart';

import '../theme/app_radii.dart';
import '../theme/app_theme.dart';

/// Circular icon action with a minimum 44×44 target and visible disabled state.
class MizIconButton extends StatelessWidget {
  const MizIconButton({
    required this.icon,
    required this.onPressed,
    this.semanticLabel,
    this.bordered = false,
    this.background,
    this.foreground,
    this.size = 44,
    super.key,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final bool bordered;
  final Color? background;
  final Color? foreground;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final disabled = onPressed == null;

    return Semantics(
      button: true,
      label: semanticLabel,
      enabled: !disabled,
      child: Opacity(
        opacity: disabled ? 0.35 : 1,
        child: Material(
          color: background ?? Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return (foreground ?? colors.text).withValues(alpha: 0.14);
              }
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused)) {
                return (foreground ?? colors.text).withValues(alpha: 0.08);
              }
              return null;
            }),
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.full),
                border: bordered ? Border.all(color: colors.divider) : null,
              ),
              child: IconTheme(
                data: IconThemeData(
                  color: foreground ?? colors.text,
                  size: size * 0.5,
                ),
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
