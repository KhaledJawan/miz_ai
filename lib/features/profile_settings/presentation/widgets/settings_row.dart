import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/miz_switch.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow.toggle({
    required this.label,
    required this.leadingIcon,
    required this.value,
    required this.onChanged,
    super.key,
  }) : trailingText = null,
       onTap = null;

  const SettingsRow.value({
    required this.label,
    required this.leadingIcon,
    required this.trailingText,
    this.onTap,
    super.key,
  }) : value = null,
       onChanged = null;

  const SettingsRow.link({
    required this.label,
    required this.leadingIcon,
    this.onTap,
    super.key,
  }) : trailingText = null,
       value = null,
       onChanged = null;

  final String label;
  final IconData leadingIcon;
  final String? trailingText;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isLink = trailingText == null && value == null;
    final row = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: AppSpacing.xxlPlus,
            height: AppSpacing.xxlPlus,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              leadingIcon,
              size: AppSpacing.lgPlus,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
          if (trailingText != null)
            Flexible(
              child: Text(
                trailingText!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ),
          if (value != null && onChanged != null)
            MizSwitch(value: value!, onChanged: onChanged!),
          if (isLink || onTap != null)
            Icon(
              Icons.chevron_right,
              size: AppSpacing.xl,
              color: Colors.black38,
            ),
        ],
      ),
    );

    final effectiveOnTap =
        onTap ??
        (value != null && onChanged != null ? () => onChanged!(!value!) : null);
    if (effectiveOnTap == null) return row;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: effectiveOnTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: row,
      ),
    );
  }
}
