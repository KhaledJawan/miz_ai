import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

class MizSegment<T> {
  const MizSegment({required this.value, required this.label});

  final T value;
  final String label;
}

/// Capsule single-select control.
class MizSegmentedControl<T> extends StatelessWidget {
  const MizSegmentedControl({
    required this.segments,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final List<MizSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceSoft,
        border: Border.all(color: colors.divider),
        borderRadius: BorderRadius.circular(AppRadii.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < segments.length; i++) ...[
            _SegmentOption<T>(
              segment: segments[i],
              selected: segments[i].value == value,
              onTap: () => onChanged(segments[i].value),
            ),
          ],
        ],
      ),
    );
  }
}

class _SegmentOption<T> extends StatelessWidget {
  const _SegmentOption({
    required this.segment,
    required this.selected,
    required this.onTap,
  });

  final MizSegment<T> segment;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.full),
          child: AnimatedContainer(
            duration: AppMotion.fast,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: selected ? colors.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadii.full),
            ),
            alignment: Alignment.center,
            child: Text(
              segment.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selected ? colors.background : colors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
