import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../providers/app_settings_controller.dart';
import 'settings_row.dart';

class ProfileSettingsSheet extends ConsumerWidget {
  const ProfileSettingsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: context.mizColors.text.withValues(alpha: 0.28),
      builder: (_) => const ProfileSettingsSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mizColors;
    final settings = ref.watch(appSettingsControllerProvider);
    final controller = ref.read(appSettingsControllerProvider.notifier);
    final language = AppLanguage.fromCode(settings.languageCode);
    final l10n = context.l10n;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
        boxShadow: AppShadows.lg(colors.shadow),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lgPlus,
          AppSpacing.md,
          AppSpacing.lgPlus,
          AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: AppSpacing.xxxl,
                height: AppSpacing.xs,
                margin: const EdgeInsets.only(bottom: AppSpacing.xl),
                decoration: BoxDecoration(
                  color: colors.neutral300,
                  borderRadius: BorderRadius.circular(AppRadii.full),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.accent,
                    boxShadow: AppShadows.sm(colors.shadow),
                  ),
                  child: Text(
                    settings.userName.isEmpty
                        ? '?'
                        : settings.userName[0].toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: colors.onAccent),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        settings.userName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        l10n.tasteProfilePreferences,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                MizIconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  semanticLabel: l10n.closeSettings,
                  background: colors.surface,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            _SectionLabel(label: l10n.preferences),
            const SizedBox(height: AppSpacing.sm),
            _SettingsGroup(
              children: [
                SettingsRow.value(
                  label: l10n.language,
                  leadingIcon: Icons.language_rounded,
                  trailingText: language.nativeName,
                  onTap: () => _selectLanguage(context, ref, language),
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
                  label: l10n.locationPermission,
                  leadingIcon: Icons.location_on_rounded,
                  value: settings.locationPermissionGranted,
                  onChanged: (_) => controller.toggleLocationPermission(),
                ),
                SettingsRow.toggle(
                  label: l10n.rememberMyPreferences,
                  leadingIcon: Icons.favorite_rounded,
                  value: settings.rememberPreferences,
                  onChanged: (_) => controller.toggleRememberPreferences(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _SectionLabel(label: l10n.foodProfilePreferences),
            const SizedBox(height: AppSpacing.sm),
            _SettingsGroup(
              children: [
                SettingsRow.link(
                  label: l10n.foodProfileTitle,
                  leadingIcon: Icons.restaurant_menu_rounded,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.push(AppRoutes.foodProfile);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _SectionLabel(label: l10n.supportAndPrivacy),
            const SizedBox(height: AppSpacing.sm),
            _SettingsGroup(
              children: [
                SettingsRow.link(
                  label: l10n.privacy,
                  leadingIcon: Icons.shield_rounded,
                ),
                SettingsRow.link(
                  label: l10n.about,
                  leadingIcon: Icons.info_rounded,
                ),
                SettingsRow.link(
                  label: l10n.help,
                  leadingIcon: Icons.help_rounded,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            MizButton.secondary(
              label: l10n.logOut,
              expand: true,
              onPressed: () {
                Navigator.of(context).pop();
                context.go(AppRoutes.onboarding);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectLanguage(
    BuildContext context,
    WidgetRef ref,
    AppLanguage selectedLanguage,
  ) async {
    final selected = await showModalBottomSheet<AppLanguage>(
      context: context,
      useSafeArea: true,
      backgroundColor: context.mizColors.background,
      builder: (context) => _LanguagePicker(selectedLanguage: selectedLanguage),
    );
    if (selected == null || selected == selectedLanguage) return;
    ref.read(appSettingsControllerProvider.notifier).setLanguage(selected);
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({required this.selectedLanguage});

  final AppLanguage selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lgPlus,
        AppSpacing.xl,
        AppSpacing.lgPlus,
        AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.chooseLanguage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          for (final language in AppLanguage.values)
            Semantics(
              selected: language == selectedLanguage,
              label: context.l10n.selectedLanguage(language.nativeName),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                ),
                title: Text(language.nativeName),
                trailing: language == selectedLanguage
                    ? Icon(Icons.check_circle_rounded, color: colors.accent)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                onTap: () => Navigator.of(context).pop(language),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: context.mizColors.textSecondary,
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: colors.divider),
        boxShadow: AppShadows.sm(colors.shadow),
      ),
      child: Column(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            children[index],
            if (index < children.length - 1)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 64),
                child: Divider(height: 1, color: colors.divider),
              ),
          ],
        ],
      ),
    );
  }
}
