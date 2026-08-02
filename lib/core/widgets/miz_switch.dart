import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_radii.dart';
import '../theme/app_theme.dart';

/// Soft Orbit toggle with a pill track and circular thumb.
class MizSwitch extends StatelessWidget {
  const MizSwitch({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Semantics(
      toggled: value,
      button: true,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 48,
          height: 44,
          child: Center(
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: AppMotion.enter,
              width: 44,
              height: 26,
              decoration: BoxDecoration(
                color: value ? colors.accent : colors.neutral400,
                borderRadius: BorderRadius.circular(AppRadii.full),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: AppMotion.fast,
                    curve: AppMotion.enter,
                    top: 3,
                    left: value ? 21 : 3,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors.shadow.withValues(alpha: 0.18),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
