import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/core/widgets/widgets.dart';
import 'package:miz_ai/features/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _wrap({Locale locale = const Locale('en')}) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, _) => const HomePage()),
      for (final route in [
        '/chat',
        '/city',
        '/camera',
        '/bookmarks',
        '/profile',
      ])
        GoRoute(
          path: route,
          builder: (_, _) => Scaffold(body: Text('$route stub')),
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

Future<void> _pumpHome(
  WidgetTester tester, {
  Locale locale = const Locale('en'),
  Size size = const Size(390, 844),
}) async {
  SharedPreferences.setMockInitialValues({});
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(_wrap(locale: locale));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('Home contains only the focused Spatial Glass controls', (
    tester,
  ) async {
    await _pumpHome(tester);

    expect(find.byKey(const ValueKey('home-city-selector')), findsOneWidget);
    expect(find.byType(MizGlassInput), findsOneWidget);
    expect(find.byType(MizGlassCircleButton), findsNWidgets(3));
    expect(find.byType(MizAnimatedFoodBackground), findsOneWidget);
    expect(
      tester.widget<MizGlassInput>(find.byType(MizGlassInput)).prominent,
      isTrue,
    );
    expect(
      tester
          .widgetList<MizGlassCircleButton>(find.byType(MizGlassCircleButton))
          .every((button) => button.prominent),
      isTrue,
    );
    expect(find.text('Miz'), findsNothing);
    expect(find.text("Today's Offers"), findsNothing);
    expect(find.text("I'm Hungry"), findsNothing);
    expect(find.byType(BottomNavigationBar), findsNothing);
    expect(find.text('Camera'), findsNothing);
    expect(find.text('Saved'), findsNothing);
    expect(find.text('Profile & Settings'), findsNothing);
  });

  testWidgets('prompt rotates and pauses while focused or typing', (
    tester,
  ) async {
    await _pumpHome(tester);
    expect(find.text('What should I eat today?'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Find something that matches my taste.'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('spatial-ai-input')));
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Find something that matches my taste.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('spatial-ai-input')),
      'spicy noodles',
    );
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('spicy noodles'), findsOneWidget);
    expect(find.text('I want to try something new.'), findsNothing);
  });

  testWidgets(
    'send is disabled when empty and opens conversation when active',
    (tester) async {
      await _pumpHome(tester);
      var sendButton = tester.widget<IconButton>(
        find.byKey(const ValueKey('spatial-send-button')),
      );
      expect(sendButton.onPressed, isNull);

      await tester.enterText(
        find.byKey(const ValueKey('spatial-ai-input')),
        'Find pasta',
      );
      await tester.pump();
      sendButton = tester.widget<IconButton>(
        find.byKey(const ValueKey('spatial-send-button')),
      );
      expect(sendButton.onPressed, isNotNull);

      await tester.tap(find.byKey(const ValueKey('spatial-send-button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('/chat stub'), findsOneWidget);
    },
  );

  testWidgets('three actions navigate to camera, bookmarks, and profile', (
    tester,
  ) async {
    for (final entry in {
      'home-camera-action': '/camera stub',
      'home-bookmarks-action': '/bookmarks stub',
      'home-profile-action': '/profile stub',
    }.entries) {
      await _pumpHome(tester);
      await tester.tap(find.byKey(ValueKey(entry.key)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text(entry.value), findsOneWidget);
    }
  });

  testWidgets('input remains above the keyboard', (tester) async {
    await _pumpHome(tester);
    addTearDown(tester.view.resetViewInsets);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pump(const Duration(milliseconds: 300));

    final inputBottom = tester.getBottomRight(find.byType(MizGlassInput)).dy;
    expect(inputBottom, lessThanOrEqualTo(544));
    await tester.enterText(
      find.byKey(const ValueKey('spatial-ai-input')),
      'Visible above keyboard',
    );
    expect(find.text('Visible above keyboard'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('supports RTL, reduced motion, and a compact 320px viewport', (
    tester,
  ) async {
    await _pumpHome(
      tester,
      locale: const Locale('fa'),
      size: const Size(320, 720),
    );
    expect(
      Directionality.of(tester.element(find.byType(HomePage))),
      TextDirection.rtl,
    );
    expect(find.text('امروز چه بخورم؟'), findsOneWidget);
    expect(tester.takeException(), isNull);

    final media = MediaQuery.of(tester.element(find.byType(HomePage)));
    await tester.pumpWidget(
      MediaQuery(
        data: media.copyWith(disableAnimations: true),
        child: _wrap(locale: const Locale('fa')),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
