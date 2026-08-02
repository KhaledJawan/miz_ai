// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesControllerHash() =>
    r'c9e1ef99479fc4a33f2623747fd42cee99258465';

/// Session-only favorites (bookmark) state. Persisted to Supabase
/// `bookmarks` from Milestone 6 onward — see docs/DATABASE.md.
///
/// Copied from [FavoritesController].
@ProviderFor(FavoritesController)
final favoritesControllerProvider =
    AutoDisposeNotifierProvider<FavoritesController, Set<String>>.internal(
      FavoritesController.new,
      name: r'favoritesControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesController = AutoDisposeNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
