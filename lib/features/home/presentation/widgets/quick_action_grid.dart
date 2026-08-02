import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';

class QuickAction {
  const QuickAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({required this.actions, super.key});

  final List<QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: actions.length,
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
        childAspectRatio: 1.12,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          _QuickActionTile(action: actions[index], emphasized: index == 0),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action, required this.emphasized});

  final QuickAction action;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final radius = BorderRadius.circular(AppRadii.lg);
    final background = emphasized ? colors.accent100 : colors.surface;
    return Semantics(
      button: true,
      label: action.label,
      child: Container(
        key: ValueKey('quick-action-shadow-${action.label}'),
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: AppShadows.sm(colors.shadow),
        ),
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: colors.divider),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: action.onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: AppSpacing.xxlPlus,
                    height: AppSpacing.xxlPlus,
                    decoration: BoxDecoration(
                      color: emphasized ? colors.accent : colors.text,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      action.icon,
                      color: emphasized ? colors.onAccent : colors.background,
                      size: AppSpacing.xl,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          action.label,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        Directionality.of(context) == TextDirection.rtl
                            ? '←'
                            : '→',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: emphasized
                                  ? colors.accentPressed
                                  : colors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
