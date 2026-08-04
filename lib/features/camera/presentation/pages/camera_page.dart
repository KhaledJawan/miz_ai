import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/chat_launch_args.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/camera_models.dart';
import '../providers/camera_workflow_controller.dart';
import '../widgets/capture_preview_experience.dart';
import '../widgets/food_camera_experience.dart';
import '../widgets/menu_camera_experience.dart';
import '../widgets/unified_scan_experience.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(
          ref.read(cameraWorkflowControllerProvider.notifier).initialize(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(cameraWorkflowControllerProvider);
    final notifier = ref.read(cameraWorkflowControllerProvider.notifier);

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            const MizAnimatedFoodBackground(calm: true),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lgPlus,
                      AppSpacing.md,
                      AppSpacing.lgPlus,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 48),
                        Expanded(
                          child: Text(
                            l10n.cameraTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        MizFloatingDismissButton(
                          semanticLabel: l10n.closePage,
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.lgPlus,
                        AppSpacing.sm,
                        AppSpacing.lgPlus,
                        AppSpacing.xxl,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: _CameraStageContent(
                          state: state,
                          notifier: notifier,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraStageContent extends StatelessWidget {
  const _CameraStageContent({required this.state, required this.notifier});

  final CameraWorkflowState state;
  final CameraWorkflowController notifier;

  bool get _isQrError =>
      state.errorCode == 'QR_SCANNER_UNAVAILABLE' ||
      state.errorCode == 'QR_SCAN_FAILED';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return switch (state.stage) {
      CameraStage.permission => MizResultCard(
        title: l10n.cameraPermissionTitle,
        body: l10n.cameraPermissionBody,
        icon: Icons.camera_alt_rounded,
        action: MizButton.primary(
          label: l10n.allowCamera,
          onPressed: notifier.requestPermission,
        ),
      ),
      CameraStage.denied => MizResultCard(
        title: l10n.cameraDeniedTitle,
        body: l10n.cameraDeniedBody,
        icon: Icons.no_photography_rounded,
      ),
      CameraStage.unavailable => MizResultCard(
        title: l10n.cameraUnavailableTitle,
        body: l10n.cameraUnavailableBody,
        icon: Icons.videocam_off_rounded,
      ),
      CameraStage.offline => MizResultCard(
        title: l10n.offlineTitle,
        body: l10n.offlineBody,
        icon: Icons.cloud_off_rounded,
        action: state.captures.isEmpty
            ? null
            : MizButton.primary(
                label: l10n.retry,
                onPressed: state.mode == CameraMode.menuScan
                    ? notifier.confirmCapture
                    : notifier.analyzeCapture,
              ),
      ),
      CameraStage.invalidQr => MizResultCard(
        title: l10n.invalidQrTitle,
        body: l10n.invalidQrBody,
        icon: Icons.qr_code_2_rounded,
        action: MizButton.secondary(
          label: l10n.scanAgain,
          onPressed: notifier.reset,
        ),
      ),
      CameraStage.expiredQr => MizResultCard(
        title: l10n.expiredQrTitle,
        body: l10n.expiredQrBody,
        icon: Icons.timer_off_rounded,
        action: MizButton.secondary(
          label: l10n.scanAgain,
          onPressed: notifier.reset,
        ),
      ),
      CameraStage.unpublishedQr => MizResultCard(
        title: l10n.unpublishedQrTitle,
        body: l10n.unpublishedQrBody,
        icon: Icons.storefront_outlined,
      ),
      CameraStage.inactiveQr => MizResultCard(
        title: l10n.inactiveTableTitle,
        body: l10n.inactiveTableBody,
        icon: Icons.table_restaurant_outlined,
      ),
      CameraStage.processing => MizGlassSurface(
        level: MizGlassLevel.modal,
        prominent: true,
        borderRadius: AppRadii.xl,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.processing, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.cloudProcessingNotice,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
      CameraStage.multipleMatches => FoodRecognitionResults(
        overview: state.foodOverview ?? '',
        candidates: state.foodCandidates,
        onReset: notifier.reset,
      ),
      CameraStage.uncertain => MizResultCard(
        title: switch (state.mode) {
          CameraMode.menuScan => l10n.menuUnreadableTitle,
          CameraMode.foodRecognition => l10n.foodUncertainTitle,
          null => l10n.captureUnrecognizedTitle,
        },
        body: switch (state.mode) {
          CameraMode.menuScan => l10n.menuUnreadableBody,
          CameraMode.foodRecognition => l10n.foodUncertainBody,
          null => l10n.captureUnrecognizedBody,
        },
        icon: Icons.help_outline_rounded,
        action: MizButton.secondary(
          label: l10n.tryAnotherPhoto,
          onPressed: notifier.reset,
        ),
      ),
      CameraStage.result when state.mode == CameraMode.menuScan =>
        state.menuAnalysis == null
            ? MizResultCard(
                title: l10n.menuAnalysisFailedTitle,
                body: l10n.menuAnalysisFailedBody,
                icon: Icons.error_outline_rounded,
              )
            : MenuAnalysisResults(
                result: state.menuAnalysis!,
                onReset: notifier.reset,
                onAskMiz: (menuContext) => context.push(
                  AppRoutes.chat,
                  extra: ChatLaunchArgs(prompt: '', menuContext: menuContext),
                ),
              ),
      CameraStage.result when state.mode == CameraMode.foodRecognition =>
        FoodRecognitionResults(
          overview: state.foodOverview ?? '',
          candidates: state.foodCandidates,
          onReset: notifier.reset,
        ),
      // Only a verified Miz QR reaches `result` with no mode set — menu/food
      // always set one before getting here.
      CameraStage.result => MizResultCard(
        title: l10n.resultDetails,
        body: l10n.qrVerificationRequired,
        icon: Icons.verified_outlined,
      ),
      CameraStage.error => MizResultCard(
        title: switch (state.mode) {
          CameraMode.menuScan => _menuErrorTitle(l10n, state.errorCode),
          CameraMode.foodRecognition => l10n.foodAnalysisFailedTitle,
          null when _isQrError => l10n.qrScannerUnavailableTitle,
          null => l10n.captureAnalysisFailedTitle,
        },
        body: switch (state.mode) {
          CameraMode.menuScan => _menuErrorBody(l10n, state.errorCode),
          CameraMode.foodRecognition => l10n.foodAnalysisFailedBody,
          null when _isQrError => l10n.qrScannerUnavailableBody,
          null => l10n.captureAnalysisFailedBody,
        },
        icon: Icons.error_outline_rounded,
        action: MizButton.secondary(
          label: state.mode == null && _isQrError
              ? l10n.scanAgain
              : l10n.tryAnotherPhoto,
          onPressed: notifier.reset,
        ),
      ),
      CameraStage.live => UnifiedScanExperience(
        onQrDetected: notifier.handleQrPayload,
        onQrUnavailable: notifier.reportQrScannerUnavailable,
        onCapture: notifier.capture,
        onChoosePhoto: notifier.pickFromGallery,
      ),
      CameraStage.preview when state.mode == CameraMode.menuScan =>
        MenuCaptureExperience(
          state: state,
          onCapture: notifier.capture,
          onChoosePhoto: notifier.pickFromGallery,
          onDelete: notifier.deletePage,
          onReorder: notifier.reorderPage,
          onAnalyze: notifier.confirmCapture,
        ),
      CameraStage.preview => CapturePreviewExperience(
        capture: state.captures.last,
        onRetake: notifier.retakeCurrent,
        onAnalyze: notifier.analyzeCapture,
      ),
    };
  }
}

String _menuErrorTitle(AppLocalizations l10n, String? errorCode) =>
    switch (errorCode) {
      'IMAGE_TOO_LARGE' => l10n.menuImageTooLargeTitle,
      'IMAGE_UNSUPPORTED' => l10n.menuImageUnsupportedTitle,
      'TOO_MANY_PAGES' || 'INVALID_PAGE_COUNT' => l10n.menuTooManyPagesTitle,
      _ => l10n.menuAnalysisFailedTitle,
    };

String _menuErrorBody(AppLocalizations l10n, String? errorCode) =>
    switch (errorCode) {
      'IMAGE_TOO_LARGE' => l10n.menuImageTooLargeBody,
      'IMAGE_UNSUPPORTED' => l10n.menuImageUnsupportedBody,
      'TOO_MANY_PAGES' || 'INVALID_PAGE_COUNT' => l10n.menuTooManyPagesBody,
      _ => l10n.menuAnalysisFailedBody,
    };
