import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/location/domain/location_service.dart';
import 'package:miz_ai/features/location/presentation/pages/city_selector_page.dart';
import 'package:miz_ai/features/location/presentation/providers/city_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('city selector supports denied location and manual fallback', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          locationServiceProvider.overrideWithValue(const _DeniedService()),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const CitySelectorPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Use current location'), findsOneWidget);
    await tester.tap(find.text('Use current location'));
    await tester.pumpAndSettle();
    expect(find.text('Location access denied'), findsOneWidget);

    await tester.tap(find.text('Trier').last);
    await tester.pumpAndSettle();
    final toggle = tester.widget<Switch>(find.byType(Switch));
    expect(toggle.value, isFalse);
    expect(find.text('Use this city by default'), findsOneWidget);
  });
}

class _DeniedService implements LocationService {
  const _DeniedService();

  @override
  Future<LocationLookupResult> resolveApproximateCity() async =>
      const LocationLookupResult.denied();
}
