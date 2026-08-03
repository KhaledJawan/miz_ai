import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/app_config.dart';
import '../../../profile_settings/presentation/providers/app_settings_controller.dart';
import '../../data/image_picker_camera_capture_service.dart';
import '../../data/supabase_camera_analysis_service.dart';
import '../../data/unavailable_camera_services.dart';
import '../../domain/camera_models.dart';
import '../../domain/camera_services.dart';
import '../../domain/miz_qr_validator.dart';

part 'camera_workflow_controller.g.dart';

@riverpod
CameraCaptureService cameraCaptureService(CameraCaptureServiceRef ref) =>
    ImagePickerCameraCaptureService();

@riverpod
CameraAnalysisService cameraAnalysisService(CameraAnalysisServiceRef ref) {
  if (AppConfig.fromEnvironment().supabase == null) {
    return const UnavailableCameraAnalysisService();
  }
  return SupabaseCameraAnalysisService(
    functionsClient: Supabase.instance.client.functions,
  );
}

@riverpod
MizQrValidator mizQrValidator(MizQrValidatorRef ref) => const MizQrValidator();

@riverpod
class CameraWorkflowController extends _$CameraWorkflowController {
  @override
  CameraWorkflowState build() {
    final service = ref.read(cameraCaptureServiceProvider);
    ref.onDispose(() {
      for (final capture in state.captures) {
        unawaited(service.deleteTemporary(capture));
      }
      unawaited(service.dispose());
    });
    return const CameraWorkflowState();
  }

  Future<void> initialize() async {
    final permission = await ref
        .read(cameraCaptureServiceProvider)
        .permissionState();
    await _applyPermission(permission);
  }

  Future<void> requestPermission() async {
    final permission = await ref
        .read(cameraCaptureServiceProvider)
        .requestPermission();
    await _applyPermission(permission);
  }

  Future<void> _applyPermission(CameraPermissionState permission) async {
    switch (permission) {
      case CameraPermissionState.notDetermined:
        state = state.copyWith(stage: CameraStage.permission);
        return;
      case CameraPermissionState.denied:
        state = state.copyWith(stage: CameraStage.denied);
        return;
      case CameraPermissionState.unavailable:
        state = state.copyWith(stage: CameraStage.unavailable);
        return;
      case CameraPermissionState.granted:
        try {
          final service = ref.read(cameraCaptureServiceProvider);
          await service.initialize();
          final recovered = await service.recoverLostCaptures();
          state = state.copyWith(
            stage: recovered.isEmpty ? CameraStage.live : CameraStage.preview,
            captures: recovered,
            activeCaptureIndex: recovered.isEmpty ? null : recovered.length - 1,
          );
        } on CameraCapabilityException {
          state = state.copyWith(stage: CameraStage.unavailable);
        } catch (_) {
          state = state.copyWith(stage: CameraStage.error);
        }
    }
  }

  void selectMode(CameraMode mode) {
    if (mode == state.mode) return;
    final service = ref.read(cameraCaptureServiceProvider);
    for (final capture in state.captures) {
      unawaited(service.deleteTemporary(capture));
    }
    final protectedStage = switch (state.stage) {
      CameraStage.permission || CameraStage.denied => state.stage,
      _ => CameraStage.live,
    };
    state = CameraWorkflowState(mode: mode, stage: protectedStage);
  }

  Future<void> capture() async {
    if (state.mode == CameraMode.menuScan && state.captures.length >= 4) {
      state = state.copyWith(
        stage: CameraStage.error,
        errorCode: 'TOO_MANY_PAGES',
      );
      return;
    }
    try {
      final capture = await ref.read(cameraCaptureServiceProvider).capture();
      if (capture == null) return;
      _appendCapture(capture);
    } on CameraCapabilityException catch (error) {
      state = state.copyWith(
        stage: error.code == 'CAMERA_PERMISSION_DENIED'
            ? CameraStage.denied
            : CameraStage.unavailable,
        errorCode: error.code,
      );
    } catch (_) {
      state = state.copyWith(stage: CameraStage.error);
    }
  }

  Future<void> pickFromGallery() async {
    if (state.mode == CameraMode.menuScan && state.captures.length >= 4) {
      state = state.copyWith(
        stage: CameraStage.error,
        errorCode: 'TOO_MANY_PAGES',
      );
      return;
    }
    try {
      final capture = await ref
          .read(cameraCaptureServiceProvider)
          .pickFromGallery();
      if (capture == null) return;
      _appendCapture(capture);
    } on CameraCapabilityException catch (error) {
      state = state.copyWith(
        stage: CameraStage.unavailable,
        errorCode: error.code,
      );
    } catch (_) {
      state = state.copyWith(stage: CameraStage.error);
    }
  }

  void _appendCapture(TemporaryCapture capture) {
    final captures = state.mode == CameraMode.menuScan
        ? [...state.captures, capture]
        : [capture];
    state = state.copyWith(
      stage: CameraStage.preview,
      captures: captures,
      activeCaptureIndex: captures.length - 1,
      clearMenuAnalysis: true,
      clearFoodAnalysis: true,
    );
  }

