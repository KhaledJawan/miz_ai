import 'package:flutter/material.dart';

/// Soft Orbit semantic color tokens. Feature widgets consume these through
/// [BuildContext.mizColors] and never introduce one-off color literals.
class AppColors {
  const AppColors({
    required this.background,
    required this.backgroundSecondary,
    required this.surface,
    required this.surfaceSoft,
    required this.surfaceGlass,
    required this.text,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.onAccent,
    required this.accentPressed,
    required this.accent2,
    required this.divider,
    required this.error,
    required this.success,
    required this.neutral100,
    required this.neutral200,
    required this.neutral300,
    required this.neutral400,
    required this.neutral500,
    required this.neutral600,
    required this.neutral700,
    required this.neutral800,
    required this.neutral900,
    required this.accent100,
    required this.accent200,
    required this.accent700,
    required this.accent800,
    required this.accent2_100,
    required this.accent2_800,
    required this.shadow,
  });

  final Color background;
  final Color backgroundSecondary;
  final Color surface;
  final Color surfaceSoft;
  final Color surfaceGlass;
  final Color text;
  final Color textSecondary;
  final Color textTertiary;
  final Color accent;
  final Color onAccent;
  final Color accentPressed;
  final Color accent2;
  final Color divider;
  final Color error;
  final Color success;

  // Tonal compatibility tokens used by MizTag and existing feature widgets.
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;
  final Color neutral400;
  final Color neutral500;
  final Color neutral600;
  final Color neutral700;
  final Color neutral800;
  final Color neutral900;
  final Color accent100;
  final Color accent200;
  final Color accent700;
  final Color accent800;
  final Color accent2_100;
  final Color accent2_800;
  final Color shadow;

  static const light = AppColors(
    background: Color(0xFFF7F7F5),
    backgroundSecondary: Color(0xFFEDEDE9),
    surface: Color(0xFFFFFFFF),
    surfaceSoft: Color(0xFFF1F1EE),
    surfaceGlass: Color(0xE6FFFFFF),
    text: Color(0xFF111111),
    textSecondary: Color(0xFF555555),
    textTertiary: Color(0xFF858585),
    accent: Color(0xFFD92D20),
    onAccent: Color(0xFFFFFFFF),
    accentPressed: Color(0xFFA91F16),
    accent2: Color(0xFFFFD8D2),
    divider: Color(0x1A111111),
    error: Color(0xFFA91F16),
    success: Color(0xFF292929),
    neutral100: Color(0xFFF5F5F2),
    neutral200: Color(0xFFEDEDE9),
    neutral300: Color(0xFFDCDCD7),
    neutral400: Color(0xFFBDBDB8),
    neutral500: Color(0xFF92928E),
    neutral600: Color(0xFF70706C),
    neutral700: Color(0xFF555555),
    neutral800: Color(0xFF2D2D2D),
    neutral900: Color(0xFF111111),
    accent100: Color(0xFFFFE8E4),
    accent200: Color(0xFFFFCCC3),
    accent700: Color(0xFFA91F16),
    accent800: Color(0xFF8F190F),
    accent2_100: Color(0xFFFFF0ED),
    accent2_800: Color(0xFF8F190F),
    shadow: Color(0xFF000000),
  );

  static const dark = AppColors(
    background: Color(0xFF0E0E0E),
    backgroundSecondary: Color(0xFF151515),
    surface: Color(0xFF1B1B1B),
    surfaceSoft: Color(0xFF242424),
    surfaceGlass: Color(0xEB1B1B1B),
    text: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFC8C8C8),
    textTertiary: Color(0xFF929292),
    accent: Color(0xFFFF4B36),
    onAccent: Color(0xFF0E0E0E),
    accentPressed: Color(0xFFFF7564),
    accent2: Color(0xFF4A1E19),
    divider: Color(0x1FFFFFFF),
    error: Color(0xFFFF7564),
    success: Color(0xFFE4E4E4),
    neutral100: Color(0xFF242424),
    neutral200: Color(0xFF2D2D2D),
    neutral300: Color(0xFF3A3A3A),
    neutral400: Color(0xFF555555),
    neutral500: Color(0xFF777777),
    neutral600: Color(0xFF929292),
    neutral700: Color(0xFFC8C8C8),
    neutral800: Color(0xFFE4E4E4),
    neutral900: Color(0xFFFFFFFF),
    accent100: Color(0xFF461A15),
    accent200: Color(0xFF68251D),
    accent700: Color(0xFFFF8B7D),
    accent800: Color(0xFFFFB8AF),
    accent2_100: Color(0xFF341A17),
    accent2_800: Color(0xFFFFB8AF),
    shadow: Color(0xFF000000),
  );
}
