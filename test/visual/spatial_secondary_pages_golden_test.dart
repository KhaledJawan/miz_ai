import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/camera/presentation/pages/camera_page.dart';
import 'package:miz_ai/features/location/presentation/pages/city_selector_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Spatial City dark visual reference', (tester) async {
    await _pumpReference(
      tester,
      theme: AppTheme.dark(),
      page: const CitySelectorPage(),
    );
    await expectLater(
      find.byType(CitySelectorPage),
      matchesGoldenFile('goldens/spatial_city_dark.png'),
    );
  });

  testWidgets('Spatial Camera light visual reference', (tester) async {
    // The unified camera screen always mounts a real MobileScanner (live QR
    // watching) — this environment has no native mobile_scanner plugin, so
    // stub its method channel rather than let a MissingPluginException
    // reach the widget's own (unrelated) start-up error handling.
    final channels = [
      const MethodChannel('dev.steenbakker.mobile_scanner/scanner/method'),
      const MethodChannel('dev.steenbakker.mobile_scanner/scanner/event'),
      const MethodChannel(
        'dev.steenbakker.mobile_scanner/scanner/deviceOrientation',
      ),
    ];
    for (final channel in channels) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async => null);
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null),
      );
    }

    await _pumpReference(
      tester,
      theme: AppTheme.light(),
      page: const CameraPage(),
    );
    await expectLater(
      find.byType(CameraPage),
      matchesGoldenFile('goldens/spatial_camera_light.png'),
    );
  });
}

Future<void> _pumpReference(
  WidgetTester tester, {
  required ThemeData theme,
  required Widget page,
}) async {
  SharedPreferences.setMockInitialValues({'spatial.selected_city': 'Trier'});
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      child: MediaQuery(
        data: const MediaQueryData(
          size: Size(390, 844),
          disableAnimations: true,
        ),
        child: MaterialApp(
          theme: theme,
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: page,
        ),
      ),
    ),
  );
  await tester.pump();
  final pageContext = tester.element(find.byWidget(page));
  await tester.runAsync(() async {
    for (final asset in [
      'assets/images/spatial/miz_magic_food_ai_light.jpg',
      'assets/images/spatial/miz_magic_food_ai_dark.jpg',
    ]) {
      await precacheImage(AssetImage(asset), pageContext);
    }
  });
  await tester.pump(const Duration(milliseconds: 400));
}
