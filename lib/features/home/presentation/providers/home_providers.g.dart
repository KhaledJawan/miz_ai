// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentGreetingHash() => r'8403fcb9d99982bff00eca5bb0ffe06da3b0c28e';

/// See also [currentGreeting].
@ProviderFor(currentGreeting)
final currentGreetingProvider = AutoDisposeProvider<Greeting>.internal(
  currentGreeting,
  name: r'currentGreetingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentGreetingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentGreetingRef = AutoDisposeProviderRef<Greeting>;
String _$nearbyRestaurantsHash() => r'ffb0fb1809c3a910ad586874ee71a3534aaca460';

/// See also [nearbyRestaurants].
@ProviderFor(nearbyRestaurants)
final nearbyRestaurantsProvider =
    AutoDisposeFutureProvider<List<Restaurant>>.internal(
      nearbyRestaurants,
      name: r'nearbyRestaurantsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$nearbyRestaurantsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NearbyRestaurantsRef = AutoDisposeFutureProviderRef<List<Restaurant>>;
String _$favoriteRestaurantsHash() =>
    r'60d03b4ee47ddb462484ea51f8e8fe596bc4dadc';

/// See also [favoriteRestaurants].
@ProviderFor(favoriteRestaurants)
final favoriteRestaurantsProvider =
    AutoDisposeFutureProvider<List<Restaurant>>.internal(
      favoriteRestaurants,
      name: r'favoriteRestaurantsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoriteRestaurantsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteRestaurantsRef = AutoDisposeFutureProviderRef<List<Restaurant>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
