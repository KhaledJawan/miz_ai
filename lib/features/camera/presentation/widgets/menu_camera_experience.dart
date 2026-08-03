import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/camera_models.dart';

class MenuCaptureExperience extends StatelessWidget {
  const MenuCaptureExperience({
    required this.state,
    required this.onCapture,
    required this.onChoosePhoto,
    required this.onDelete,
    required this.onReorder,
    required this.onAnalyze,
    super.key,
  });

  final CameraWorkflowState state;
  final VoidCallback onCapture;
  final VoidCallback onChoosePhoto;
  final ValueChanged<int> onDelete;
  final ReorderCallback onReorder;
  final VoidCallback onAnalyze;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final activeIndex = state.activeCaptureIndex;
    final activeCapture =
        activeIndex != null &&
            activeIndex >= 0 &&
            activeIndex < state.captures.length
        ? state.captures[activeIndex]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.xl),
            child: ColoredBox(
              color: Colors.white,
              child: activeCapture == null
                  ? _EmptyMenuPreview(message: l10n.menuPhotoInstruction)
                  : Image.file(
                      File(activeCapture.path),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _EmptyMenuPreview(
                            message: l10n.menuImageUnavailableBody,
                          ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
          ],
        ),
        if (state.captures.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.menuPagesTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.captures.length,
            onReorderItem: onReorder,
            itemBuilder: (context, index) => _MenuPageTile(
              key: ValueKey(state.captures[index].id),
              capture: state.captures[index],
              label: l10n.pageNumber(index + 1),
              deleteLabel: l10n.deletePage,
              onDelete: () => onDelete(index),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.menuUploadConsent,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.mizColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          MizButton.primary(
            label: l10n.explainMenu,
            leading: const Icon(Icons.auto_awesome_rounded),
            expand: true,
            onPressed: onAnalyze,
          ),
        ],
      ],
    );
  }
}

class _EmptyMenuPreview extends StatelessWidget {
  const _EmptyMenuPreview({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.xxl),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.document_scanner_outlined,
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

class _MenuPageTile extends StatelessWidget {
  const _MenuPageTile({
    required this.capture,
    required this.label,
    required this.deleteLabel,
    required this.onDelete,
    super.key,
  });

  final TemporaryCapture capture;
  final String label;
  final String deleteLabel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.14),
          blurRadius: 18,
          spreadRadius: -5,
          offset: const Offset(0, 9),
        ),
      ],
    ),
    child: ListTile(
      textColor: Colors.black,
      iconColor: Colors.black,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.sm),
        child: Image.file(
          File(capture.path),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox(
            width: 48,
            height: 48,
            child: Icon(Icons.description_outlined),
          ),
        ),
      ),
      title: Text(label),
      trailing: IconButton(
        tooltip: deleteLabel,
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    ),
  );
}

class MenuAnalysisResults extends StatelessWidget {
  const MenuAnalysisResults({
    required this.result,
    required this.onReset,
    super.key,
  });

  final MenuAnalysisResult result;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MizResultCard(
          title: l10n.menuExplainedTitle,
          body: result.overview,
          icon: Icons.auto_awesome_rounded,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final section in result.sections) ...[
          Text(section.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          for (final item in section.items) ...[
            _MenuItemCard(item: item),
            const SizedBox(height: AppSpacing.md),
          ],
          const SizedBox(height: AppSpacing.sm),
        ],
        if (result.notes.isNotEmpty) ...[
          MizGlassSurface(
            level: MizGlassLevel.secondary,
            prominent: true,
            borderRadius: AppRadii.lg,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.menuNotesTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final note in result.notes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text(
                      '• $note',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        Text(
          l10n.menuAllergenDisclaimer,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.mizColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        MizButton.secondary(
          label: l10n.scanAnotherMenu,
          expand: true,
          onPressed: onReset,
        ),
      ],
    );
  }
}

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({required this.item});

  final MenuItemExplanation item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MizGlassSurface(
      level: MizGlassLevel.secondary,
      prominent: true,
      borderRadius: AppRadii.lg,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black),
                ),
              ),
              if (item.price != null && item.price!.isNotEmpty)
                Text(
                  item.price!,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.black),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(item.explanation, style: const TextStyle(color: Colors.black87)),
          if (item.dietaryTags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final tag in item.dietaryTags)
                  Chip(
                    label: Text(tag),
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                  ),
              ],
            ),
          ],
          if (item.possibleAllergens.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.possibleAllergens(item.possibleAllergens.join(', ')),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: context.mizColors.error),
            ),
          ],
        ],
      ),
    );
  }
}