  Future<void> retake(int index) async {
    if (index < 0 || index >= state.captures.length) return;
    await deletePage(index);
    await capture();
  }

  Future<void> deletePage(int index) async {
    if (index < 0 || index >= state.captures.length) return;
    final capture = state.captures[index];
    await ref.read(cameraCaptureServiceProvider).deleteTemporary(capture);
    final captures = [...state.captures]..removeAt(index);
    state = state.copyWith(
      captures: captures,
      stage: captures.isEmpty ? CameraStage.live : CameraStage.preview,
      clearActiveCapture: captures.isEmpty,
      activeCaptureIndex: captures.isEmpty ? null : captures.length - 1,
      clearMenuAnalysis: true,
      clearFoodAnalysis: true,
    );
  }

  void reorderPage(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= state.captures.length) return;
    final target = newIndex;
    if (target < 0 || target >= state.captures.length) return;
    final captures = [...state.captures];
    final item = captures.removeAt(oldIndex);
    captures.insert(target, item);
    state = state.copyWith(captures: captures, activeCaptureIndex: target);
  }

  void retakeCurrent() {
    final index = state.activeCaptureIndex;
    if (index != null) unawaited(retake(index));
  }

  Future<void> confirmCapture() async {
    if (state.captures.isEmpty) {
      state = state.copyWith(stage: CameraStage.error);
      return;
    }
    state = state.copyWith(stage: CameraStage.processing);
    try {
      if (state.mode == CameraMode.foodRecognition) {
        final result = await ref
            .read(cameraAnalysisServiceProvider)
            .recognizeFood(
              state.captures.last,
              locale: ref.read(appSettingsControllerProvider).languageCode,
            );
        state = state.copyWith(
          stage: !result.recognized || result.candidates.isEmpty
              ? CameraStage.uncertain
              : result.candidates.length > 1
              ? CameraStage.multipleMatches
              : CameraStage.result,
          foodCandidates: result.candidates,
          foodOverview: result.overview,
        );
      } else if (state.mode == CameraMode.menuScan) {
        final status = await ref
            .read(cameraAnalysisServiceProvider)
            .analyzeMenu(
              state.captures,
              locale: ref.read(appSettingsControllerProvider).languageCode,
            );
        state = state.copyWith(
          stage: status.readable && status.itemCount > 0
              ? CameraStage.result
              : CameraStage.uncertain,
          menuAnalysis: status,
        );
      }
    } on CameraNetworkException catch (error) {
      state = state.copyWith(stage: CameraStage.offline, errorCode: error.code);
    } on MenuAnalysisException catch (error) {
      state = state.copyWith(stage: CameraStage.error, errorCode: error.code);
    } on FoodRecognitionException catch (error) {
      state = state.copyWith(stage: CameraStage.error, errorCode: error.code);
    } on CameraCapabilityException catch (error) {
      state = state.copyWith(
        stage: CameraStage.unavailable,
        errorCode: error.code,
      );
    } catch (_) {
      state = state.copyWith(stage: CameraStage.error);
    }
  }

  Future<void> reset() async {
    final service = ref.read(cameraCaptureServiceProvider);
    for (final capture in state.captures) {
      await service.deleteTemporary(capture);
    }
    state = CameraWorkflowState(mode: state.mode, stage: CameraStage.live);
  }

  Future<void> handleQrPayload(String raw) async {
    final validation = ref.read(mizQrValidatorProvider).validate(raw);
    switch (validation.status) {
      case MizQrValidationStatus.invalid:
        state = state.copyWith(stage: CameraStage.invalidQr);
        return;
      case MizQrValidationStatus.expired:
        state = state.copyWith(stage: CameraStage.expiredQr);
        return;
      case MizQrValidationStatus.requiresNetworkVerification:
        final payload = validation.payload;
        if (payload == null) {
          state = state.copyWith(stage: CameraStage.invalidQr);
          return;
        }
        state = state.copyWith(stage: CameraStage.processing);
        try {
          final status = await ref
              .read(cameraAnalysisServiceProvider)
              .verifyMizQr(payload);
          state = state.copyWith(
            stage: switch (status) {
              MizQrVerificationStatus.verified => CameraStage.result,
              MizQrVerificationStatus.unpublishedRestaurant =>
                CameraStage.unpublishedQr,
              MizQrVerificationStatus.inactiveTable => CameraStage.inactiveQr,
            },
          );
        } on CameraNetworkException {
          state = state.copyWith(stage: CameraStage.offline);
        } on CameraCapabilityException catch (error) {
          state = state.copyWith(
            stage: CameraStage.error,
            errorCode: error.code,
          );
        } catch (_) {
          state = state.copyWith(stage: CameraStage.error);
        }
    }
  }

  void reportQrScannerUnavailable([String code = 'QR_SCANNER_UNAVAILABLE']) {
    if (state.mode != CameraMode.mizQr) return;
    state = state.copyWith(stage: CameraStage.error, errorCode: code);
  }
}
