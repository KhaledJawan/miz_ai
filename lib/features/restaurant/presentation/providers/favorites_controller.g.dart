// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesControllerHash() =>
    r'928adcf52ba02ebf04b69a854edc4107c0c7cc3e';

/// Compatibility controller for restaurant favorite call sites. It now reads
/// and writes the same Drift-backed saved-items repository as Bookmarks.
///
/// Copied from [FavoritesController].
@ProviderFor(FavoritesController)
final favoritesControllerProvider =
    NotifierProvider<FavoritesController, Set<String>>.internal(
      FavoritesController.new,
      name: r'favoritesControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesController = Notifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
