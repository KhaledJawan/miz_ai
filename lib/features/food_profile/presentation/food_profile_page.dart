import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/localization.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/widgets.dart';
import '../domain/catalog_localizations.dart';
import '../domain/entities.dart';
import '../domain/food_profile_enums.dart';
import '../domain/food_profile_snapshot.dart';
import 'onboarding/onboarding_draft_state.dart';
import 'onboarding/steps/allergies_step.dart';
import 'onboarding/steps/cuisines_step.dart';
import 'onboarding/steps/diet_step.dart';
import 'onboarding/steps/eating_style_step.dart';
import 'onboarding/steps/flavors_step.dart';
import 'onboarding/steps/food_rules_step.dart';
import 'onboarding/steps/food_samples_step.dart';
import 'onboarding/steps/intolerances_step.dart';
import 'onboarding/steps/proteins_step.dart';
import 'providers/food_profile_providers.dart';

/// Permanent, always-editable Food Preference Profile surface reached from
/// Settings. Every section reuses the exact onboarding step widget for that
/// question — there is only one implementation of "what proteins do you
/// eat", used both during onboarding and here — but writes go straight to
/// [FoodProfileRepository] on every change rather than through the
/// onboarding draft, since this page has no "continue" step: edits here
/// are permanent the moment they're made, matching "editable forever"
/// from the brief.
class FoodProfilePage extends ConsumerWidget {
  const FoodProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final asyncSnapshot = ref.watch(foodProfileSnapshotProvider);

