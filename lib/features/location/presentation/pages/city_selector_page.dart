import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/city_selection.dart';
import '../providers/city_controller.dart';

class CitySelectorPage extends ConsumerStatefulWidget {
  const CitySelectorPage({super.key});

  @override
  ConsumerState<CitySelectorPage> createState() => _CitySelectorPageState();
}

class _CitySelectorPageState extends ConsumerState<CitySelectorPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    final selection = ref.watch(cityControllerProvider);
    final visibleCities = supportedCities
        .where((city) => city.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          l10n.selectCity,
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
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lgPlus,
                      AppSpacing.md,
                      AppSpacing.lgPlus,
                      AppSpacing.xxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MizGlassSurface(
                          level: MizGlassLevel.primary,
                          prominent: true,
                          borderRadius: AppRadii.lg,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          child: TextField(
                            key: const ValueKey('city-search-field'),
                            controller: _searchController,
                            onChanged: (value) =>
                                setState(() => _query = value),
                            decoration: InputDecoration(
                              hintText: l10n.searchCity,
                              hintStyle: const TextStyle(color: Colors.black54),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.black54,
                              ),
                              filled: false,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        selection.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          error: (_, _) => MizResultCard(
                            title: l10n.locationUnavailableTitle,
                            body: l10n.locationUnavailableBody,
                            icon: Icons.location_off_rounded,
                          ),
                          data: (value) => _LocationContent(
                            selection: value,
                            visibleCities: visibleCities,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colors.surface.withValues(alpha: 0.04),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationContent extends ConsumerWidget {
  const _LocationContent({
    required this.selection,
    required this.visibleCities,
  });

  final CitySelection selection;
  final List<String> visibleCities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final controller = ref.read(cityControllerProvider.notifier);
    final requesting =
        selection.capabilityState == LocationCapabilityState.requesting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MizGlassSurface(
          level: MizGlassLevel.secondary,
          prominent: true,
          borderRadius: AppRadii.lg,
          padding: const EdgeInsets.all(AppSpacing.lg),
          onTap: requesting ? null : controller.useCurrentLocation,
          child: Row(
            children: [
              requesting
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location_rounded),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.useCurrentLocation,
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.currentLocationPrivacy,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (selection.capabilityState == LocationCapabilityState.denied) ...[
          const SizedBox(height: AppSpacing.md),
          MizResultCard(
            title: l10n.locationDeniedTitle,
            body: l10n.locationDeniedBody,
            icon: Icons.location_disabled_rounded,
          ),
        ],
        if (selection.capabilityState ==
            LocationCapabilityState.unavailable) ...[
          const SizedBox(height: AppSpacing.md),
          MizResultCard(
            title: l10n.locationUnavailableTitle,
            body: l10n.locationUnavailableBody,
            icon: Icons.location_off_rounded,
          ),
        ],
        if (selection.recentCities.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle(l10n.recentCities),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final city in selection.recentCities)
                ChoiceChip(
                  label: Text(city),
                  selected: city == selection.selectedCity,
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  selectedColor: context.mizColors.accent,
                  side: BorderSide.none,
                  elevation: city == selection.selectedCity ? 7 : 4,
                  shadowColor: Colors.black26,
                  labelStyle: TextStyle(
                    color: city == selection.selectedCity
                        ? Colors.white
                        : Colors.black,
                  ),
                  onSelected: (_) => controller.selectCity(city),
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle(l10n.availableCities),
        const SizedBox(height: AppSpacing.sm),
        MizGlassSurface(
          level: MizGlassLevel.secondary,
          prominent: true,
          borderRadius: AppRadii.lg,
          child: Column(
            children: [
              for (var index = 0; index < visibleCities.length; index++) ...[
                _CityRow(
                  city: visibleCities[index],
                  selected: visibleCities[index] == selection.selectedCity,
                  onTap: () => controller.selectCity(visibleCities[index]),
                ),
                if (index != visibleCities.length - 1)
                  const Divider(height: 1, color: Colors.black12),
              ],
            ],
          ),
        ),
        if (selection.selectedCity != null) ...[
          const SizedBox(height: AppSpacing.lg),
          MizGlassSurface(
            level: MizGlassLevel.secondary,
            prominent: true,
            borderRadius: AppRadii.lg,
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.setAsDefault,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Switch.adaptive(
                  value: selection.defaultCity == selection.selectedCity,
                  onChanged: controller.setSelectedAsDefault,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: controller.clearSelection,
            icon: const Icon(Icons.location_off_rounded),
            label: Text(l10n.clearLocation),
          ),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(color: context.mizColors.textSecondary),
  );
}

class _CityRow extends StatelessWidget {
  const _CityRow({
    required this.city,
    required this.selected,
    required this.onTap,
  });

  final String city;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: ListTile(
        title: Text(city),
        trailing: selected
            ? Icon(Icons.check_circle_rounded, color: context.mizColors.accent)
            : null,
        onTap: onTap,
      ),
    );
  }
}
