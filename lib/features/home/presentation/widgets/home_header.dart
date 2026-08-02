import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/miz_icon_button.dart';

/// Soft Orbit Home header: wordmark, location capsule, and profile.
class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.onOpenProfile, super.key});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lgPlus,
          AppSpacing.md,
          AppSpacing.lgPlus,
          AppSpacing.lg,
        ),
        child: Row(
          children: [
            Text('Miz', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceGlass,
                    borderRadius: BorderRadius.circular(AppRadii.full),
                    border: Border.all(color: colors.divider),
                    boxShadow: AppShadows.xs(colors.shadow),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.near_me_rounded,
                        size: 16,
                        color: colors.accentPressed,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          context.l10n.nearYou,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MizIconButton(
              icon: const Icon(Icons.person_rounded),
              onPressed: onOpenProfile,
              semanticLabel: context.l10n.profile,
              background: colors.surface,
              foreground: colors.text,
              bordered: true,
            ),
          ],
        ),
      ),
    );
  }
}
