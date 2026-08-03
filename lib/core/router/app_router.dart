import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../localization/localization.dart';
import '../../features/food_profile/presentation/food_profile_page.dart';
import '../../features/food_profile/presentation/onboarding/food_profile_onboarding_page.dart';
import '../../features/bookmarks/presentation/pages/bookmarks_page.dart';
import '../../features/camera/presentation/pages/camera_page.dart';
import '../../features/conversation/presentation/pages/conversation_page.dart';
import '../../features/conversation/presentation/pages/conversation_history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/location/presentation/pages/city_selector_page.dart';
import '../../features/profile_settings/presentation/pages/profile_settings_page.dart';
import '../theme/app_motion.dart';
import '../widgets/miz_spatial_transition.dart';
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
  static const city = '/city';
  static const bookmarks = '/bookmarks';
  static const profile = '/profile';
  static const camera = '/camera';
  static const chat = '/chat';
  static const chatHistory = '/chat-history';
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
        pageBuilder: (context, state) =>
            _spatialPage(state, const FoodProfilePage()),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.chat,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final queryPrompt = state.uri.queryParameters['q'];
          final rawPrompt = extra is String ? extra : queryPrompt ?? '';
          final prompt = rawPrompt.length > 1000
              ? rawPrompt.substring(0, 1000)
              : rawPrompt;
          return _spatialPage(state, ConversationPage(initialPrompt: prompt));
        },
      ),
      GoRoute(
        path: AppRoutes.chatHistory,
        pageBuilder: (context, state) =>
            _spatialPage(state, const ConversationHistoryPage()),
      ),
      GoRoute(
        path: AppRoutes.city,
        pageBuilder: (context, state) =>
            _spatialPage(state, const CitySelectorPage()),
      ),
      GoRoute(
        path: AppRoutes.bookmarks,
        pageBuilder: (context, state) =>
            _spatialPage(state, const BookmarksPage()),
      ),
      GoRoute(
        path: AppRoutes.profile,
        pageBuilder: (context, state) =>
            _spatialPage(state, const ProfileSettingsPage()),
      ),
      GoRoute(
        path: AppRoutes.camera,
        pageBuilder: (context, state) =>
            _spatialPage(state, const CameraPage()),
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

CustomTransitionPage<void> _spatialPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppMotion.standard,
    reverseTransitionDuration: AppMotion.fast,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        MizSpatialTransition(animation: animation, child: child),
  );
}