    return Scaffold(
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
                          l10n.foodProfileTitle,
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
                Expanded(
                  child: asyncSnapshot.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    error: (error, _) => Center(child: Text('$error')),
                    data: (snapshot) => Theme(
                      data: AppTheme.light(),
                      child: _FoodProfileBody(snapshot: snapshot),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodProfileBody extends ConsumerWidget {
  const _FoodProfileBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    final completeness = ref
        .watch(profileCompletenessServiceProvider)
        .compute(snapshot);
    final repository = ref.read(foodProfileRepositoryProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lgPlus,
        AppSpacing.lg,
        AppSpacing.lgPlus,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CompletenessCard(
            completeness: completeness,
            updatedAt: snapshot.profile.updatedAt,
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionLabel(label: l10n.foodProfileSectionsLabel),
          const SizedBox(height: AppSpacing.sm),
          _SettingsGroup(
            children: [
              _SectionRow(
                title: l10n.dietStepTitle,
                value: snapshot.profile.dietType == DietType.unknown
                    ? l10n.reviewNotAnswered
                    : catalogLabel(snapshot.profile.dietType.name, 'en'),
                onTap: () => _openDietEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.foodRulesStepTitle,
                value: _countSummary(l10n, snapshot.foodRules.length),
                onTap: () => _openFoodRulesEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.allergiesStepTitle,
                value: _countSummary(l10n, snapshot.allergies.length),
                emphasize: snapshot.allergies.isNotEmpty,
                onTap: () => _openAllergiesEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.intolerancesStepTitle,
                value: _countSummary(l10n, snapshot.intolerances.length),
                onTap: () => _openIntolerancesEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.proteinsStepTitle,
                value: _countSummary(
                  l10n,
                  snapshot.ingredientPreferences.length,
                ),
                onTap: () => _openIngredientsEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.cuisinesStepTitle,
                value: _countSummary(l10n, snapshot.cuisinePreferences.length),
                onTap: () => _openCuisinesEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.flavorsStepTitle,
                value: _countSummary(l10n, snapshot.flavorPreferences.length),
                onTap: () => _openFlavorsEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.eatingStyleStepTitle,
                value: snapshot.profile.adventurousnessLevel != null
                    ? l10n.reviewAnswered
                    : l10n.reviewNotAnswered,
                onTap: () => _openEatingStyleEditor(context, ref, snapshot),
              ),
              _SectionRow(
                title: l10n.foodSamplesStepTitle,
                value: _countSummary(l10n, snapshot.foodItemPreferences.length),
                onTap: () => _openFoodSamplesEditor(context, ref, snapshot),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionLabel(label: l10n.foodProfilePrivacyLabel),
          const SizedBox(height: AppSpacing.sm),
          _SettingsGroup(
            children: [
              SettingsToggleRow(
                title: l10n.behaviorPersonalizationToggle,
                subtitle: l10n.behaviorPersonalizationHint,
                value: snapshot.profile.personalizationEnabled,
                onChanged: (value) async {
                  await repository.setPersonalizationEnabled(value);
                  ref.invalidate(foodProfileSnapshotProvider);
                },
              ),
              _ActionRow(
                title: l10n.deleteInteractionHistory,
                destructive: true,
                onTap: () => _confirmAndRun(
                  context: context,
                  title: l10n.deleteInteractionHistory,
                  body: l10n.deleteInteractionHistoryConfirmBody,
                  onConfirmed: () async {
                    await repository.deleteInteractionHistory();
                  },
                ),
              ),
              _ActionRow(
                title: l10n.restartOnboardingAction,
                onTap: () => _confirmAndRun(
                  context: context,
                  title: l10n.restartOnboardingAction,
                  body: l10n.restartOnboardingConfirmBody,
                  onConfirmed: () async {
                    await repository.restartOnboarding();
                    ref.invalidate(foodProfileSnapshotProvider);
                    if (context.mounted) context.go(AppRoutes.onboarding);
                  },
                ),
              ),
              _ActionRow(
                title: l10n.resetFoodProfileAction,
                destructive: true,
                onTap: () => _confirmAndRun(
                  context: context,
                  title: l10n.resetFoodProfileAction,
                  body: l10n.resetFoodProfileConfirmBody,
                  onConfirmed: () async {
                    await repository.resetFoodProfile();
                    ref.invalidate(foodProfileSnapshotProvider);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.foodProfilePrivacyNotice,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  String _countSummary(AppLocalizations l10n, int count) =>
      count == 0 ? l10n.reviewNotAnswered : l10n.reviewSelectedCount(count);

  Future<void> _confirmAndRun({
    required BuildContext context,
    required String title,
    required String body,
    required Future<void> Function() onConfirmed,
  }) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(title),
          ),
        ],
      ),
    );
    if (confirmed == true) await onConfirmed();
  }

  void _openDietEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.dietStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _DietEditorBody(snapshot: snapshot),
    );
  }

  void _openFoodRulesEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.foodRulesStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _FoodRulesEditorBody(snapshot: snapshot),
    );
  }

  void _openAllergiesEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.allergiesStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _AllergiesEditorBody(snapshot: snapshot),
    );
  }

  void _openIntolerancesEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.intolerancesStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _IntolerancesEditorBody(snapshot: snapshot),
    );
  }

  void _openIngredientsEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.proteinsStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _IngredientsEditorBody(snapshot: snapshot),
    );
  }

  void _openCuisinesEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.cuisinesStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _CuisinesEditorBody(snapshot: snapshot),
    );
  }

  void _openFlavorsEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.flavorsStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _FlavorsEditorBody(snapshot: snapshot),
    );
  }

  void _openEatingStyleEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.eatingStyleStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _EatingStyleEditorBody(snapshot: snapshot),
    );
  }

  void _openFoodSamplesEditor(
    BuildContext context,
    WidgetRef ref,
    FoodProfileSnapshot snapshot,
  ) {
    _showEditorSheet(
      context,
      title: context.l10n.foodSamplesStepTitle,
      builder: (sheetContext, sheetRef, setSheetState) =>
          _FoodSamplesEditorBody(snapshot: snapshot),
    );
  }

  void _showEditorSheet(
    BuildContext context, {
    required String title,
    required Widget Function(BuildContext, WidgetRef, StateSetter) builder,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _EditorSheetShell(
        title: title,
        child: Consumer(
          builder: (consumerContext, consumerRef, _) => StatefulBuilder(
            builder: (statefulContext, setState) =>
                builder(sheetContext, consumerRef, setState),
          ),
        ),
      ),
    );
  }
}

class _CompletenessCard extends StatelessWidget {
  const _CompletenessCard({
    required this.completeness,
    required this.updatedAt,
  });

  final double completeness;
  final DateTime updatedAt;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.mizColors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: AppShadows.md(colors.shadow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.foodProfileCompletenessLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.full),
            child: LinearProgressIndicator(
              value: completeness,
              minHeight: 6,
              backgroundColor: colors.divider,
              valueColor: AlwaysStoppedAnimation(colors.accent),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.foodProfileLastUpdated(_formatDate(updatedAt)),
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.full),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: Colors.black),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: AppShadows.md(colors.shadow),
      ),
      child: Column(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            children[index],
            if (index < children.length - 1)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: AppSpacing.lg),
                child: Divider(height: 1, color: colors.divider),
              ),
          ],
        ],
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.title,
    required this.value,
    required this.onTap,
    this.emphasize = false,
  });

  final String title;
  final String value;
  final VoidCallback onTap;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: emphasize ? colors.accent : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.title,
    required this.onTap,
    this.destructive = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: destructive ? colors.error : colors.text,
            ),
          ),
        ),
      ),
    );
  }
}

