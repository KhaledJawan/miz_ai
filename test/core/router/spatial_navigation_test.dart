import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/app.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/core/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('spatial routes deep-link and Android back returns Home', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        initialLocationProvider.overrideWithValue(AppRoutes.home),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const MizApp()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    container.read(appRouterProvider).push(AppRoutes.camera);
    await tester.pump(const Duration(milliseconds: 320));
    await tester.pump();
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Miz QR'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);

    await tester.binding.handlePopRoute();
    await tester.pump(const Duration(milliseconds: 320));
    expect(find.byKey(const ValueKey('home-city-selector')), findsOneWidget);

    container.read(appRouterProvider).push(AppRoutes.bookmarks);
    await tester.pump(const Duration(milliseconds: 320));
    await tester.pump();
    expect(find.text('Saved'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pump(const Duration(milliseconds: 320));
    container.read(appRouterProvider).push(AppRoutes.profile);
    await tester.pump(const Duration(milliseconds: 320));
    await tester.pump();
    expect(find.text('Profile & Settings'), findsOneWidget);
    expect(find.text('Food Profile'), findsWidgets);

    container.read(appRouterProvider).go('${AppRoutes.chat}?q=Find%20sushi');
    await tester.pump(const Duration(milliseconds: 320));
    await tester.pump();
    expect(find.text('Find sushi'), findsOneWidget);
  });
}
