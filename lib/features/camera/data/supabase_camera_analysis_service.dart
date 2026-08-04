import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart'
    show FunctionException, FunctionsClient;

import '../domain/camera_models.dart';
import '../domain/camera_services.dart';

class SupabaseCameraAnalysisService implements CameraAnalysisService {
  const SupabaseCameraAnalysisService({required this.functionsClient});

  final FunctionsClient functionsClient;

  static const _functionName = 'analyze-menu';
  static const _foodFunctionName = 'analyze-food';
  static const _classifyFunctionName = 'classify-capture';
  static const maxPages = 4;
  static const maxImageBytes = 3 * 1024 * 1024;
  static const maxTotalImageBytes = 8 * 1024 * 1024;
  static const _supportedMimeTypes = {
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/heic',
    'image/heif',
  };

  @override
  Future<MenuAnalysisResult> analyzeMenu(
    List<TemporaryCapture> captures, {
    required String locale,
    Map<String, dynamic>? foodProfileContext,
  }) async {
    if (captures.isEmpty || captures.length > maxPages) {
      throw const MenuAnalysisException(
        'INVALID_PAGE_COUNT',
        retryAvailable: false,
      );
    }

    var totalBytes = 0;
    final images = <Map<String, String>>[];
    for (final capture in captures) {
      final mimeType = capture.mimeType ?? _mimeTypeForPath(capture.path);
      if (mimeType == null || !_supportedMimeTypes.contains(mimeType)) {
        throw const MenuAnalysisException(
          'IMAGE_UNSUPPORTED',
          retryAvailable: false,
        );
      }
      final file = File(capture.path);
      int byteLength;
      try {
        byteLength = await file.length();
      } on FileSystemException {
        throw const MenuAnalysisException(
          'IMAGE_UNAVAILABLE',
          retryAvailable: false,
        );
      }
      totalBytes += byteLength;
      if (byteLength > maxImageBytes || totalBytes > maxTotalImageBytes) {
        throw const MenuAnalysisException(
          'IMAGE_TOO_LARGE',
          retryAvailable: false,
        );
      }
      images.add({
        'mimeType': mimeType,
        'data': base64Encode(await file.readAsBytes()),
      });
    }

    try {
      final response = await functionsClient
          .invoke(
            _functionName,
            body: {
              'locale': locale,
              'images': images,
              'foodProfileContext': foodProfileContext,
            },
          )
          .timeout(const Duration(seconds: 75));
      final json = _asJson(response.data);
      _throwStructuredError(json);
      final rawAnalysis = json['analysis'];
      if (rawAnalysis is! Map) {
        throw const MenuAnalysisException('INVALID_RESPONSE');
      }
      return MenuAnalysisResult.fromJson(
        Map<String, dynamic>.from(rawAnalysis),
      );
    } on FunctionException catch (error) {
      final details = error.details;
      if (details is Map) {
        _throwStructuredError(Map<String, dynamic>.from(details));
      }
      if (details is String) {
        try {
          final decoded = jsonDecode(details);
          if (decoded is Map) {
            _throwStructuredError(Map<String, dynamic>.from(decoded));
          }
        } on FormatException {
          // Fall through to a safe generic error.
        }
      }
      throw const MenuAnalysisException('SERVER_ERROR');
    } on TimeoutException {
      throw const CameraNetworkException('AI_TIMEOUT');
    } on SocketException {
      throw const CameraNetworkException();
    }
  }

