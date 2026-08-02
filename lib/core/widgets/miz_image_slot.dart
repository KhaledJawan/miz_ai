import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../localization/localization.dart';

/// Full-color restaurant media with a warm designed fallback. Local mock
/// assets are replaced by remote cached photos when the live repository ships.
class MizImageSlot extends StatelessWidget {
  const MizImageSlot({required this.label, this.imageAsset, super.key});

  final String label;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    if (imageAsset case final asset?) {
      return Semantics(
        image: true,
        label: context.l10n.restaurantPhoto(label),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
          errorBuilder: (_, _, _) => _ImageFallback(label: label),
        ),
      );
    }
    return _ImageFallback(label: label);
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Semantics(
      image: true,
      label: context.l10n.restaurantImagePlaceholder(label),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [colors.neutral200, colors.accent100, colors.surfaceSoft],
          ),
        ),
        child: Center(
          child: Container(
            width: AppSpacing.xxxl,
            height: AppSpacing.xxxl,
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: 0.72),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.restaurant_rounded, color: colors.textSecondary),
          ),
        ),
      ),
    );
  }
}
