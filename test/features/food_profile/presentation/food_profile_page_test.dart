import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/food_profile/data/food_profile_repository_impl.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';
import 'package:miz_ai/features/food_profile/presentation/food_profile_page.dart';

Widget _wrap(AppDatabase db) {
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: MaterialApp(
      theme: AppTheme.light(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const FoodProfilePage(),
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
    'editing diet in Settings persists immediately, without an onboarding "continue" step',
    (tester) async {
      await tester.pumpWidget(_wrap(db));
      await tester.pumpAndSettle();

      expect(find.text('Not answered yet'), findsWidgets);

      await tester.tap(find.text('What best describes how you eat?'));
      await tester.pumpAndSettle();

      expect(find.text('Vegan'), findsOneWidget);
      await tester.tap(find.text('Vegan'));
      await tester.pumpAndSettle();

      final afterTap = await FoodProfileRepositoryImpl(db).ensureProfile();
      expect(afterTap.dietType, DietType.vegan);

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(find.text('Vegan'), findsOneWidget);
      expect(find.text('What best describes how you eat?'), findsOneWidget);
    },
  );
}
