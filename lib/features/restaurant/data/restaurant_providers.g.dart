// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restaurantRepositoryHash() =>
    r'2f04299a173b22b06434e37155b80977f310967b';

/// Exposes the [RestaurantRepository] interface type, not the concrete mock
/// implementation — this is the seam Milestone 6 swaps to Supabase. See
/// docs/ARCHITECTURE.md §4 and ADR-007.
///
/// Copied from [restaurantRepository].
@ProviderFor(restaurantRepository)
final restaurantRepositoryProvider =
    AutoDisposeProvider<RestaurantRepository>.internal(
      restaurantRepository,
      name: r'restaurantRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$restaurantRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RestaurantRepositoryRef = AutoDisposeProviderRef<RestaurantRepository>;
String _$allRestaurantsHash() => r'fd35ca8256ae8eafa2094c64c4716d6450588b7c';

/// See also [allRestaurants].
@ProviderFor(allRestaurants)
final allRestaurantsProvider =
    AutoDisposeFutureProvider<List<Restaurant>>.internal(
      allRestaurants,
      name: r'allRestaurantsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allRestaurantsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllRestaurantsRef = AutoDisposeFutureProviderRef<List<Restaurant>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
