import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Monochrome page canvas with one restrained red ambient highlight.
class MizBackdrop extends StatelessWidget {
  const MizBackdrop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return DecoratedBox(
      decoration: BoxDecoration(color: colors.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.95, -0.95),
                  radius: 1.05,
                  colors: [
                    colors.accent.withValues(alpha: 0.12),
                    colors.background.withValues(alpha: 0),
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