/// Shared toggle row used only within this page — the app-settings sheet
/// has its own [SettingsRow.toggle] with a slightly different shape
/// (single-line, no subtitle), which doesn't fit the longer privacy copy
/// required here.
class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          MizSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _EditorSheetShell extends StatelessWidget {
  const _EditorSheetShell({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    final l10n = context.l10n;
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
        boxShadow: AppShadows.lg(colors.shadow),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lgPlus,
            AppSpacing.md,
            AppSpacing.lgPlus,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: AppSpacing.xxxl,
                  height: AppSpacing.xs,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: colors.neutral300,
                    borderRadius: BorderRadius.circular(AppRadii.full),
                  ),
                ),
              ),
              Flexible(child: SingleChildScrollView(child: child)),
              const SizedBox(height: AppSpacing.lg),
              MizButton.primary(
                label: l10n.doneLabel,
                expand: true,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DietEditorBody extends ConsumerStatefulWidget {
  const _DietEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_DietEditorBody> createState() => _DietEditorBodyState();
}

class _DietEditorBodyState extends ConsumerState<_DietEditorBody> {
  late DietType _value = widget.snapshot.profile.dietType;

  @override
  Widget build(BuildContext context) {
    return DietStep(
      value: _value,
      onChanged: (value) async {
        setState(() => _value = value);
        await ref.read(foodProfileRepositoryProvider).updateDiet(value);
        ref.invalidate(foodProfileSnapshotProvider);
      },
    );
  }
}

class _FoodRulesEditorBody extends ConsumerStatefulWidget {
  const _FoodRulesEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_FoodRulesEditorBody> createState() =>
      _FoodRulesEditorBodyState();
}

class _FoodRulesEditorBodyState extends ConsumerState<_FoodRulesEditorBody> {
  late final Map<int, RequirementLevel> _selections = {
    for (final r in widget.snapshot.foodRules) r.foodRuleId: r.requirementLevel,
  };

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(foodRuleCatalogProvider);
    return catalog.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('$error'),
      data: (entries) => FoodRulesStep(
        catalog: entries,
        selections: _selections,
        onChanged: (id, level) async {
          setState(() {
            if (level == null) {
              _selections.remove(id);
            } else {
              _selections[id] = level;
            }
          });
          final byId = {for (final e in entries) e.id: e.code};
          await ref.read(foodProfileRepositoryProvider).replaceFoodRules([
            for (final entry in _selections.entries)
              UserFoodRuleSelection(
                id: 0,
                foodRuleId: entry.key,
                foodRuleCode: byId[entry.key] ?? '',
                requirementLevel: entry.value,
                source: PreferenceSource.explicit,
              ),
          ]);
          ref.invalidate(foodProfileSnapshotProvider);
        },
      ),
    );
  }
}

AllergyDraft _allergyDraftFromSaved(UserAllergy allergy) => AllergyDraft(
  allergenId: allergy.allergenId,
  customName: allergy.customName,
  severity: allergy.severity,
  notes: allergy.notes,
);

IntoleranceDraft _intoleranceDraftFromSaved(UserIntolerance intolerance) =>
    IntoleranceDraft(
      intoleranceId: intolerance.intoleranceId,
      customName: intolerance.customName,
      severity: intolerance.severity,
    );

class _AllergiesEditorBody extends ConsumerStatefulWidget {
  const _AllergiesEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_AllergiesEditorBody> createState() =>
      _AllergiesEditorBodyState();
}

class _AllergiesEditorBodyState extends ConsumerState<_AllergiesEditorBody> {
  late final Map<String, AllergyDraft> _selections = {
    for (final a in widget.snapshot.allergies)
      _allergyDraftFromSaved(a).key: _allergyDraftFromSaved(a),
  };
  late bool _noKnown = widget.snapshot.allergies.isEmpty;

