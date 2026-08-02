import 'package:flutter/material.dart';

/// Warm, diffused Soft Orbit elevation tokens.
class AppShadows {
  const AppShadows._();

  static List<BoxShadow> xs(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.04),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> sm(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.10),
      blurRadius: 14,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> md(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.14),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> lg(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.20),
      blurRadius: 54,
      offset: const Offset(0, 20),
    ),
  ];
}
