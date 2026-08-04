import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/camera_models.dart';
import '../../domain/menu_context_summary.dart';

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
    required this.onAskMiz,
    super.key,
  });

  final MenuAnalysisResult result;
  final VoidCallback onReset;

  /// Navigates to a Stage 4 follow-up chat carrying a deterministic
  /// summary of [result] — see `buildMenuContextSummary`.
  final ValueChanged<String> onAskMiz;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MizResultCard(
          title: l10n.menuExplainedTitle,
          body: l10n.menuExplainedBody(result.dishCount),
          icon: Icons.auto_awesome_rounded,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final category in result.categories) ...[
          Text(category.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          for (final dish in category.dishes) ...[
            _DishCard(dish: dish, currency: result.currency),
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
        MizButton.primary(
          label: l10n.menuAskAboutThisMenu,
          leading: const Icon(Icons.chat_bubble_outline_rounded),
          expand: true,
          onPressed: () => onAskMiz(buildMenuContextSummary(result)),
        ),
        const SizedBox(height: AppSpacing.sm),
        MizButton.secondary(
          label: l10n.scanAnotherMenu,
          expand: true,
          onPressed: onReset,
        ),
      ],
    );
  }
}

class _DishCard extends StatelessWidget {
  const _DishCard({required this.dish, required this.currency});

  final MatchedDish dish;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    final displayName = dish.matchedName ?? dish.extractedName;
    final priceLabel = dish.price == null
        ? null
        : currency == null
        ? dish.price!.toStringAsFixed(2)
        : '${dish.price!.toStringAsFixed(2)} $currency';
    final priceColor = switch (dish.priceIndicator) {
      PriceIndicator.good => colors.priceGood,
      PriceIndicator.high => colors.priceElevated,
      PriceIndicator.veryHigh => colors.error,
      PriceIndicator.unknown => Colors.black,
    };
    final priceSemanticLabel = switch (dish.priceIndicator) {
      PriceIndicator.good => l10n.menuPriceGood,
      PriceIndicator.high => l10n.menuPriceHigh,
      PriceIndicator.veryHigh => l10n.menuPriceVeryHigh,
      PriceIndicator.unknown => '',
    };
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
                  displayName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black),
                ),
              ),
              if (priceLabel != null)
                Semantics(
                  label: priceSemanticLabel.isEmpty
                      ? priceLabel
                      : '$priceLabel — $priceSemanticLabel',
                  child: ExcludeSemantics(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          size: 18,
                          color: priceColor,
                        ),
                        Text(
                          priceLabel,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          if (dish.shortDescription != null &&
              dish.shortDescription!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              dish.shortDescription!,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
          if (dish.safetyStatus != null) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _StatusChip(
                  label: switch (dish.safetyStatus!) {
                    DishSafetyStatus.safe => l10n.menuDishSafe,
                    DishSafetyStatus.warning => l10n.menuDishWarning,
                    DishSafetyStatus.restricted => l10n.menuDishRestricted,
                  },
                  color: switch (dish.safetyStatus!) {
                    DishSafetyStatus.safe => colors.success,
                    DishSafetyStatus.warning => colors.accent2,
                    DishSafetyStatus.restricted => colors.error,
                  },
                ),
              ],
            ),
          ],
          if (dish.safetyReasons.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            for (final reason in dish.safetyReasons)
              Text(
                '• ${_reasonLabel(l10n, reason.code)}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
              ),
          ],
        ],
      ),
    );
  }

  String _reasonLabel(AppLocalizations l10n, String code) => switch (code) {
    'notHalal' => l10n.menuReasonNotHalal,
    'halalUncertain' => l10n.menuReasonHalalUncertain,
    'halalUnknown' => l10n.menuReasonHalalUnknown,
    'halalPreferenceNotMet' => l10n.menuReasonHalalPreferenceNotMet,
    'notVegan' => l10n.menuReasonNotVegan,
    'veganUncertain' => l10n.menuReasonVeganUncertain,
    'notVegetarian' => l10n.menuReasonNotVegetarian,
    'vegetarianUncertain' => l10n.menuReasonVegetarianUncertain,
    'containsAlcohol' => l10n.menuReasonContainsAlcohol,
    'mayContainAlcohol' => l10n.menuReasonMayContainAlcohol,
    'alcoholUnknown' => l10n.menuReasonAlcoholUnknown,
    'allergensNotVerifiable' => l10n.menuReasonAllergensNotVerifiable,
    _ => code,
  };
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: 4,
    ),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(AppRadii.full),
    ),
    child: Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w600),
    ),
  );
}
