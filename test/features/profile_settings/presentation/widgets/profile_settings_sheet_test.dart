import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/profile_settings/presentation/providers/app_settings_controller.dart';
import 'package:miz_ai/features/profile_settings/presentation/widgets/profile_settings_sheet.dart';

void main() {
  testWidgets('language picker updates the selected locale code', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: ProfileSettingsSheet()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    expect(find.text('Choose language'), findsOneWidget);
    expect(find.text('English'), findsWidgets);
    expect(find.text('فارسی'), findsOneWidget);
    expect(find.text('Deutsch'), findsOneWidget);

    await tester.tap(find.text('فارسی'));
    await tester.pumpAndSettle();

    expect(
      container.read(appSettingsControllerProvider).languageCode,
      AppLanguage.farsi.code,
    );
  });
}
