import 'package:flutter/material.dart';

import '../theme/app_glass.dart';
import '../theme/app_motion.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'miz_glass_surface.dart';

class MizGlassInput extends StatelessWidget {
  const MizGlassInput({
    required this.controller,
    required this.focusNode,
    required this.semanticLabel,
    required this.sendLabel,
    required this.onChanged,
    required this.onSend,
    this.placeholder,
    this.maxLines = 4,
    this.prominent = false,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String semanticLabel;
  final String sendLabel;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSend;
  final Widget? placeholder;
  final int maxLines;
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final enabled = onSend != null;
    final direction = Directionality.of(context);

    return MizGlassSurface(
      level: MizGlassLevel.primary,
      prominent: prominent,
      borderRadius: AppRadii.xl,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lgPlus,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 52),
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  if (placeholder != null)
                    PositionedDirectional(
                      start: 0,
                      end: 0,
                      top: AppSpacing.md,
                      child: placeholder!,
                    ),
                  Semantics(
                    textField: true,
                    label: semanticLabel,
                    child: TextField(
                      key: const ValueKey('spatial-ai-input'),
                      controller: controller,
                      focusNode: focusNode,
                      textDirection: direction,
                      minLines: 1,
                      maxLines: maxLines,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      onChanged: onChanged,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: prominent ? Colors.black : colors.text,
                        height: 1.35,
                      ),
                      decoration: const InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Semantics(
            button: true,
            enabled: enabled,
            label: sendLabel,
            child: Tooltip(
              message: sendLabel,
              child: AnimatedContainer(
                duration: AppMotion.fast,
                curve: AppMotion.enter,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: enabled ? colors.accent : colors.surfaceSoft,
                  border: prominent
                      ? null
                      : Border.all(
                          color: enabled ? colors.accent : colors.divider,
                        ),
                  boxShadow: prominent
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: enabled ? 0.18 : 0.08,
                            ),
                            blurRadius: 12,
                            spreadRadius: -3,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: IconButton(
                  key: const ValueKey('spatial-send-button'),
                  onPressed: onSend,
                  icon: Icon(
                    direction == TextDirection.rtl
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_forward_rounded,
                  ),
                  color: enabled ? colors.onAccent : colors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
