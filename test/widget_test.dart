import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/app.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/core/localization/app_language.dart';
import 'package:miz_ai/features/profile_settings/presentation/providers/app_settings_controller.dart';

void main() {
  testWidgets('MizApp boots to the onboarding screen', (tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const MizApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Let's understand your taste"), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('changing to Farsi localizes the app and enables RTL', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const MizApp()),
    );
    await tester.pumpAndSettle();

    container
        .read(appSettingsControllerProvider.notifier)
        .setLanguage(AppLanguage.farsi);
    await tester.pumpAndSettle();

    expect(find.text('بیایید سلیقهٔ شما را بشناسیم'), findsOneWidget);
    expect(
      tester
          .widget<Directionality>(find.byType(Directionality).first)
          .textDirection,
      TextDirection.rtl,
    );
  });
}
