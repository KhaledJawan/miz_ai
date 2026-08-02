import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/features/home/presentation/pages/home_page.dart';
import 'package:miz_ai/features/home/presentation/widgets/home_input_bar.dart';
import 'package:miz_ai/features/home/presentation/widgets/quick_action_grid.dart';

Widget _wrap({Locale locale = const Locale('en')}) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, _) => const HomePage()),
      GoRoute(
        path: '/chat',
        builder: (_, _) => const Scaffold(body: Text('Chat stub')),
      ),
      GoRoute(
        path: '/menu',
        builder: (_, _) => const Scaffold(body: Text('Menu stub')),
      ),
      GoRoute(
        path: '/discovery',
        builder: (_, _) => const Scaffold(body: Text('Discovery stub')),
      ),
      GoRoute(
        path: '/results',
        builder: (_, _) => const Scaffold(body: Text('Results stub')),
      ),
      GoRoute(
        path: '/restaurant/:id',
        builder: (_, _) => const Scaffold(body: Text('Restaurant stub')),
      ),
    ],
  );
  return ProviderScope(
    child: MaterialApp.router(
      theme: AppTheme.light(),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    ),
  );
}

void main() {
  testWidgets(
    'renders compact Home actions and offer without extra discovery sections',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Miz'), findsOneWidget);
      expect(find.text("Today's Offers"), findsOneWidget);
      expect(find.text('What do you want to eat?'), findsOneWidget);
      expect(find.text('Popular cravings'), findsNothing);
      expect(find.textContaining('Good for'), findsNothing);
      expect(find.text('Good afternoon'), findsNothing);
      expect(find.text("I'm Hungry"), findsOneWidget);
      expect(find.text('Order Food'), findsOneWidget);
      expect(find.text('Reserve a Table'), findsOneWidget);
      expect(find.text('Find a Café'), findsOneWidget);

      final quickActionGrid = tester.widget<GridView>(
        find.descendant(
          of: find.byType(QuickActionGrid),
          matching: find.byType(GridView),
        ),
      );
      expect(quickActionGrid.clipBehavior, Clip.none);
      for (final label in [
        "I'm Hungry",
        'Order Food',
        'Reserve a Table',
        'Find a Café',
      ]) {
        final shadowContainer = tester.widget<Container>(
          find.byKey(ValueKey('quick-action-shadow-$label')),
        );
        final decoration = shadowContainer.decoration! as BoxDecoration;
        expect(decoration.boxShadow, isNotEmpty);
      }

      expect(find.text('Nearby'), findsNothing);
      expect(find.text('Aroma Café'), findsNothing);

      // No favorites yet in a fresh session.
      expect(find.text('Your Favorites'), findsNothing);
    },
  );

  testWidgets('renders the Farsi Home in RTL', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrap(locale: const Locale('fa')));
    await tester.pumpAndSettle();

    expect(find.text('پیشنهادهای امروز'), findsOneWidget);
    expect(find.text('گرسنه‌ام'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(HomePage))),
      TextDirection.rtl,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('German Home fits a compact 320px viewport', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrap(locale: const Locale('de')));
    await tester.pumpAndSettle();

    expect(find.text('Heutige Angebote'), findsOneWidget);
    expect(find.text('Tisch reservieren'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping a quick action navigates to its stub route', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_wrap());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Order Food'));
    await tester.pumpAndSettle();

    expect(find.text('Menu stub'), findsOneWidget);
  });

  testWidgets(
    'composer moves above the software keyboard and keeps input visible',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);

      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      await tester.pumpAndSettle();

      final composerBottom = tester
          .getBottomRight(find.byType(HomeInputBar))
          .dy;
      const keyboardTop = 844 - 300;
      expect(composerBottom, lessThanOrEqualTo(keyboardTop));

      await tester.enterText(find.byType(TextField), 'Find pasta nearby');
      expect(find.text('Find pasta nearby'), findsOneWidget);
    },
  );
}
