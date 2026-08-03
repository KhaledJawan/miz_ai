import 'package:flutter/material.dart';

import '../theme/app_glass.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'miz_glass_surface.dart';

class MizSpatialSheet extends StatelessWidget {
  const MizSpatialSheet({required this.child, super.key});

  final Widget child;

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: context.mizColors.shadow.withValues(alpha: 0.46),
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MizGlassSurface(
      level: MizGlassLevel.modal,
      prominent: true,
      borderRadius: AppRadii.xl,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lgPlus,
        AppSpacing.md,
        AppSpacing.lgPlus,
        AppSpacing.xxl,
      ),
      child: child,
    );
  }
}
