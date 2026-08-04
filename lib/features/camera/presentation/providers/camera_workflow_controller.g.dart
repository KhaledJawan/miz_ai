// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_workflow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cameraCaptureServiceHash() =>
    r'8e5945431552797c1ba91b9194ea5444867067f5';

/// See also [cameraCaptureService].
@ProviderFor(cameraCaptureService)
final cameraCaptureServiceProvider =
    AutoDisposeProvider<CameraCaptureService>.internal(
      cameraCaptureService,
      name: r'cameraCaptureServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cameraCaptureServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CameraCaptureServiceRef = AutoDisposeProviderRef<CameraCaptureService>;
String _$cameraAnalysisServiceHash() =>
    r'53b4539f4d0cb2b4b23fe724d762d06516feb2fc';

/// See also [cameraAnalysisService].
@ProviderFor(cameraAnalysisService)
final cameraAnalysisServiceProvider =
    AutoDisposeProvider<CameraAnalysisService>.internal(
      cameraAnalysisService,
      name: r'cameraAnalysisServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cameraAnalysisServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CameraAnalysisServiceRef =
    AutoDisposeProviderRef<CameraAnalysisService>;
String _$mizQrValidatorHash() => r'e7eb3b249f13b20ceb35a3bbb25dc79ac127c51e';

/// See also [mizQrValidator].
@ProviderFor(mizQrValidator)
final mizQrValidatorProvider = AutoDisposeProvider<MizQrValidator>.internal(
  mizQrValidator,
  name: r'mizQrValidatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mizQrValidatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MizQrValidatorRef = AutoDisposeProviderRef<MizQrValidator>;
String _$menuScanFoodProfileContextHash() =>
    r'387b8a96d9a15eb80612e3c70c6854fb61b977a5';

/// Same minimized Food Profile context `ConversationController` sends —
/// duplicated as its own provider (rather than imported from the
/// conversation feature) so `camera/` doesn't reach into another feature's
/// presentation internals for what is otherwise a shared domain function.
///
/// Copied from [MenuScanFoodProfileContext].
@ProviderFor(MenuScanFoodProfileContext)
final menuScanFoodProfileContextProvider =
    AutoDisposeAsyncNotifierProvider<
      MenuScanFoodProfileContext,
      Map<String, dynamic>?
    >.internal(
      MenuScanFoodProfileContext.new,
      name: r'menuScanFoodProfileContextProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$menuScanFoodProfileContextHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MenuScanFoodProfileContext =
    AutoDisposeAsyncNotifier<Map<String, dynamic>?>;
String _$cameraWorkflowControllerHash() =>
    r'f1e5dbe07dd7b70611681cf20d59bede25a1b6d7';

/// A single unified camera screen: no manual mode picker. QR codes are
/// decoded live, on-device, while [CameraWorkflowState.stage] is
/// [CameraStage.live]. A still capture (photo or gallery pick) is reviewed
/// once, then [analyzeCapture] classifies it (`classify-capture`) and
/// routes automatically to the menu or food-recognition pipeline — see
/// [CameraMode]/[CaptureKind].
///
/// Copied from [CameraWorkflowController].
@ProviderFor(CameraWorkflowController)
final cameraWorkflowControllerProvider =
    AutoDisposeNotifierProvider<
      CameraWorkflowController,
      CameraWorkflowState
    >.internal(
      CameraWorkflowController.new,
      name: r'cameraWorkflowControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cameraWorkflowControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CameraWorkflowController = AutoDisposeNotifier<CameraWorkflowState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
