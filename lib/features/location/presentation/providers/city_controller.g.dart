// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationServiceHash() => r'0a0cedbdff445dc3e3e358dc6d5c7449fd214d2c';

/// See also [locationService].
@ProviderFor(locationService)
final locationServiceProvider = AutoDisposeProvider<LocationService>.internal(
  locationService,
  name: r'locationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationServiceRef = AutoDisposeProviderRef<LocationService>;
String _$cityControllerHash() => r'8d222f5c5460e07f6c5b5009a659c2b941b9c997';

/// See also [CityController].
@ProviderFor(CityController)
final cityControllerProvider =
    AsyncNotifierProvider<CityController, CitySelection>.internal(
      CityController.new,
      name: r'cityControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cityControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CityController = AsyncNotifier<CitySelection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
