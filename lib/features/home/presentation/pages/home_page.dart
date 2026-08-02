import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../profile_settings/presentation/widgets/profile_settings_sheet.dart';
import '../../../restaurant/domain/restaurant.dart';
import '../providers/home_providers.dart';
import '../widgets/home_header.dart';
import '../widgets/home_input_bar.dart';
import '../widgets/offers_banner.dart';
import '../widgets/quick_action_grid.dart';
import '../widgets/restaurant_rail.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _homeBottomPadding = AppSpacing.xxxl * 2;
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _openRestaurant(Restaurant restaurant) => context.push(
    AppRoutes.restaurantDetails.replaceFirst(':id', restaurant.id),
  );

  void _submitInput(String value) {
    if (value.trim().isEmpty) return;
    _inputController.clear();
    context.push(AppRoutes.chat);
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteRestaurantsProvider);
    final l10n = context.l10n;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: MizBackdrop(
        child: Column(
          children: [
            HomeHeader(onOpenProfile: () => ProfileSettingsSheet.show(context)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lgPlus,
                  AppSpacing.sm,
                  AppSpacing.lgPlus,
                  _homeBottomPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OffersBanner(onTap: () => context.push(AppRoutes.results)),
                    const SizedBox(height: AppSpacing.xl),
                    QuickActionGrid(
                      actions: [
                        QuickAction(
                          label: l10n.hungry,
                          icon: Icons.restaurant_menu,
                          onTap: () => context.push(AppRoutes.chat),
                        ),
                        QuickAction(
                          label: l10n.orderFood,
                          icon: Icons.shopping_bag_outlined,
                          onTap: () => context.push(AppRoutes.menu),
                        ),
                        QuickAction(
                          label: l10n.reserveTable,
                          icon: Icons.event_seat_outlined,
                          onTap: () => context.push(AppRoutes.discovery),
                        ),
                        QuickAction(
                          label: l10n.findCafe,
                          icon: Icons.coffee_outlined,
                          onTap: () => context.push(AppRoutes.discovery),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    favorites.when(
                      data: (list) => list.isEmpty
                          ? const SizedBox.shrink()
                          : _RestaurantSection(
                              title: l10n.yourFavorites,
                              restaurants: list,
                              onTap: _openRestaurant,
                            ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: AppMotion.standard,
        curve: AppMotion.enter,
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SafeArea(
          top: false,
          child: HomeInputBar(
            controller: _inputController,
            onSubmit: _submitInput,
          ),
        ),
      ),
    );
  }
}

class _RestaurantSection extends StatelessWidget {
  const _RestaurantSection({
    required this.title,
    required this.restaurants,
    required this.onTap,
  });

  final String title;
  final List<Restaurant> restaurants;
  final ValueChanged<Restaurant> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Text(
                context.l10n.seeAll,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: colors.accentPressed),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          RestaurantRail(restaurants: restaurants, onTap: onTap),
        ],
      ),
    );
  }
}
