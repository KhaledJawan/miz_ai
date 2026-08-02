import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/miz_icon_button.dart';

/// Floating Soft Orbit composer. Voice/camera stay visible but disabled until
/// their milestones, preserving an honest and accessible future affordance.
class HomeInputBar extends StatelessWidget {
  const HomeInputBar({
    required this.controller,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lgPlus,
        AppSpacing.sm,
        AppSpacing.lgPlus,
        AppSpacing.md,
      ),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          final hasText = value.text.trim().isNotEmpty;
          return Container(
            constraints: const BoxConstraints(minHeight: 64),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceGlass,
              borderRadius: BorderRadius.circular(AppRadii.xl),
              border: Border.all(color: colors.divider),
              boxShadow: AppShadows.md(colors.shadow),
            ),
            child: Row(
              children: [
                MizIconButton(
                  icon: const Icon(Icons.add_rounded),
                  onPressed: null,
                  semanticLabel: context.l10n.addPhotoComingSoon,
                  background: colors.surfaceSoft,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) {
                      if (hasText) onSubmit(controller.text);
                    },
                    cursorColor: colors.accent,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: context.l10n.foodPrompt,
                      hintStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: colors.textTertiary),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.md,
                      ),
                    ),
                  ),
                ),
                MizIconButton(
                  icon: const Icon(Icons.mic_rounded),
                  onPressed: null,
                  semanticLabel: context.l10n.voiceComingSoon,
                  foreground: colors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xs),
                MizIconButton(
                  icon: const Icon(Icons.arrow_upward_rounded),
                  onPressed: hasText ? () => onSubmit(controller.text) : null,
                  semanticLabel: context.l10n.send,
                  background: hasText ? colors.accent : colors.neutral300,
                  foreground: hasText ? colors.onAccent : colors.textTertiary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
