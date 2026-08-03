import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

class MizQrScannerExperience extends StatefulWidget {
  const MizQrScannerExperience({
    required this.onDetected,
    required this.onUnavailable,
    super.key,
  });

  final ValueChanged<String> onDetected;
  final ValueChanged<String> onUnavailable;

  @override
  State<MizQrScannerExperience> createState() => _MizQrScannerExperienceState();
}

class _MizQrScannerExperienceState extends State<MizQrScannerExperience> {
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
    widget.onDetected(raw);
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
                      widget.onUnavailable('QR_SCAN_FAILED'),
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
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(AppRadii.xl),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.scanQrInstruction,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.mizQrOnlyNotice,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
