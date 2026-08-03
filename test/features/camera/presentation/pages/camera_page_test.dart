import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/camera/domain/camera_models.dart';
import 'package:miz_ai/features/camera/domain/camera_services.dart';
import 'package:miz_ai/features/camera/presentation/pages/camera_page.dart';
import 'package:miz_ai/features/camera/presentation/providers/camera_workflow_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  testWidgets('menu mode offers camera and gallery then previews a page', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cameraCaptureServiceProvider.overrideWithValue(
            _WidgetCameraService(),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light(),
          home: const CameraPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Take photo'), findsOneWidget);
    expect(find.text('Choose photo'), findsOneWidget);
    await tester.ensureVisible(find.text('Choose photo'));
    await tester.tap(find.text('Choose photo'));
    await tester.pumpAndSettle();

    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Explain menu'), findsOneWidget);
    expect(
      find.textContaining('sent securely for AI analysis'),
      findsOneWidget,
    );
  });

  testWidgets('food mode offers camera and gallery with explicit AI consent', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cameraCaptureServiceProvider.overrideWithValue(
            _WidgetCameraService(),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light(),
          home: const CameraPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Food'));
    await tester.pumpAndSettle();

    expect(find.text('Take photo'), findsOneWidget);
    expect(find.text('Choose photo'), findsOneWidget);
    await tester.ensureVisible(find.text('Choose photo'));
    await tester.tap(find.text('Choose photo'));
    await tester.pumpAndSettle();

    expect(find.text('Identify food'), findsOneWidget);
    expect(
      find.textContaining('sent securely for AI analysis'),
      findsOneWidget,
    );
  });

  testWidgets(
    'Miz QR mode mounts a real live scanner instead of a placeholder',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cameraCaptureServiceProvider.overrideWithValue(
              _WidgetCameraService(),
            ),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.light(),
            home: const CameraPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Miz QR'));
      await tester.pump();

      expect(find.byType(MobileScanner), findsOneWidget);
      expect(find.textContaining('Only signed Miz'), findsOneWidget);
    },
  );
}

class _WidgetCameraService implements CameraCaptureService {
  @override
  Future<CameraPermissionState> permissionState() async =>
      CameraPermissionState.granted;

  @override
  Future<CameraPermissionState> requestPermission() async =>
      CameraPermissionState.granted;

  @override
  Future<void> initialize() async {}

  @override
  Future<List<TemporaryCapture>> recoverLostCaptures() async => const [];

  @override
  Future<TemporaryCapture?> capture() async => null;

  @override
  Future<TemporaryCapture?> pickFromGallery() async => TemporaryCapture(
    id: 'gallery-1',
    path: '/missing/gallery-1.jpg',
    createdAt: DateTime(2026),
    source: CaptureSource.gallery,
    mimeType: 'image/jpeg',
  );

  @override
  Future<void> deleteTemporary(TemporaryCapture capture) async {}

  @override
  Future<void> dispose() async {}
}
