import '../domain/camera_models.dart';
import '../domain/camera_services.dart';

class UnavailableCameraCaptureService implements CameraCaptureService {
  const UnavailableCameraCaptureService();

  @override
  Future<CameraPermissionState> permissionState() async =>
      CameraPermissionState.unavailable;

  @override
  Future<CameraPermissionState> requestPermission() async =>
      CameraPermissionState.unavailable;

  @override
  Future<void> initialize() => throw const CameraCapabilityException();

  @override
  Future<List<TemporaryCapture>> recoverLostCaptures() async => const [];

  @override
  Future<TemporaryCapture?> capture() =>
      throw const CameraCapabilityException();

  @override
  Future<TemporaryCapture?> pickFromGallery() =>
      throw const CameraCapabilityException();

  @override
  Future<void> deleteTemporary(TemporaryCapture capture) async {}

  @override
  Future<void> dispose() async {}
}

class UnavailableCameraAnalysisService implements CameraAnalysisService {
  const UnavailableCameraAnalysisService();

  @override
  Future<CaptureKind> classifyCapture(
    TemporaryCapture capture, {
    required String locale,
  }) => throw const CameraCapabilityException();

  @override
  Future<MenuAnalysisResult> analyzeMenu(
    List<TemporaryCapture> captures, {
    required String locale,
    Map<String, dynamic>? foodProfileContext,
  }) => throw const CameraCapabilityException();

  @override
  Future<FoodRecognitionResult> recognizeFood(
    TemporaryCapture capture, {
    required String locale,
  }) => throw const CameraCapabilityException();

  @override
  Future<MizQrVerificationStatus> verifyMizQr(MizQrPayload payload) =>
      throw const CameraCapabilityException();
}
