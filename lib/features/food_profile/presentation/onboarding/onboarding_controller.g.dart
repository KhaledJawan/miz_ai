// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodProfileOnboardingControllerHash() =>
    r'e916fb5c164782dacba82d19bd96af6dcb79072e';

/// Drives the 11-screen Food Preference Profile onboarding. Persists each
/// screen's answers immediately on `advance()` (small transaction per
/// screen, not one at the end) so progress survives an app restart — on
/// rebuild, [build] hydrates the draft from whatever was already saved and
/// resumes at the saved `onboardingStep`. See docs/DECISIONS.md and
/// CLAUDE.md §7 (no business logic in widgets — every mutation goes
/// through this controller).
///
/// Copied from [FoodProfileOnboardingController].
@ProviderFor(FoodProfileOnboardingController)
final foodProfileOnboardingControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      FoodProfileOnboardingController,
      OnboardingDraftState
    >.internal(
      FoodProfileOnboardingController.new,
      name: r'foodProfileOnboardingControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodProfileOnboardingControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FoodProfileOnboardingController =
    AutoDisposeAsyncNotifier<OnboardingDraftState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
