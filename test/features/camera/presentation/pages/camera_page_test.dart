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

/// A bounded stand-in for `pumpAndSettle()`: the unified live view keeps a
/// real `MobileScanner` mounted (a continuously-running camera preview), so
/// `pumpAndSettle()` never converges and hangs the test. A fixed number of
/// short pumps is enough to flush the fake services' immediately-resolving
/// Futures and the resulting rebuild.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
}

Widget _app({CameraAnalysisService? analysis}) => ProviderScope(
  overrides: [
    cameraCaptureServiceProvider.overrideWithValue(_WidgetCameraService()),
    if (analysis != null)
      cameraAnalysisServiceProvider.overrideWithValue(analysis),
  ],
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light(),
    home: const CameraPage(),
  ),
);

void main() {
  testWidgets(
    'the unified live view watches for a QR code immediately, with no mode picker',
    (tester) async {
      await tester.pumpWidget(_app());
      await _settle(tester);

      expect(find.byType(MobileScanner), findsOneWidget);
      expect(find.text('Take photo'), findsOneWidget);
      expect(find.text('Choose photo'), findsOneWidget);
    },
  );

  testWidgets(
    'picking a photo shows one preview with a single Analyze confirmation',
    (tester) async {
      await tester.pumpWidget(_app());
      await _settle(tester);
      await tester.ensureVisible(find.text('Choose photo'));
      await tester.tap(find.text('Choose photo'));
      await _settle(tester);

      expect(find.text('Analyze'), findsOneWidget);
      expect(
        find.textContaining('sent securely for AI analysis'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'a photo classified as a menu reaches the multi-page menu preview after Analyze',
    (tester) async {
      await tester.pumpWidget(
        _app(analysis: _WidgetAnalysisService(classifyKind: CaptureKind.menu)),
      );
      await _settle(tester);
      await tester.ensureVisible(find.text('Choose photo'));
      await tester.tap(find.text('Choose photo'));
      await _settle(tester);
      await tester.ensureVisible(find.text('Analyze'));
      await tester.tap(find.text('Analyze'));
      await _settle(tester);

      expect(find.text('Page 1'), findsOneWidget);
      expect(find.text('Explain menu'), findsOneWidget);
    },
  );

  testWidgets(
    'a photo classified as a single dish runs food recognition automatically',
    (tester) async {
      await tester.pumpWidget(
        _app(
          analysis: _WidgetAnalysisService(
            classifyKind: CaptureKind.singleDish,
          ),
        ),
      );
      await _settle(tester);
      await tester.ensureVisible(find.text('Choose photo'));
      await tester.tap(find.text('Choose photo'));
      await _settle(tester);
      await tester.ensureVisible(find.text('Analyze'));
      await tester.tap(find.text('Analyze'));
      await _settle(tester);

      expect(find.text('Food recognized'), findsOneWidget);
    },
  );

  testWidgets(
    'a photo classified as unrecognized shows an honest uncertain state',
    (tester) async {
      await tester.pumpWidget(
        _app(
          analysis: _WidgetAnalysisService(
            classifyKind: CaptureKind.unrecognized,
          ),
        ),
      );
      await _settle(tester);
      await tester.ensureVisible(find.text('Choose photo'));
      await tester.tap(find.text('Choose photo'));
      await _settle(tester);
      await tester.ensureVisible(find.text('Analyze'));
      await tester.tap(find.text('Analyze'));
      await _settle(tester);

      expect(find.text("Miz couldn't tell what this was"), findsOneWidget);
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

class _WidgetAnalysisService implements CameraAnalysisService {
  _WidgetAnalysisService({required this.classifyKind});

  final CaptureKind classifyKind;

  @override
  Future<CaptureKind> classifyCapture(
    TemporaryCapture capture, {
    required String locale,
  }) async => classifyKind;

  @override
  Future<MenuAnalysisResult> analyzeMenu(
    List<TemporaryCapture> captures, {
    required String locale,
    Map<String, dynamic>? foodProfileContext,
  }) async => const MenuAnalysisResult(readable: true, categories: [], notes: []);

  @override
  Future<FoodRecognitionResult> recognizeFood(
    TemporaryCapture capture, {
    required String locale,
  }) async => const FoodRecognitionResult(
    recognized: true,
    overview: 'A baked Italian flatbread.',
    candidates: [
      FoodRecognitionCandidate(
        name: 'Pizza Margherita',
        confidence: 0.9,
        description: 'Pizza with tomato, cheese, and basil.',
      ),
    ],
  );

  @override
  Future<MizQrVerificationStatus> verifyMizQr(MizQrPayload payload) async =>
      MizQrVerificationStatus.verified;
}
