import 'package:flutter/animation.dart';

/// Spatial Glass motion tokens. Reduced-motion handling lives at the animation
/// call site because it depends on the active [MediaQuery].
class AppMotion {
  const AppMotion._();

  static const instant = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 180);
  static const standard = Duration(milliseconds: 280);
  static const slow = Duration(milliseconds: 420);
  static const ambient = Duration(milliseconds: 1600);

  static const enter = Curves.easeOutCubic;
  static const rearrange = Curves.easeInOutCubic;
}
