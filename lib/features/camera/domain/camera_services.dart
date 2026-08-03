import 'camera_models.dart';

enum CameraPermissionState { notDetermined, granted, denied, unavailable }

class CameraCapabilityException implements Exception {
  const CameraCapabilityException([this.code = 'CAMERA_UNAVAILABLE']);

  final String code;
}

class CameraNetworkException implements Exception {
  const CameraNetworkException([this.code = 'NETWORK_UNAVAILABLE']);

  final String code;
}

class MenuAnalysisException implements Exception {
  const MenuAnalysisException(this.code, {this.retryAvailable = true});

  final String code;
  final bool retryAvailable;
}

class FoodRecognitionException implements Exception {
  const FoodRecognitionException(this.code, {this.retryAvailable = true});

  final String code;
  final bool retryAvailable;
}

abstract interface class CameraCaptureService {
  Future<CameraPermissionState> permissionState();
  Future<CameraPermissionState> requestPermission();
  Future<void> initialize();
  Future<List<TemporaryCapture>> recoverLostCaptures();
  Future<TemporaryCapture?> capture();
  Future<TemporaryCapture?> pickFromGallery();
  Future<void> deleteTemporary(TemporaryCapture capture);
  Future<void> dispose();
}

abstract interface class CameraAnalysisService {
  Future<FoodRecognitionResult> recognizeFood(
    TemporaryCapture capture, {
    required String locale,
  });
  Future<MenuAnalysisResult> analyzeMenu(
    List<TemporaryCapture> captures, {
    required String locale,
  });
  Future<MizQrVerificationStatus> verifyMizQr(MizQrPayload payload);
}

enum MizQrVerificationStatus { verified, unpublishedRestaurant, inactiveTable }

class MizQrPayload {
  const MizQrPayload({
    required this.scope,
    required this.publicToken,
    required this.expiresAt,
    required this.signature,
  });

  final String scope;
  final String publicToken;
  final DateTime expiresAt;
  final String signature;
}

enum MizQrValidationStatus { invalid, expired, requiresNetworkVerification }

class MizQrValidationResult {
  const MizQrValidationResult(this.status, {this.payload});

  final MizQrValidationStatus status;
  final MizQrPayload? payload;
}
