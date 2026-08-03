import 'package:flutter/material.dart';

import '../theme/app_glass.dart';
import 'miz_glass_circle_button.dart';

class MizFloatingDismissButton extends StatelessWidget {
  const MizFloatingDismissButton({
    required this.semanticLabel,
    required this.onPressed,
    this.icon = Icons.close_rounded,
    super.key,
  });

  final String semanticLabel;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MizGlassCircleButton(
      icon: icon,
      semanticLabel: semanticLabel,
      onPressed: onPressed,
      size: 48,
      level: MizGlassLevel.elevated,
      prominent: true,
    );
  }
}
