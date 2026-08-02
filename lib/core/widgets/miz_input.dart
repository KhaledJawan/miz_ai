import 'package:flutter/material.dart';

import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Rounded Soft Orbit text field.
class MizInput extends StatelessWidget {
  const MizInput({
    required this.controller,
    this.placeholder,
    this.onSubmitted,
    this.onChanged,
    this.filled = true,
    this.borderless = false,
    this.textInputAction = TextInputAction.done,
    super.key,
  });

  final TextEditingController controller;
  final String? placeholder;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool filled;
  final bool borderless;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      textInputAction: textInputAction,
      cursorColor: colors.accent,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colors.text.withValues(alpha: 0.55),
        ),
        filled: filled,
        fillColor: filled ? colors.surfaceSoft : Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: borderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                borderSide: BorderSide(color: colors.divider),
              ),
        enabledBorder: borderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                borderSide: BorderSide(color: colors.divider),
              ),
        focusedBorder: borderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                borderSide: BorderSide(color: colors.accent, width: 1.5),
              ),
      ),
    );
  }
}
