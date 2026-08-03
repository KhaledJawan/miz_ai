import 'package:flutter/material.dart';

import '../theme/app_glass.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'miz_glass_surface.dart';

class MizCameraModeOption {
  const MizCameraModeOption({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class MizCameraModeSelector extends StatelessWidget {
  const MizCameraModeSelector({
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
    required this.semanticLabel,
    super.key,
  });

  final List<MizCameraModeOption> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticLabel,
      child: MizGlassSurface(
        level: MizGlassLevel.secondary,
        prominent: true,
        borderRadius: AppRadii.full,
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          children: [
            for (var index = 0; index < options.length; index++)
              Expanded(
                child: Semantics(
                  selected: selectedIndex == index,
                  button: true,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadii.full),
                    onTap: () => onSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? context.mizColors.accent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppRadii.full),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            options[index].icon,
                            size: 18,
                            color: selectedIndex == index
                                ? context.mizColors.onAccent
                                : Colors.black54,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(
                            child: Text(
                              options[index].label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: selectedIndex == index
                                        ? context.mizColors.onAccent
                                        : Colors.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
