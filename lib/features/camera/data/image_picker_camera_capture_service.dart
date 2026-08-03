import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/camera_models.dart';
import '../domain/camera_services.dart';

class ImagePickerCameraCaptureService implements CameraCaptureService {
  ImagePickerCameraCaptureService({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<CameraPermissionState> permissionState() async {
    // image_picker delegates source-specific authorization to the native
    // picker after the user's explicit Take photo / Choose photo action.
    return CameraPermissionState.granted;
  }

  @override
  Future<CameraPermissionState> requestPermission() async =>
      CameraPermissionState.granted;

  @override
  Future<void> initialize() async {}

  @override
  Future<List<TemporaryCapture>> recoverLostCaptures() async {
    if (!Platform.isAndroid) return const [];
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) return const [];
    if (response.exception != null) {
      throw CameraCapabilityException(response.exception!.code);
    }
    return (response.files ?? const <XFile>[])
        .map((file) => _toCapture(file, CaptureSource.gallery))
        .toList(growable: false);
  }

  @override
  Future<TemporaryCapture?> capture() => _pick(ImageSource.camera);

  @override
  Future<TemporaryCapture?> pickFromGallery() => _pick(ImageSource.gallery);

  Future<TemporaryCapture?> _pick(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 2000,
        maxHeight: 2600,
        imageQuality: 82,
        requestFullMetadata: false,
      );
      if (file == null) return null;
      return _toCapture(
        file,
        source == ImageSource.camera
            ? CaptureSource.camera
            : CaptureSource.gallery,
      );
    } on PlatformException catch (error) {
      if (error.code.contains('denied')) {
        throw const CameraCapabilityException('CAMERA_PERMISSION_DENIED');
      }
      throw CameraCapabilityException(error.code);
    }
  }

  TemporaryCapture _toCapture(XFile file, CaptureSource source) {
    final now = DateTime.now();
    return TemporaryCapture(
      id: '${now.microsecondsSinceEpoch}-${file.name.hashCode}',
      path: file.path,
      createdAt: now,
      source: source,
      mimeType: file.mimeType ?? _mimeTypeForPath(file.path),
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
  Future<void> deleteTemporary(TemporaryCapture capture) async {
    // A gallery path can refer to the user's original file on some platforms.
    // Never delete it. Camera captures are documented image_picker cache files.
    if (capture.source != CaptureSource.camera) return;
    try {
      final file = File(capture.path);
      if (await file.exists()) await file.delete();
    } on FileSystemException {
      // Best-effort cleanup. A platform may already have removed its cache.
    }
  }

  @override
  Future<void> dispose() async {}
}
