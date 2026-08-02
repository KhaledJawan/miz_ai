import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../localization/localization.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

enum MizOrbState { resting, thinking, listening, success }

/// Black, white, and Miz-red brand mark for onboarding and AI states.
class MizOrb extends StatelessWidget {
  const MizOrb({this.size = 152, this.state = MizOrbState.resting, super.key});

  final double size;
  final MizOrbState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final duration = reduceMotion ? Duration.zero : AppMotion.slow;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),
      duration: duration,
      curve: AppMotion.enter,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Semantics(
        image: true,
        label: switch (state) {
          MizOrbState.resting => context.l10n.appTitle,
          MizOrbState.thinking => context.l10n.mizThinking,
          MizOrbState.listening => context.l10n.mizListening,
          MizOrbState.success => context.l10n.mizTaskComplete,
        },
        child: SizedBox.square(
          dimension: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size * 0.82,
                height: size * 0.82,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.text,
                  boxShadow: AppShadows.lg(colors.shadow),
                ),
              ),
              Container(
                width: size * 0.58,
                height: size * 0.58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.accent,
                  border: Border.all(color: colors.background, width: 2),
                ),
              ),
              Container(
                width: size * 0.24,
                height: size * 0.24,
                decoration: BoxDecoration(
                  color: colors.surface,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
