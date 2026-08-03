import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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

  test('menu mode supports capture, reorder, delete, and confirm', () async {
    final capture = _FakeCameraService();
    final analysis = _FakeAnalysisService();
    final container = ProviderContainer(
      overrides: [
        cameraCaptureServiceProvider.overrideWithValue(capture),
        cameraAnalysisServiceProvider.overrideWithValue(analysis),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(cameraWorkflowControllerProvider.notifier);
    await notifier.initialize();
    notifier.selectMode(CameraMode.menuScan);
    await notifier.capture();
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
  });

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
    'food mode stores recognized candidates from the secure service',
    () async {
      final capture = _FakeCameraService();
      final analysis = _FakeAnalysisService();
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
      notifier.selectMode(CameraMode.foodRecognition);
      await notifier.capture();
      await notifier.confirmCapture();

      final state = container.read(cameraWorkflowControllerProvider);
      expect(state.stage, CameraStage.result);
      expect(state.foodCandidates.single.name, 'Pizza Margherita');
    },
  );

  test(
    'switching modes clears a capability-specific unavailable state',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(
        cameraWorkflowControllerProvider.notifier,
      );
      notifier.selectMode(CameraMode.mizQr);
      notifier.reportQrScannerUnavailable();
      notifier.selectMode(CameraMode.foodRecognition);
      expect(
        container.read(cameraWorkflowControllerProvider).stage,
        CameraStage.live,
      );
    },
  );
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
  _FakeAnalysisService({this.qrStatus = MizQrVerificationStatus.verified});

  var menuCalls = 0;
  final MizQrVerificationStatus qrStatus;

  @override
  Future<MenuAnalysisResult> analyzeMenu(
    List<TemporaryCapture> captures, {
    required String locale,
  }) async {
    menuCalls += 1;
    return const MenuAnalysisResult(
      readable: true,
      overview: 'A concise menu overview.',
      sections: [
        MenuSectionExplanation(
          title: 'Mains',
          items: [
            MenuItemExplanation(
              name: 'Pasta',
              explanation: 'Pasta with tomato sauce.',
              price: '12',
              dietaryTags: [],
              possibleAllergens: ['Wheat'],
              confidence: MenuItemConfidence.high,
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
