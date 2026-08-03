import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class MizAnimatedFoodBackground extends StatefulWidget {
  const MizAnimatedFoodBackground({this.calm = false, super.key});

  final bool calm;

  @override
  State<MizAnimatedFoodBackground> createState() =>
      _MizAnimatedFoodBackgroundState();
}

class _MizAnimatedFoodBackgroundState extends State<MizAnimatedFoodBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  static const _magicLightAsset =
      'assets/images/spatial/miz_magic_food_ai_light.jpg';
  static const _magicDarkAsset =
      'assets/images/spatial/miz_magic_food_ai_dark.jpg';
  static const _homeBlurSigma = 5.6;
  late final AnimationController _controller;
  bool _assetsPrecachingStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 34),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_assetsPrecachingStarted) {
      _assetsPrecachingStarted = true;
      for (final asset in const [_magicLightAsset, _magicDarkAsset]) {
        precacheImage(AssetImage(asset), context);
      }
    }
    _syncMotion();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncMotion();
    } else {
      _controller.stop();
    }
  }

  void _syncMotion() {
    final reduced = MediaQuery.disableAnimationsOf(context);
    final visible = TickerMode.valuesOf(context).enabled;
    if (widget.calm || reduced || !visible) {
      _controller
        ..stop()
        ..value = 0.24;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return _buildMagicBackground(colors, dark);
  }

  Widget _buildMagicBackground(AppColors colors, bool dark) {
    final asset = dark ? _magicDarkAsset : _magicLightAsset;
    return Positioned.fill(
      child: RepaintBoundary(
        child: ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final angle = _controller.value * math.pi * 2;
              return Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(color: colors.background),
                  Transform.scale(
                    scale: 1.045 + (widget.calm ? 0 : math.sin(angle) * 0.008),
                    child: Transform.translate(
                      offset: Offset(
                        widget.calm ? 0 : math.sin(angle) * 6,
                        widget.calm ? 0 : math.cos(angle * 0.72) * 8,
                      ),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: _homeBlurSigma,
                          sigmaY: _homeBlurSigma,
                        ),
                        child: Image.asset(
                          asset,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          filterQuality: FilterQuality.medium,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: dark
                            ? [
                                Colors.black.withValues(
                                  alpha: widget.calm ? 0.24 : 0.08,
                                ),
                                Colors.black.withValues(
                                  alpha: widget.calm ? 0.12 : 0,
                                ),
                                Colors.black.withValues(
                                  alpha: widget.calm ? 0.34 : 0.18,
                                ),
                              ]
                            : [
                                Colors.white.withValues(
                                  alpha: widget.calm ? 0.22 : 0.05,
                                ),
                                Colors.white.withValues(
                                  alpha: widget.calm ? 0.10 : 0,
                                ),
                                colors.background.withValues(
                                  alpha: widget.calm ? 0.24 : 0.12,
                                ),
                              ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(
                          0.48 + math.sin(angle) * 0.08,
                          -0.10 + math.cos(angle) * 0.05,
                        ),
                        radius: 0.72,
                        colors: [
                          colors.accent.withValues(
                            alpha: widget.calm
                                ? dark
                                      ? 0.04
                                      : 0.02
                                : dark
                                ? 0.07
                                : 0.04,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
