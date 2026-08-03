import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_glass.dart';
import '../theme/app_radii.dart';
import '../theme/app_theme.dart';

class MizGlassSurface extends StatelessWidget {
  const MizGlassSurface({
    required this.child,
    this.level = MizGlassLevel.primary,
    this.borderRadius = AppRadii.xl,
    this.padding,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
    this.prominent = false,
    super.key,
  });

  final Widget child;
  final MizGlassLevel level;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Clip clipBehavior;
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final brightness = Theme.of(context).brightness;
    final style = AppGlass.of(level);
    final radius = BorderRadius.circular(borderRadius);
    final borderBase = brightness == Brightness.dark
        ? Colors.white
        : colors.text;
    final highlightBase = brightness == Brightness.dark
        ? Colors.white
        : colors.surface;
    final dark = brightness == Brightness.dark;
    final shadows = prominent
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.48 : 0.14),
              blurRadius: 30,
              spreadRadius: -4,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.24 : 0.08),
              blurRadius: 8,
              spreadRadius: -2,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: dark ? 0.05 : 0.50),
              blurRadius: 10,
              spreadRadius: -6,
              offset: const Offset(-2, -3),
            ),
          ]
        : [
            BoxShadow(
              color: colors.shadow.withValues(alpha: style.shadowOpacity),
              blurRadius: style.shadowBlur,
              offset: const Offset(0, 12),
            ),
          ];

    final content = Padding(padding: padding ?? EdgeInsets.zero, child: child);
    final materialContent = Material(
      color: Colors.transparent,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
    final themedContent = prominent
        ? Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                onSurface: Colors.black,
                onSurfaceVariant: Colors.black54,
              ),
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              listTileTheme: const ListTileThemeData(
                textColor: Colors.black,
                iconColor: Colors.black54,
              ),
              inputDecorationTheme: Theme.of(context).inputDecorationTheme
                  .copyWith(
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIconColor: Colors.black54,
                    suffixIconColor: Colors.black54,
                  ),
            ),
            child: IconTheme(
              data: const IconThemeData(color: Colors.black),
              child: DefaultTextStyle.merge(
                style: const TextStyle(color: Colors.black),
                child: materialContent,
              ),
            ),
          )
        : materialContent;
    final surface = DecoratedBox(
      decoration: BoxDecoration(
        color: prominent
            ? Colors.white
            : AppGlass.surfaceColor(colors, brightness, style),
        borderRadius: radius,
        border: prominent
            ? null
            : Border.all(
                color: borderBase.withValues(alpha: style.borderOpacity),
              ),
        gradient: prominent
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  highlightBase.withValues(alpha: style.highlightOpacity),
                  highlightBase.withValues(alpha: 0.02),
                ],
              ),
      ),
      child: themedContent,
    );

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: radius, boxShadow: shadows),
      child: ClipRRect(
        borderRadius: radius,
        clipBehavior: clipBehavior,
        child: prominent
            ? surface
            : BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: style.blur,
                  sigmaY: style.blur,
                ),
                child: surface,
              ),
      ),
    );
  }
}
