import 'package:flutter/material.dart';

import 'app_colors.dart';

enum MizGlassLevel { subtle, secondary, primary, elevated, modal, disabled }

@immutable
class MizGlassStyle {
  const MizGlassStyle({
    required this.blur,
    required this.surfaceOpacity,
    required this.borderOpacity,
    required this.highlightOpacity,
    required this.shadowOpacity,
    required this.shadowBlur,
  });

  final double blur;
  final double surfaceOpacity;
  final double borderOpacity;
  final double highlightOpacity;
  final double shadowOpacity;
  final double shadowBlur;
}

/// Spatial Glass material tokens. Feature widgets select a semantic level and
/// never provide one-off blur, opacity, border, or shadow values.
class AppGlass {
  const AppGlass._();

  static const double backgroundDimLight = 0.18;
  static const double backgroundDimDark = 0.42;
  static const double iconContrast = 0.94;
  static const double textContrast = 0.96;

  static const Map<MizGlassLevel, MizGlassStyle> _styles = {
    MizGlassLevel.subtle: MizGlassStyle(
      blur: 10,
      surfaceOpacity: 0.12,
      borderOpacity: 0.16,
      highlightOpacity: 0.10,
      shadowOpacity: 0.08,
      shadowBlur: 18,
    ),
    MizGlassLevel.secondary: MizGlassStyle(
      blur: 16,
      surfaceOpacity: 0.20,
      borderOpacity: 0.24,
      highlightOpacity: 0.16,
      shadowOpacity: 0.11,
      shadowBlur: 24,
    ),
    MizGlassLevel.primary: MizGlassStyle(
      blur: 22,
      surfaceOpacity: 0.29,
      borderOpacity: 0.34,
      highlightOpacity: 0.22,
      shadowOpacity: 0.16,
      shadowBlur: 32,
    ),
    MizGlassLevel.elevated: MizGlassStyle(
      blur: 22,
      surfaceOpacity: 0.36,
      borderOpacity: 0.42,
      highlightOpacity: 0.28,
      shadowOpacity: 0.20,
      shadowBlur: 38,
    ),
    MizGlassLevel.modal: MizGlassStyle(
      blur: 22,
      surfaceOpacity: 0.68,
      borderOpacity: 0.38,
      highlightOpacity: 0.22,
      shadowOpacity: 0.26,
      shadowBlur: 48,
    ),
    MizGlassLevel.disabled: MizGlassStyle(
      blur: 10,
      surfaceOpacity: 0.18,
      borderOpacity: 0.12,
      highlightOpacity: 0.06,
      shadowOpacity: 0.04,
      shadowBlur: 12,
    ),
  };

  static MizGlassStyle of(MizGlassLevel level) => _styles[level]!;

  static Color surfaceColor(
    AppColors colors,
    Brightness brightness,
    MizGlassStyle style,
  ) {
    final base = brightness == Brightness.dark
        ? colors.neutral900
        : colors.surface;
    return base.withValues(alpha: style.surfaceOpacity);
  }
}
