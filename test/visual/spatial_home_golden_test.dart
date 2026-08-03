import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Spatial Home light 390x844 visual reference', (tester) async {
    await _pumpReference(tester, AppTheme.light());
    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('goldens/spatial_home_light.png'),
    );
  });

  testWidgets('Spatial Home dark 390x844 visual reference', (tester) async {
    await _pumpReference(tester, AppTheme.dark());
    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('goldens/spatial_home_dark.png'),
    );
  });
}

Future<void> _pumpReference(WidgetTester tester, ThemeData theme) async {
  SharedPreferences.setMockInitialValues({'spatial.selected_city': 'Trier'});
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, _) => const HomePage()),
      for (final path in [
        '/city',
        '/chat',
        '/camera',
        '/bookmarks',
        '/profile',
      ])
        GoRoute(path: path, builder: (_, _) => const SizedBox.shrink()),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      child: MediaQuery(
        data: const MediaQueryData(
          size: Size(390, 844),
          disableAnimations: true,
        ),
        child: MaterialApp.router(
          theme: theme,
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: router,
        ),
      ),
    ),
  );
  await tester.pump();
  final homeContext = tester.element(find.byType(HomePage));
  await tester.runAsync(() async {
    for (final asset in [
      'assets/images/spatial/miz_magic_food_ai_light.jpg',
      'assets/images/spatial/miz_magic_food_ai_dark.jpg',
    ]) {
      await precacheImage(AssetImage(asset), homeContext);
    }
  });
  await tester.pump(const Duration(milliseconds: 300));
}
