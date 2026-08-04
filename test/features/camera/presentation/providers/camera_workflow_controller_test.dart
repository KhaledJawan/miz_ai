import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/features/camera/domain/camera_models.dart';
import 'package:miz_ai/features/camera/domain/camera_services.dart';
import 'package:miz_ai/features/camera/presentation/providers/camera_workflow_controller.dart';

void main() {
  test('camera denied state is surfaced honestly', () async {
    final container = ProviderContainer(
      overrides: [
        cameraCaptureServiceProvider.overrideWithValue(_DeniedCameraService()),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(cameraWorkflowControllerProvider.notifier)
        .initialize();
    expect(
      container.read(cameraWorkflowControllerProvider).stage,
      CameraStage.denied,
    );
  });

  test(
    'a captured photo classified as a menu supports adding pages, reorder, delete, and confirm',
    () async {
      final capture = _FakeCameraService();
      final analysis = _FakeAnalysisService(classifyKind: CaptureKind.menu);
      // A real Drift DB (not the platform-channel-backed default) so building
      // the Menu Assistant's foodProfileContext doesn't need Flutter bindings.
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);
      final container = ProviderContainer(
        overrides: [
          cameraCaptureServiceProvider.overrideWithValue(capture),
          cameraAnalysisServiceProvider.overrideWithValue(analysis),
          appDatabaseProvider.overrideWithValue(database),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(
        cameraWorkflowControllerProvider.notifier,
      );
      await notifier.initialize();
      await notifier.capture();
      expect(
        container.read(cameraWorkflowControllerProvider).stage,
        CameraStage.preview,
      );
      expect(container.read(cameraWorkflowControllerProvider).mode, isNull);

      await notifier.analyzeCapture();
      expect(analysis.classifyCalls, 1);
      final classified = container.read(cameraWorkflowControllerProvider);
      expect(classified.mode, CameraMode.menuScan);
      expect(classified.stage, CameraStage.preview);

      await notifier.capture();
      expect(
        container.read(cameraWorkflowControllerProvider).captures,
        hasLength(2),
      );
      final firstId = container
          .read(cameraWorkflowControllerProvider)
          .captures
          .first
          .id;
      notifier.reorderPage(0, 1);
      expect(
        container.read(cameraWorkflowControllerProvider).captures.last.id,
        firstId,
      );

      await notifier.deletePage(0);
      expect(
        container.read(cameraWorkflowControllerProvider).captures,
        hasLength(1),
      );
      await notifier.confirmCapture();
      expect(analysis.menuCalls, 1);
      expect(
        container.read(cameraWorkflowControllerProvider).stage,
        CameraStage.result,
      );
    },
  );

  test('valid QR still respects unpublished restaurant verification', () async {
    final analysis = _FakeAnalysisService(
      qrStatus: MizQrVerificationStatus.unpublishedRestaurant,
    );
    final container = ProviderContainer(
      overrides: [cameraAnalysisServiceProvider.overrideWithValue(analysis)],
    );
    addTearDown(container.dispose);
    final expiry =
        DateTime.now()
            .toUtc()
            .add(const Duration(minutes: 10))
            .millisecondsSinceEpoch ~/
        1000;
    const token = 'public_token_12345';
    const signature = 'abcdefghijklmnopqrstuvwxyzABCDEFG_123456';

    await container
        .read(cameraWorkflowControllerProvider.notifier)
        .handleQrPayload(
          'miz://v1/restaurant/$token?exp=$expiry&sig=$signature',
        );

    expect(
      container.read(cameraWorkflowControllerProvider).stage,
      CameraStage.unpublishedQr,
    );
  });

  test(
    'a captured photo classified as a single dish runs food recognition automatically',
    () async {
      final capture = _FakeCameraService();
      final analysis = _FakeAnalysisService(
        classifyKind: CaptureKind.singleDish,
      );
      final container = ProviderContainer(
        overrides: [
          cameraCaptureServiceProvider.overrideWithValue(capture),
          cameraAnalysisServiceProvider.overrideWithValue(analysis),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(
        cameraWorkflowControllerProvider.notifier,
      );
      await notifier.initialize();
      await notifier.capture();
      await notifier.analyzeCapture();

      final state = container.read(cameraWorkflowControllerProvider);
      expect(state.mode, CameraMode.foodRecognition);
      expect(state.stage, CameraStage.result);
      expect(state.foodCandidates.single.name, 'Pizza Margherita');
    },
  );

  test(
    'a captured photo classified as unrecognized shows an honest uncertain state',
    () async {
      final capture = _FakeCameraService();
      final analysis = _FakeAnalysisService(
        classifyKind: CaptureKind.unrecognized,
      );
      final container = ProviderContainer(
        overrides: [
          cameraCaptureServiceProvider.overrideWithValue(capture),
          cameraAnalysisServiceProvider.overrideWithValue(analysis),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(
        cameraWorkflowControllerProvider.notifier,
      );
      await notifier.initialize();
      await notifier.capture();
      await notifier.analyzeCapture();

      final state = container.read(cameraWorkflowControllerProvider);
      expect(state.mode, isNull);
      expect(state.stage, CameraStage.uncertain);
      expect(state.errorCode, 'CAPTURE_UNRECOGNIZED');
    },
  );

  test(
    'reportQrScannerUnavailable only takes effect while on the live scanning stage',
    () async {
      final container = ProviderContainer(
        overrides: [
          cameraCaptureServiceProvider.overrideWithValue(_FakeCameraService()),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(
        cameraWorkflowControllerProvider.notifier,
      );

      // Before initialize(), the stage is still `permission` -- a no-op.
      notifier.reportQrScannerUnavailable();
      expect(
        container.read(cameraWorkflowControllerProvider).stage,
        CameraStage.permission,
      );

      await notifier.initialize();
      expect(
        container.read(cameraWorkflowControllerProvider).stage,
        CameraStage.live,
      );
      notifier.reportQrScannerUnavailable();
      final state = container.read(cameraWorkflowControllerProvider);
      expect(state.stage, CameraStage.error);
      expect(state.errorCode, 'QR_SCANNER_UNAVAILABLE');
    },
  );

  test('reset returns to the live scanning stage with no mode set', () async {
    final capture = _FakeCameraService();
    final analysis = _FakeAnalysisService(classifyKind: CaptureKind.menu);
    final container = ProviderContainer(
      overrides: [
        cameraCaptureServiceProvider.overrideWithValue(capture),
        cameraAnalysisServiceProvider.overrideWithValue(analysis),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(cameraWorkflowControllerProvider.notifier);
    await notifier.initialize();
    await notifier.capture();
    await notifier.analyzeCapture();
    expect(
      container.read(cameraWorkflowControllerProvider).mode,
      CameraMode.menuScan,
    );

    await notifier.reset();
    final state = container.read(cameraWorkflowControllerProvider);
    expect(state.stage, CameraStage.live);
    expect(state.mode, isNull);
    expect(state.captures, isEmpty);
  });
}

class _DeniedCameraService extends _FakeCameraService {
  @override
  Future<CameraPermissionState> permissionState() async =>
      CameraPermissionState.denied;
}

class _FakeCameraService implements CameraCaptureService {
  var sequence = 0;

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
  Future<TemporaryCapture> capture() async {
    final id = 'capture-${sequence++}';
    return TemporaryCapture(
      id: id,
      path: '/temporary/$id.jpg',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<TemporaryCapture> pickFromGallery() async {
    final id = 'gallery-${sequence++}';
    return TemporaryCapture(
      id: id,
      path: '/temporary/$id.jpg',
      createdAt: DateTime.now(),
      source: CaptureSource.gallery,
    );
  }

  @override
  Future<void> deleteTemporary(TemporaryCapture capture) async {}

  @override
  Future<void> dispose() async {}
}

class _FakeAnalysisService implements CameraAnalysisService {
  _FakeAnalysisService({
    this.qrStatus = MizQrVerificationStatus.verified,
    this.classifyKind = CaptureKind.menu,
  });

  var menuCalls = 0;
  var classifyCalls = 0;
  final MizQrVerificationStatus qrStatus;
  final CaptureKind classifyKind;

  @override
  Future<CaptureKind> classifyCapture(
    TemporaryCapture capture, {
    required String locale,
  }) async {
    classifyCalls += 1;
    return classifyKind;
  }

  @override
  Future<MenuAnalysisResult> analyzeMenu(
    List<TemporaryCapture> captures, {
    required String locale,
    Map<String, dynamic>? foodProfileContext,
  }) async {
    menuCalls += 1;
    return const MenuAnalysisResult(
      readable: true,
      categories: [
        MenuAnalysisCategory(
          name: 'Mains',
          dishes: [
            MatchedDish(
              extractedName: 'Pasta',
              price: 12,
              priceIndicator: PriceIndicator.good,
              matchedFoodId: 'food-1',
              matchedName: 'Pasta al Pomodoro',
              shortDescription: 'Pasta with tomato sauce.',
              imagePath: null,
              matchConfidence: 0.9,
              safetyStatus: DishSafetyStatus.safe,
              safetyReasons: [],
              safetyCertain: true,
            ),
          ],
        ),
      ],
      notes: [],
    );
  }

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
      qrStatus;
}
