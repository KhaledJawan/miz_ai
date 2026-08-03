import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/camera_models.dart';

class FoodCaptureExperience extends StatelessWidget {
  const FoodCaptureExperience({
    required this.state,
    required this.onCapture,
    required this.onChoosePhoto,
    required this.onAnalyze,
    super.key,
  });

  final CameraWorkflowState state;
  final VoidCallback onCapture;
  final VoidCallback onChoosePhoto;
  final VoidCallback onAnalyze;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final capture = state.captures.isEmpty ? null : state.captures.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.xl),
            child: ColoredBox(
              color: Colors.white,
              child: capture == null
                  ? _EmptyFoodPreview(message: l10n.foodPhotoInstruction)
                  : Image.file(
                      File(capture.path),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _EmptyFoodPreview(
                            message: l10n.menuImageUnavailableBody,
                          ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        MizButton.secondary(
          label: l10n.takePhoto,
          leading: const Icon(Icons.photo_camera_rounded),
          expand: true,
          onPressed: onCapture,
        ),
        const SizedBox(height: AppSpacing.sm),
        MizButton.secondary(
          label: l10n.choosePhoto,
          leading: const Icon(Icons.photo_library_outlined),
          expand: true,
          onPressed: onChoosePhoto,
        ),
        if (capture != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.foodUploadConsent,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.mizColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          MizButton.primary(
            label: l10n.identifyFood,
            leading: const Icon(Icons.auto_awesome_rounded),
            expand: true,
            onPressed: onAnalyze,
          ),
        ],
      ],
    );
  }
}

class _EmptyFoodPreview extends StatelessWidget {
  const _EmptyFoodPreview({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.xxl),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.restaurant_rounded,
          size: 88,
          color: context.mizColors.accent,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
        ),
      ],
    ),
  );
}

class FoodRecognitionResults extends StatelessWidget {
  const FoodRecognitionResults({
    required this.overview,
    required this.candidates,
    required this.onReset,
    super.key,
  });

  final String overview;
  final List<FoodRecognitionCandidate> candidates;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MizResultCard(
          title: l10n.foodRecognizedTitle,
          body: overview,
          icon: Icons.auto_awesome_rounded,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.possibleMatchesTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final candidate in candidates) ...[
          MizGlassSurface(
            level: MizGlassLevel.secondary,
            prominent: true,
            borderRadius: AppRadii.lg,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        candidate.name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.black),
                      ),
                    ),
                    Text(
                      l10n.foodConfidence((candidate.confidence * 100).round()),
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
                if (candidate.description.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    candidate.description,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Text(
          l10n.foodRecognitionDisclaimer,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.mizColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        MizButton.secondary(
          label: l10n.scanAnotherFood,
          expand: true,
          onPressed: onReset,
        ),
      ],
    );
  }
}