  Map<String, dynamic> _asJson(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } on FormatException {
        // Fall through to a typed format failure.
      }
    }
    throw const MenuAnalysisException('INVALID_RESPONSE');
  }

  void _throwStructuredError(Map<String, dynamic> json) {
    if (json['success'] != false) return;
    throw MenuAnalysisException(
      json['errorCode'] as String? ?? 'SERVER_ERROR',
      retryAvailable: json['retryAvailable'] as bool? ?? true,
    );
  }

  String? _mimeTypeForPath(String path) {
    final extension = path.split('.').last.toLowerCase();
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      'heic' => 'image/heic',
      'heif' => 'image/heif',
      _ => null,
    };
  }

  @override
  Future<CaptureKind> classifyCapture(
    TemporaryCapture capture, {
    required String locale,
  }) async {
    final mimeType = capture.mimeType ?? _mimeTypeForPath(capture.path);
    if (mimeType == null || !_supportedMimeTypes.contains(mimeType)) {
      throw const CaptureClassificationException(
        'IMAGE_UNSUPPORTED',
        retryAvailable: false,
      );
    }
    final file = File(capture.path);
    List<int> bytes;
    try {
      bytes = await file.readAsBytes();
    } on FileSystemException {
      throw const CaptureClassificationException(
        'IMAGE_UNAVAILABLE',
        retryAvailable: false,
      );
    }
    if (bytes.length > maxImageBytes) {
      throw const CaptureClassificationException(
        'IMAGE_TOO_LARGE',
        retryAvailable: false,
      );
    }

    try {
      final response = await functionsClient
          .invoke(
            _classifyFunctionName,
            body: {
              'locale': locale,
              'image': {'mimeType': mimeType, 'data': base64Encode(bytes)},
            },
          )
          .timeout(const Duration(seconds: 35));
      final json = _asJson(response.data);
      _throwClassifyStructuredError(json);
      final rawResult = json['result'];
      if (rawResult is! Map) {
        throw const CaptureClassificationException('INVALID_RESPONSE');
      }
      final kind = rawResult['kind'] as String?;
      return switch (kind) {
        'menu' => CaptureKind.menu,
        'single_dish' => CaptureKind.singleDish,
        _ => CaptureKind.unrecognized,
      };
    } on FunctionException catch (error) {
      final details = error.details;
      if (details is Map) {
        _throwClassifyStructuredError(Map<String, dynamic>.from(details));
      }
      if (details is String) {
        try {
          final decoded = jsonDecode(details);
          if (decoded is Map) {
            _throwClassifyStructuredError(Map<String, dynamic>.from(decoded));
          }
        } on FormatException {
          // Fall through to a safe generic error.
        }
      }
      throw const CaptureClassificationException('SERVER_ERROR');
    } on TimeoutException {
      throw const CameraNetworkException('AI_TIMEOUT');
    } on SocketException {
      throw const CameraNetworkException();
    }
  }

  void _throwClassifyStructuredError(Map<String, dynamic> json) {
    if (json['success'] != false) return;
    throw CaptureClassificationException(
      json['errorCode'] as String? ?? 'SERVER_ERROR',
      retryAvailable: json['retryAvailable'] as bool? ?? true,
    );
  }

  @override
  Future<FoodRecognitionResult> recognizeFood(
    TemporaryCapture capture, {
    required String locale,
  }) async {
    final mimeType = capture.mimeType ?? _mimeTypeForPath(capture.path);
    if (mimeType == null || !_supportedMimeTypes.contains(mimeType)) {
      throw const FoodRecognitionException(
        'IMAGE_UNSUPPORTED',
        retryAvailable: false,
      );
    }
    final file = File(capture.path);
    List<int> bytes;
    try {
      bytes = await file.readAsBytes();
    } on FileSystemException {
      throw const FoodRecognitionException(
        'IMAGE_UNAVAILABLE',
        retryAvailable: false,
      );
    }
    if (bytes.length > maxImageBytes) {
      throw const FoodRecognitionException(
        'IMAGE_TOO_LARGE',
        retryAvailable: false,
      );
    }

    try {
      final response = await functionsClient
          .invoke(
            _foodFunctionName,
            body: {
              'locale': locale,
              'image': {'mimeType': mimeType, 'data': base64Encode(bytes)},
            },
          )
          .timeout(const Duration(seconds: 75));
      final json = _asJson(response.data);
      _throwFoodStructuredError(json);
      final rawAnalysis = json['analysis'];
      if (rawAnalysis is! Map) {
        throw const FoodRecognitionException('INVALID_RESPONSE');
      }
      return FoodRecognitionResult.fromJson(
        Map<String, dynamic>.from(rawAnalysis),
      );
    } on FunctionException catch (error) {
      final details = error.details;
      if (details is Map) {
        _throwFoodStructuredError(Map<String, dynamic>.from(details));
      }
      if (details is String) {
        try {
          final decoded = jsonDecode(details);
          if (decoded is Map) {
            _throwFoodStructuredError(Map<String, dynamic>.from(decoded));
          }
        } on FormatException {
          // Fall through to a safe generic error.
        }
      }
      throw const FoodRecognitionException('SERVER_ERROR');
    } on TimeoutException {
      throw const CameraNetworkException('AI_TIMEOUT');
    } on SocketException {
      throw const CameraNetworkException();
    }
  }

  void _throwFoodStructuredError(Map<String, dynamic> json) {
    if (json['success'] != false) return;
    throw FoodRecognitionException(
      json['errorCode'] as String? ?? 'SERVER_ERROR',
      retryAvailable: json['retryAvailable'] as bool? ?? true,
    );
  }

  @override
  Future<MizQrVerificationStatus> verifyMizQr(MizQrPayload payload) =>
      throw const CameraCapabilityException('QR_VERIFICATION_UNAVAILABLE');
}
