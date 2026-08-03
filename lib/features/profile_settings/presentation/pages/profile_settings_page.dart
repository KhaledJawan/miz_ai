import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../food_profile/domain/catalog_localizations.dart';
import '../../../food_profile/presentation/providers/food_profile_providers.dart';
import '../providers/app_settings_controller.dart';
import '../widgets/settings_row.dart';

class ProfileSettingsPage extends ConsumerWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mizColors;
    final l10n = context.l10n;
    final settings = ref.watch(appSettingsControllerProvider);
    final controller = ref.read(appSettingsControllerProvider.notifier);
    final language = AppLanguage.fromCode(settings.languageCode);
    final snapshot = ref.watch(foodProfileSnapshotProvider);

    return Scaffold(
      body: Stack(
        children: [
          const MizAnimatedFoodBackground(calm: true),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lgPlus,
                    AppSpacing.md,
                    AppSpacing.lgPlus,
                    AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          l10n.profileSettingsTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      MizFloatingDismissButton(
                        semanticLabel: l10n.closePage,
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lgPlus,
                      AppSpacing.md,
                      AppSpacing.lgPlus,
                      AppSpacing.xxl,
                    ),
                    children: [
                      MizGlassSurface(
                        level: MizGlassLevel.elevated,
                        prominent: true,
                        borderRadius: AppRadii.xl,
                        padding: const EdgeInsets.all(AppSpacing.lgPlus),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: colors.accent,
                              foregroundColor: colors.onAccent,
                              child: Text(
                                settings.userName.isEmpty
                                    ? '?'
                                    : settings.userName[0].toUpperCase(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    settings.userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    l10n.accountNotConnected,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _SectionLabel(l10n.foodProfilePreferences),
                      const SizedBox(height: AppSpacing.sm),
                      snapshot.when(
                        loading: () => const MizGlassSurface(
                          level: MizGlassLevel.secondary,
                          prominent: true,
                          padding: EdgeInsets.all(AppSpacing.lgPlus),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                        error: (_, _) => MizResultCard(
                          title: l10n.foodProfileTitle,
                          body: l10n.foodProfilePrivacyNotice,
                          icon: Icons.restaurant_menu_rounded,
                          action: TextButton(
                            onPressed: () =>
                                context.push(AppRoutes.foodProfile),
                            child: Text(l10n.reviewEdit),
                          ),
                        ),
                        data: (value) => MizGlassSurface(
                          level: MizGlassLevel.primary,
                          prominent: true,
                          borderRadius: AppRadii.lg,
                          onTap: () => context.push(AppRoutes.foodProfile),
                          padding: const EdgeInsets.all(AppSpacing.lgPlus),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.restaurant_menu_rounded,
                                    color: colors.accent,
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Text(
                                      l10n.foodProfileTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.open_in_new_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Wrap(
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                children: [
                                  _SummaryChip(
                                    catalogLabel(
                                      value.profile.dietType.name,
                                      Localizations.localeOf(
                                        context,
                                      ).languageCode,
                                    ),
                                  ),
                                  _SummaryChip(
                                    '${l10n.allergiesStepTitle}: ${value.allergies.length}',
                                  ),
                                  _SummaryChip(
                                    '${l10n.intolerancesStepTitle}: ${value.intolerances.length}',
                                  ),
                                  _SummaryChip(
                                    '${l10n.cuisinesStepTitle}: ${value.cuisinePreferences.length}',
                                  ),
                                  _SummaryChip(
                                    '${l10n.flavorsStepTitle}: ${value.flavorPreferences.length}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _SectionLabel(l10n.preferences),
                      const SizedBox(height: AppSpacing.sm),
                      _SettingsGroup(
                        children: [
                          SettingsRow.value(
                            label: l10n.language,
                            leadingIcon: Icons.language_rounded,
                            trailingText: language.nativeName,
                            onTap: () =>
                                _selectLanguage(context, ref, language),
                          ),
                          SettingsRow.toggle(
                            label: l10n.darkMode,
                            leadingIcon: Icons.dark_mode_rounded,
                            value: settings.darkMode,
                            onChanged: (_) => controller.toggleDarkMode(),
                          ),
                          SettingsRow.toggle(
                            label: l10n.notifications,
                            leadingIcon: Icons.notifications_rounded,
                            value: settings.notificationsEnabled,
                            onChanged: (_) => controller.toggleNotifications(),
                          ),
                          SettingsRow.toggle(
                            label: l10n.rememberMyPreferences,
                            leadingIcon: Icons.tune_rounded,
                            value: settings.rememberPreferences,
                            onChanged: controller.setRememberPreferences,
                          ),
                          SettingsRow.link(
                            label: l10n.locationSettings,
                            leadingIcon: Icons.location_on_rounded,
                            onTap: () => context.push(AppRoutes.city),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _SectionLabel(l10n.dataPrivacy),
                      const SizedBox(height: AppSpacing.sm),
                      _SettingsGroup(
                        children: [
                          SettingsRow.link(
                            label: l10n.localActivity,
                            leadingIcon: Icons.history_rounded,
                            onTap: () => context.push(AppRoutes.foodProfile),
                          ),
                          SettingsRow.link(
                            label: l10n.privacy,
                            leadingIcon: Icons.shield_rounded,
                          ),
                          SettingsRow.link(
                            label: l10n.help,
                            leadingIcon: Icons.help_rounded,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      MizResultCard(
                        title: l10n.accountNotConnected,
                        body: l10n.connectAccount,
                        icon: Icons.person_off_rounded,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      MizButton.secondary(
                        label: l10n.logOut,
                        expand: true,
                        onPressed: () => context.go(AppRoutes.onboarding),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectLanguage(
    BuildContext context,
    WidgetRef ref,
    AppLanguage selected,
  ) async {
    final result = await MizSpatialSheet.show<AppLanguage>(
      context: context,
      builder: (context) => MizSpatialSheet(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.chooseLanguage,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final language in AppLanguage.values)
              ListTile(
                title: Text(language.nativeName),
                trailing: selected == language
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: context.mizColors.accent,
                      )
                    : null,
                onTap: () => Navigator.of(context).pop(language),
              ),
          ],
        ),
      ),
    );
    if (result != null && result != selected) {
      ref.read(appSettingsControllerProvider.notifier).setLanguage(result);
    }
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(color: context.mizColors.textSecondary),
  );
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => MizGlassSurface(
    level: MizGlassLevel.secondary,
    prominent: true,
    borderRadius: AppRadii.lg,
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    child: Column(children: children),
  );
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F2),
      borderRadius: BorderRadius.circular(AppRadii.full),
    ),
    child: Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: Colors.black),
    ),
  );
}
