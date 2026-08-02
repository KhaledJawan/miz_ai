import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Quiet grouped-content separator.
class MizDivider extends StatelessWidget {
  const MizDivider({
    this.margin = const EdgeInsets.symmetric(vertical: AppSpacing.lg),
    super.key,
  });

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 1,
      color: context.mizColors.divider,
    );
  }
}
