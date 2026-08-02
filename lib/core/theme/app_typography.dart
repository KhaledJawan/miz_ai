import 'package:flutter/material.dart';

/// Archivo Soft Orbit type scale. Archivo is bundled locally so the visual
/// identity remains available offline (ADR-008).
class AppTypography {
  const AppTypography._();

  static const _fontFamily = 'Archivo';

  static TextTheme textTheme(Color textColor) {
    TextStyle heading(double size, double height) => TextStyle(
      fontFamily: _fontFamily,
      fontFamilyFallback: const ['Noto Sans Arabic', 'Noto Sans', 'Arial'],
      fontSize: size,
      height: height / size,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.02 * size,
      color: textColor,
    );

    TextStyle body(double size, double height) => TextStyle(
      fontFamily: _fontFamily,
      fontFamilyFallback: const ['Noto Sans Arabic', 'Noto Sans', 'Arial'],
      fontSize: size,
      height: height / size,
      fontWeight: FontWeight.w400,
      color: textColor,
    );

    return TextTheme(
      displayLarge: heading(34, 40),
      displayMedium: heading(28, 34),
      displaySmall: heading(24, 30),
      headlineLarge: heading(28, 34),
      headlineMedium: heading(24, 30),
      headlineSmall: heading(20, 26),
      titleLarge: heading(20, 26),
      titleMedium: heading(18, 24),
      titleSmall: heading(16, 22),
      bodyLarge: body(16, 24),
      bodyMedium: body(14, 20),
      bodySmall: body(12, 16),
      labelLarge: heading(14, 18).copyWith(letterSpacing: 0),
      labelMedium: body(14, 18),
      labelSmall: body(12, 16),
    );
  }
}
