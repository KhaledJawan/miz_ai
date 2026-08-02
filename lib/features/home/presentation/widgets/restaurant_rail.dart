import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/miz_card.dart';
import '../../../../core/widgets/miz_image_slot.dart';
import '../../../restaurant/domain/restaurant.dart';

class RestaurantRail extends StatelessWidget {
  const RestaurantRail({
    required this.restaurants,
    required this.onTap,
    super.key,
  });

  final List<Restaurant> restaurants;
  final ValueChanged<Restaurant> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final restaurant in restaurants) ...[
            _RailCard(restaurant: restaurant, onTap: () => onTap(restaurant)),
            const SizedBox(width: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _RailCard extends StatelessWidget {
  const _RailCard({required this.restaurant, required this.onTap});

  final Restaurant restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return SizedBox(
      width: 196,
      child: MizCard(
        padding: EdgeInsets.zero,
        elevation: MizElevation.sm,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 124,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MizImageSlot(
                    label: restaurant.name,
                    imageAsset: restaurant.imageAsset,
                  ),
                  PositionedDirectional(
                    top: AppSpacing.sm,
                    end: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceGlass,
                        borderRadius: BorderRadius.circular(AppRadii.full),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: colors.accentPressed,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            restaurant.rating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colors.text,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${_localizedCuisine(context, restaurant.cuisine)} · '
                    '${_localizedPrice(context, restaurant.priceTier)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.near_me_rounded,
                        size: 14,
                        color: colors.textTertiary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          '${_localizedDistance(context, restaurant.distanceKm)}'
                          ' · ${_localizedEta(context, restaurant.etaMinutes)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: colors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedCuisine(BuildContext context, String cuisine) =>
      switch (cuisine) {
        'italian' => context.l10n.cuisineItalian,
        'burger' => context.l10n.cuisineBurger,
        'asian' => context.l10n.cuisineAsian,
        'healthy' => context.l10n.cuisineHealthy,
        'dessert' => context.l10n.cuisineDessert,
        'cafe' => context.l10n.cuisineCafe,
        'drinks' => context.l10n.cuisineDrinks,
        _ => restaurant.tag,
      };

  String _localizedPrice(BuildContext context, int tier) =>
      tier == 0 ? context.l10n.noLimit : List.filled(tier, '€').join();

  String _localizedDistance(BuildContext context, double distanceKm) =>
      distanceKm < 1
      ? context.l10n.distanceMeters((distanceKm * 1000).round())
      : context.l10n.distanceKilometers(distanceKm.toStringAsFixed(1));

  String _localizedEta(BuildContext context, int minutes) =>
      minutes > 0 ? context.l10n.minutesShort(minutes) : context.l10n.openNow;
}