  Future<void> _persist() async {
    final repository = ref.read(foodProfileRepositoryProvider);
    if (_noKnown) {
      await repository.clearAllergies();
    } else {
      await repository.replaceAllergies([
        for (final draft in _selections.values)
          UserAllergy(
            id: 0,
            allergenId: draft.allergenId,
            customName: draft.customName,
            severity: draft.severity,
            notes: draft.notes,
            isActive: true,
            source: PreferenceSource.explicit,
          ),
      ]);
    }
    ref.invalidate(foodProfileSnapshotProvider);
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(allergenCatalogProvider);
    return catalog.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('$error'),
      data: (entries) => AllergiesStep(
        catalog: entries,
        selections: _selections,
        noKnownAllergies: _noKnown,
        onToggle: (allergen) async {
          final key = 'a${allergen.id}';
          setState(() {
            if (_selections.containsKey(key)) {
              _selections.remove(key);
            } else {
              _selections[key] = AllergyDraft(allergenId: allergen.id);
              _noKnown = false;
            }
          });
          await _persist();
        },
        onSeverityChanged: (key, severity) async {
          final current = _selections[key];
          if (current == null) return;
          setState(
            () => _selections[key] = current.copyWith(severity: severity),
          );
          await _persist();
        },
        onAddCustom: (name) async {
          final draft = AllergyDraft(customName: name);
          setState(() {
            _selections[draft.key] = draft;
            _noKnown = false;
          });
          await _persist();
        },
        onNoKnownAllergiesChanged: (value) async {
          setState(() {
            _noKnown = value;
            if (value) _selections.clear();
          });
          await _persist();
        },
      ),
    );
  }
}

class _IntolerancesEditorBody extends ConsumerStatefulWidget {
  const _IntolerancesEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_IntolerancesEditorBody> createState() =>
      _IntolerancesEditorBodyState();
}

class _IntolerancesEditorBodyState
    extends ConsumerState<_IntolerancesEditorBody> {
  late final Map<String, IntoleranceDraft> _selections = {
    for (final i in widget.snapshot.intolerances)
      _intoleranceDraftFromSaved(i).key: _intoleranceDraftFromSaved(i),
  };
  late bool _noKnown = widget.snapshot.intolerances.isEmpty;

  Future<void> _persist() async {
    await ref.read(foodProfileRepositoryProvider).replaceIntolerances([
      if (!_noKnown)
        for (final draft in _selections.values)
          UserIntolerance(
            id: 0,
            intoleranceId: draft.intoleranceId,
            customName: draft.customName,
            severity: draft.severity ?? AllergySeverity.unspecified,
            isActive: true,
          ),
    ]);
    ref.invalidate(foodProfileSnapshotProvider);
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(intoleranceCatalogProvider);
    return catalog.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('$error'),
      data: (entries) => IntolerancesStep(
        catalog: entries,
        selections: _selections,
        noKnownIntolerances: _noKnown,
        onToggle: (intolerance) async {
          final key = 'i${intolerance.id}';
          setState(() {
            if (_selections.containsKey(key)) {
              _selections.remove(key);
            } else {
              _selections[key] = IntoleranceDraft(
                intoleranceId: intolerance.id,
              );
              _noKnown = false;
            }
          });
          await _persist();
        },
        onNoKnownIntolerancesChanged: (value) async {
          setState(() {
            _noKnown = value;
            if (value) _selections.clear();
          });
          await _persist();
        },
      ),
    );
  }
}

class _IngredientsEditorBody extends ConsumerStatefulWidget {
  const _IngredientsEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_IngredientsEditorBody> createState() =>
      _IngredientsEditorBodyState();
}

class _IngredientsEditorBodyState
    extends ConsumerState<_IngredientsEditorBody> {
  late final Map<int, (PreferenceState, RestrictionType)> _selections = {
    for (final p in widget.snapshot.ingredientPreferences)
      p.ingredientId: (p.preferenceState, p.restrictionType),
  };

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(ingredientCatalogProvider);
    return catalog.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('$error'),
      data: (entries) => ProteinsStep(
        ingredients: entries,
        selections: _selections,
        onChanged: (id, state, restriction) async {
          setState(() => _selections[id] = (state, restriction));
          await ref
              .read(foodProfileRepositoryProvider)
              .upsertIngredientPreference(id, state, restriction);
          ref.invalidate(foodProfileSnapshotProvider);
        },
      ),
    );
  }
}

class _CuisinesEditorBody extends ConsumerStatefulWidget {
  const _CuisinesEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_CuisinesEditorBody> createState() =>
      _CuisinesEditorBodyState();
}

class _CuisinesEditorBodyState extends ConsumerState<_CuisinesEditorBody> {
  late final Map<int, PreferenceState> _selections = {
    for (final c in widget.snapshot.cuisinePreferences)
      c.cuisineId: c.preferenceState,
  };

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(cuisineCatalogProvider);
    return catalog.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('$error'),
      data: (entries) => CuisinesStep(
        catalog: entries,
        selections: _selections,
        onChanged: (id, state) async {
          setState(() => _selections[id] = state);
          await ref
              .read(foodProfileRepositoryProvider)
              .upsertCuisinePreference(id, state);
          ref.invalidate(foodProfileSnapshotProvider);
        },
      ),
    );
  }
}

