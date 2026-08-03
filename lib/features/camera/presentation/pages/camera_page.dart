import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/camera_models.dart';
import '../providers/camera_workflow_controller.dart';
import '../widgets/food_camera_experience.dart';
import '../widgets/menu_camera_experience.dart';
import '../widgets/miz_qr_scanner_experience.dart';

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
    final options = [
      MizCameraModeOption(
        label: l10n.foodRecognitionMode,
        icon: Icons.restaurant_rounded,
      ),
      MizCameraModeOption(label: l10n.mizQrMode, icon: Icons.qr_code_rounded),
      MizCameraModeOption(
        label: l10n.menuScanMode,
        icon: Icons.menu_book_rounded,
      ),
    ];

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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lgPlus,
                    ),
                    child: MizCameraModeSelector(
                      options: options,
                      selectedIndex: state.mode.index,
                      semanticLabel: l10n.changeCameraMode,
                      onSelected: (index) =>
                          notifier.selectMode(CameraMode.values[index]),
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
                onPressed: notifier.confirmCapture,
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
      CameraStage.multipleMatches
          when state.mode == CameraMode.foodRecognition =>
        FoodRecognitionResults(
          overview: state.foodOverview ?? '',
          candidates: state.foodCandidates,
          onReset: notifier.reset,
        ),
      CameraStage.uncertain || CameraStage.multipleMatches => MizResultCard(
        title: state.mode == CameraMode.menuScan
            ? l10n.menuUnreadableTitle
            : l10n.foodUncertainTitle,
        body: state.mode == CameraMode.menuScan
            ? l10n.menuUnreadableBody
            : l10n.foodUncertainBody,
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
              ),
      CameraStage.result when state.mode == CameraMode.foodRecognition =>
        FoodRecognitionResults(
          overview: state.foodOverview ?? '',
          candidates: state.foodCandidates,
          onReset: notifier.reset,
        ),
      CameraStage.result => MizResultCard(
        title: l10n.resultDetails,
        body: state.mode == CameraMode.mizQr
            ? l10n.qrVerificationRequired
            : l10n.cloudProcessingNotice,
        icon: Icons.verified_outlined,
      ),
      CameraStage.error => MizResultCard(
        title: state.mode == CameraMode.menuScan
            ? _menuErrorTitle(l10n, state.errorCode)
            : state.mode == CameraMode.foodRecognition
            ? l10n.foodAnalysisFailedTitle
            : state.errorCode == 'QR_SCANNER_UNAVAILABLE' ||
                  state.errorCode == 'QR_SCAN_FAILED'
            ? l10n.qrScannerUnavailableTitle
            : l10n.backendRequired,
        body: state.mode == CameraMode.menuScan
            ? _menuErrorBody(l10n, state.errorCode)
            : state.mode == CameraMode.foodRecognition
            ? l10n.foodAnalysisFailedBody
            : state.errorCode == 'QR_SCANNER_UNAVAILABLE' ||
                  state.errorCode == 'QR_SCAN_FAILED'
            ? l10n.qrScannerUnavailableBody
            : l10n.qrVerificationRequired,
        icon: Icons.error_outline_rounded,
        action: MizButton.secondary(
          label: state.mode == CameraMode.mizQr
              ? l10n.scanAgain
              : l10n.tryAnotherPhoto,
          onPressed: notifier.reset,
        ),
      ),
      CameraStage.live || CameraStage.preview
          when state.mode == CameraMode.menuScan =>
        MenuCaptureExperience(
          state: state,
          onCapture: notifier.capture,
          onChoosePhoto: notifier.pickFromGallery,
          onDelete: notifier.deletePage,
          onReorder: notifier.reorderPage,
          onAnalyze: notifier.confirmCapture,
        ),
      CameraStage.live || CameraStage.preview
          when state.mode == CameraMode.foodRecognition =>
        FoodCaptureExperience(
          state: state,
          onCapture: notifier.capture,
          onChoosePhoto: notifier.pickFromGallery,
          onAnalyze: notifier.confirmCapture,
        ),
      CameraStage.live when state.mode == CameraMode.mizQr =>
        MizQrScannerExperience(
          onDetected: notifier.handleQrPayload,
          onUnavailable: notifier.reportQrScannerUnavailable,
        ),
      CameraStage.live || CameraStage.preview => _LiveCameraExperience(
        state: state,
        notifier: notifier,
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

class _LiveCameraExperience extends StatelessWidget {
  const _LiveCameraExperience({required this.state, required this.notifier});

  final CameraWorkflowState state;
  final CameraWorkflowController notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: MizGlassSurface(
            level: MizGlassLevel.subtle,
            prominent: true,
            borderRadius: AppRadii.xl,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  state.mode == CameraMode.mizQr
                      ? Icons.qr_code_scanner_rounded
                      : Icons.camera_alt_outlined,
                  size: 92,
                  color: Colors.black38,
                ),
                if (state.mode == CameraMode.mizQr)
                  PositionedDirectional(
                    start: AppSpacing.xl,
                    end: AppSpacing.xl,
                    bottom: AppSpacing.xl,
                    child: Text(
                      l10n.scanQrInstruction,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (state.mode == CameraMode.menuScan && state.captures.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.menuPagesTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.captures.length,
            onReorderItem: notifier.reorderPage,
            itemBuilder: (context, index) => Container(
              key: ValueKey(state.captures[index].id),
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadii.lg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 18,
                    spreadRadius: -4,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ListTile(
                textColor: Colors.black,
                iconColor: Colors.black,
                leading: const Icon(Icons.description_rounded),
                title: Text(l10n.pageNumber(index + 1)),
                trailing: IconButton(
                  tooltip: l10n.deletePage,
                  onPressed: () => notifier.deletePage(index),
                  icon: const Icon(Icons.delete_outline_rounded),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        if (state.mode != CameraMode.mizQr)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.stage == CameraStage.preview &&
                  state.mode == CameraMode.foodRecognition)
                MizButton.secondary(
                  label: l10n.retake,
                  onPressed: notifier.retakeCurrent,
                ),
              if (state.stage == CameraStage.preview &&
                  state.mode == CameraMode.foodRecognition)
                const SizedBox(width: AppSpacing.md),
              MizButton.primary(
                label: state.mode == CameraMode.menuScan
                    ? l10n.addPage
                    : l10n.capture,
                onPressed: notifier.capture,
              ),
            ],
          ),
        if (state.captures.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          MizButton.secondary(
            label: state.mode == CameraMode.menuScan
                ? l10n.confirmPages
                : l10n.confirm,
            expand: true,
            onPressed: notifier.confirmCapture,
          ),
        ],
      ],
    );
  }
}
