import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import '../localization/localization.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

/// Shared placeholder for every screen not yet built (see docs/ROADMAP.md).
/// Keeps the whole app navigable end-to-end from M0 without faking a
/// finished feature — see docs/ARCHITECTURE.md §5.
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Scaffold(
      body: MizBackdrop(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MizOrb(size: 112),
                const SizedBox(height: AppSpacing.xl),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.l10n.comingSoonMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.xl),
                MizButton.secondary(
                  label: context.l10n.backToHome,
                  onPressed: () => context.canPop()
                      ? context.pop()
                      : context.go(AppRoutes.home),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