class _FlavorsEditorBody extends ConsumerStatefulWidget {
  const _FlavorsEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_FlavorsEditorBody> createState() => _FlavorsEditorBodyState();
}

class _FlavorsEditorBodyState extends ConsumerState<_FlavorsEditorBody> {
  late final Map<int, int> _selections = {
    for (final f in widget.snapshot.flavorPreferences)
      f.flavorAttributeId: f.preferenceLevel,
  };

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(flavorAttributeCatalogProvider);
    return catalog.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('$error'),
      data: (entries) => FlavorsStep(
        catalog: entries,
        selections: _selections,
        onChanged: (id, level) async {
          setState(() => _selections[id] = level);
          await ref
              .read(foodProfileRepositoryProvider)
              .upsertFlavorPreference(id, level);
          ref.invalidate(foodProfileSnapshotProvider);
        },
      ),
    );
  }
}

class _EatingStyleEditorBody extends ConsumerStatefulWidget {
  const _EatingStyleEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_EatingStyleEditorBody> createState() =>
      _EatingStyleEditorBodyState();
}

class _EatingStyleEditorBodyState
    extends ConsumerState<_EatingStyleEditorBody> {
  late AdventurousnessLevel? _adventurousness =
      widget.snapshot.profile.adventurousnessLevel;
  late MealWeightPreference? _mealWeight =
      widget.snapshot.profile.preferredMealWeight;
  late BudgetLevel? _budget = widget.snapshot.profile.budgetLevel;
  late List<EatingPriority> _priorities = [
    ...widget.snapshot.profile.topPriorities,
  ];

  Future<void> _persist() async {
    await ref
        .read(foodProfileRepositoryProvider)
        .updateEatingStyle(
          adventurousnessLevel: _adventurousness,
          preferredMealWeight: _mealWeight,
          budgetLevel: _budget,
          topPriorities: _priorities,
        );
    ref.invalidate(foodProfileSnapshotProvider);
  }

  @override
  Widget build(BuildContext context) {
    return EatingStyleStep(
      adventurousnessLevel: _adventurousness,
      preferredMealWeight: _mealWeight,
      budgetLevel: _budget,
      topPriorities: _priorities,
      onAdventurousnessChanged: (value) async {
        setState(() => _adventurousness = value);
        await _persist();
      },
      onMealWeightChanged: (value) async {
        setState(() => _mealWeight = value);
        await _persist();
      },
      onBudgetChanged: (value) async {
        setState(() => _budget = value);
        await _persist();
      },
      onPriorityToggled: (priority) async {
        setState(() {
          final next = [..._priorities];
          if (next.contains(priority)) {
            next.remove(priority);
          } else if (next.length < 3) {
            next.add(priority);
          }
          _priorities = next;
        });
        await _persist();
      },
    );
  }
}

class _FoodSamplesEditorBody extends ConsumerStatefulWidget {
  const _FoodSamplesEditorBody({required this.snapshot});

  final FoodProfileSnapshot snapshot;

  @override
  ConsumerState<_FoodSamplesEditorBody> createState() =>
      _FoodSamplesEditorBodyState();
}

class _FoodSamplesEditorBodyState
    extends ConsumerState<_FoodSamplesEditorBody> {
  late final Map<int, PreferenceState> _selections = {
    for (final p in widget.snapshot.foodItemPreferences)
      p.foodItemId: p.preferenceState,
  };

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(foodItemCatalogProvider);
    final cuisinesAsync = ref.watch(cuisineCatalogProvider);
    if (!itemsAsync.hasValue || !cuisinesAsync.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    final allergenIds = widget.snapshot.activeAllergenIds;
    final excludedIngredientIds = widget.snapshot.restrictedIngredientIds;
    final visibleItems = itemsAsync.requireValue.where((item) {
      if (item.allergenIds.any(allergenIds.contains)) return false;
      if (item.primaryIngredientIds.any(excludedIngredientIds.contains)) {
        return false;
      }
      return true;
    }).toList();

    return FoodSamplesStep(
      items: visibleItems,
      cuisineCatalog: cuisinesAsync.requireValue,
      selections: _selections,
      onChanged: (id, state) async {
        setState(() => _selections[id] = state);
        await ref
            .read(foodProfileRepositoryProvider)
            .upsertFoodItemPreference(id, state);
        ref.invalidate(foodProfileSnapshotProvider);
      },
    );
  }
}
