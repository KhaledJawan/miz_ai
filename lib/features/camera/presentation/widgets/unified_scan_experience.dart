import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// The single unified camera screen: a live QR-watching camera preview
/// (any valid Miz QR code is detected automatically, no tap required) with
/// "Take Photo" / "Choose from Library" always available for a still
/// capture — which is then classified automatically as a menu or a single
/// dish (see `CameraWorkflowController.analyzeCapture`). There is no
/// manual mode picker.
class UnifiedScanExperience extends StatefulWidget {
  const UnifiedScanExperience({
    required this.onQrDetected,
    required this.onQrUnavailable,
    required this.onCapture,
    required this.onChoosePhoto,
    super.key,
  });

  final ValueChanged<String> onQrDetected;
  final ValueChanged<String> onQrUnavailable;
  final VoidCallback onCapture;
  final VoidCallback onChoosePhoto;

  @override
  State<UnifiedScanExperience> createState() => _UnifiedScanExperienceState();
}

class _UnifiedScanExperienceState extends State<UnifiedScanExperience> {
  late final MobileScannerController _controller;
  bool _handlingDetection = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoZoom: true,
    );
  }

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handlingDetection) return;
    String? raw;
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;
      if (value != null && value.isNotEmpty) {
        raw = value;
        break;
      }
    }
    if (raw == null) return;
    _handlingDetection = true;
    await _controller.stop();
    widget.onQrDetected(raw);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.xl),
            child: Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _controller,
                  tapToFocus: true,
                  onDetect: _onDetect,
                  onDetectError: (error, stackTrace) =>
                      widget.onQrUnavailable('QR_SCAN_FAILED'),
                  errorBuilder: (context, error) => MizResultCard(
                    title: l10n.qrScannerUnavailableTitle,
                    body: l10n.qrScannerUnavailableBody,
                    icon: Icons.no_photography_rounded,
                  ),
                  placeholderBuilder: (context) => const ColoredBox(
                    color: Colors.black,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                ),
                PositionedDirectional(
                  start: AppSpacing.xl,
                  end: AppSpacing.xl,
                  bottom: AppSpacing.xl,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Text(
                          l10n.scanUnifiedInstruction,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        MizButton.primary(
          label: l10n.takePhoto,
          leading: const Icon(Icons.photo_camera_rounded),
          expand: true,
          onPressed: widget.onCapture,
        ),
        const SizedBox(height: AppSpacing.sm),
        MizButton.secondary(
          label: l10n.choosePhoto,
          leading: const Icon(Icons.photo_library_outlined),
          expand: true,
          onPressed: widget.onChoosePhoto,
        ),
      ],
    );
  }
}
