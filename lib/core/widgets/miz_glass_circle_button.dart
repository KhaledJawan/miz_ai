import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_glass.dart';
import '../theme/app_motion.dart';
import '../theme/app_theme.dart';
import 'miz_glass_surface.dart';

class MizGlassCircleButton extends StatefulWidget {
  const MizGlassCircleButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.size = 64,
    this.level = MizGlassLevel.elevated,
    this.isActive = false,
    this.prominent = false,
    super.key,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final double size;
  final MizGlassLevel level;
  final bool isActive;
  final bool prominent;

  @override
  State<MizGlassCircleButton> createState() => _MizGlassCircleButtonState();
}

class _MizGlassCircleButtonState extends State<MizGlassCircleButton> {
  bool _pressed = false;
  bool _focused = false;

  void _activate() {
    if (widget.onPressed == null) return;
    HapticFeedback.selectionClick();
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final iconColor = widget.prominent && widget.onPressed != null
        ? Colors.black
        : widget.onPressed == null
        ? colors.textTertiary
        : widget.isActive
        ? colors.accent
        : colors.text;

    return Semantics(
      button: true,
      enabled: widget.onPressed != null,
      label: widget.semanticLabel,
      child: Tooltip(
        message: widget.semanticLabel,
        triggerMode: TooltipTriggerMode.longPress,
        child: FocusableActionDetector(
          enabled: widget.onPressed != null,
          onShowFocusHighlight: (value) => setState(() => _focused = value),
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                _activate();
                return null;
              },
            ),
          },
          child: AnimatedScale(
            duration: reduceMotion ? Duration.zero : AppMotion.instant,
            scale: _pressed ? 0.96 : 1,
            child: Listener(
              onPointerDown: widget.onPressed == null
                  ? null
                  : (_) => setState(() => _pressed = true),
              onPointerUp: widget.onPressed == null
                  ? null
                  : (_) => setState(() => _pressed = false),
              onPointerCancel: widget.onPressed == null
                  ? null
                  : (_) => setState(() => _pressed = false),
              child: SizedBox.square(
                dimension: widget.size,
                child: MizGlassSurface(
                  level: widget.onPressed == null
                      ? MizGlassLevel.disabled
                      : widget.level,
                  prominent: widget.prominent,
                  borderRadius: widget.size / 2,
                  onTap: widget.onPressed == null ? null : _activate,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: _focused
                          ? Border.all(color: colors.accent, width: 2)
                          : null,
                    ),
                    child: Icon(widget.icon, color: iconColor, size: 25),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
