import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/camera_models.dart';

/// The single review step after a *first*, not-yet-classified capture --
/// one photo, one explicit "Analyze" tap before anything is sent for AI
/// analysis. What happens next (menu vs. single-dish handling) is decided
/// automatically once that tap runs `classify-capture`; the user never
/// has to say which one it is up front.
class CapturePreviewExperience extends StatelessWidget {
  const CapturePreviewExperience({
    required this.capture,
    required this.onRetake,
    required this.onAnalyze,
    super.key,
  });

  final TemporaryCapture capture;
  final VoidCallback onRetake;
  final VoidCallback onAnalyze;

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
            child: ColoredBox(
              color: Colors.white,
              child: Image.file(
                File(capture.path),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 88,
                        color: context.mizColors.accent,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.menuImageUnavailableBody,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        MizButton.secondary(label: l10n.retake, onPressed: onRetake),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.captureUploadConsent,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: context.mizColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.md),
        MizButton.primary(
          label: l10n.analyzePhoto,
          leading: const Icon(Icons.auto_awesome_rounded),
          expand: true,
          onPressed: onAnalyze,
        ),
      ],
    );
  }
}
