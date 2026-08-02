import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../localization/localization.dart';
import '../../features/food_profile/presentation/food_profile_page.dart';
import '../../features/food_profile/presentation/onboarding/food_profile_onboarding_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'coming_soon_page.dart';

/// Every screen named in docs/DESIGN.md §6 has a route from Milestone 0.
/// Unbuilt screens resolve to [ComingSoonPage] rather than a 404 or a faked
/// finished screen — see docs/ARCHITECTURE.md §5. Route paths are the only
/// place these strings should live (CLAUDE.md §6): use [AppRoutes]
/// constants, never inline a path in a widget.
class AppRoutes {
  const AppRoutes._();

  static const onboarding = '/onboarding';
  static const home = '/home';
  static const foodProfile = '/food-profile';
  static const chat = '/chat';
  static const results = '/results';
  static const restaurantDetails = '/restaurant/:id';
  static const discovery = '/discovery';
  static const menu = '/menu';
  static const reservation = '/reservation';
  static const checkout = '/checkout';
  static const tracking = '/tracking';
}

/// The route the app opens on cold start. `bootstrap.dart` resolves this
/// *before* `runApp` — by reading whether the Food Preference Profile
/// onboarding has been completed or skipped — and overrides this provider
/// with the result, exactly like the existing [initialLanguageCodeProvider]
/// pattern. Never an async GoRouter redirect: the decision is made once,
/// up front, so there's no splash-frame flicker between routes.
final initialLocationProvider = Provider<String>((ref) => AppRoutes.onboarding);

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = ref.watch(initialLocationProvider);
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const FoodProfileOnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.foodProfile,
        builder: (context, state) => const FoodProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.conversationTitle),
      ),
      GoRoute(
        path: AppRoutes.results,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.recommendationsTitle),
      ),
      GoRoute(
        path: AppRoutes.restaurantDetails,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.restaurantDetailsTitle),
      ),
      GoRoute(
        path: AppRoutes.discovery,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.discoverTitle),
      ),
      GoRoute(
        path: AppRoutes.menu,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.menuTitle),
      ),
      GoRoute(
        path: AppRoutes.reservation,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.reserveTitle),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.checkoutTitle),
      ),
      GoRoute(
        path: AppRoutes.tracking,
        builder: (context, state) =>
            ComingSoonPage(title: context.l10n.orderTrackingTitle),
      ),
    ],
  );
});
