import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';

class OffersBanner extends StatelessWidget {
  const OffersBanner({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final radius = BorderRadius.circular(AppRadii.xl);
    return Semantics(
      button: true,
      label: context.l10n.openTodayOffers,
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            padding: const EdgeInsets.all(AppSpacing.lgPlus),
            decoration: BoxDecoration(
              color: colors.accent,
              borderRadius: radius,
              boxShadow: AppShadows.sm(colors.shadow),
            ),
            child: Row(
              children: [
                Container(
                  width: AppSpacing.xxxl,
                  height: AppSpacing.xxxl,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.celebration_rounded,
                    color: colors.accentPressed,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.todayOffers,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: colors.onAccent),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        context.l10n.offerDescription,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onAccent.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AppSpacing.xxlPlus,
                  height: AppSpacing.xxlPlus,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: colors.accentPressed,
                    size: 19,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
