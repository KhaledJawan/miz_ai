import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/router/app_router.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/food_profile/data/food_profile_repository_impl.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';
import 'package:miz_ai/features/food_profile/presentation/onboarding/food_profile_onboarding_page.dart';

Widget _wrap(AppDatabase db) {
  final router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const FoodProfileOnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(body: Text('Home')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: MaterialApp.router(
      theme: AppTheme.light(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    ),
  );
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  testWidgets(
    'skipping on welcome marks the profile skipped and never reopens',
    (tester) async {
      await tester.pumpWidget(_wrap(db));
      await tester.pumpAndSettle();

      expect(find.text("Let's understand your taste"), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);

      final profile = await FoodProfileRepositoryImpl(db).ensureProfile();
      expect(profile.onboardingStatus, OnboardingStatus.skipped);
      expect(profile.isOnboarded, isTrue);
    },
  );

  testWidgets(
    'selecting a severe allergy requires confirmation before advancing',
    (tester) async {
      await tester.pumpWidget(_wrap(db));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();
      expect(find.text('What best describes how you eat?'), findsOneWidget);

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Any food rules we should know about?'), findsOneWidget);

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Do you have any food allergies?'), findsOneWidget);

      await tester.tap(find.text('Peanuts'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Severe'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Confirm severe allergy'), findsOneWidget);

      // Cancelling keeps the user on the allergies screen.
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Cancel'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Do you have any food allergies?'), findsOneWidget);

      // Confirming advances past the allergy screen.
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Continue'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Any food intolerances?'), findsOneWidget);
    },
  );

  testWidgets(
    'progress persists per screen and resumes after the widget tree rebuilds',
    (tester) async {
      await tester.pumpWidget(_wrap(db));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Vegan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Any food rules we should know about?'), findsOneWidget);

      // Simulate an app restart: tear down the widget tree and rebuild a
      // fresh onboarding page against the *same* underlying database.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(_wrap(db));
      await tester.pumpAndSettle();

      expect(find.text('Any food rules we should know about?'), findsOneWidget);
      expect(find.text("Let's understand your taste"), findsNothing);

      final profile = await FoodProfileRepositoryImpl(db).ensureProfile();
      expect(profile.dietType, DietType.vegan);
      expect(profile.onboardingStatus, OnboardingStatus.inProgress);
    },
  );
}
