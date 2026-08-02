// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodProfileRepositoryHash() =>
    r'8f7c081f6389261fd247e9c1dde63c5d5d949792';

/// Exposes the interface type only — swapping the Drift-backed
/// implementation later never touches a call site (CLAUDE.md §7).
///
/// Copied from [foodProfileRepository].
@ProviderFor(foodProfileRepository)
final foodProfileRepositoryProvider = Provider<FoodProfileRepository>.internal(
  foodProfileRepository,
  name: r'foodProfileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$foodProfileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodProfileRepositoryRef = ProviderRef<FoodProfileRepository>;
String _$interactionTrackerHash() =>
    r'b98de876216bb4f2442b4287bfc045b66e411e50';

/// See also [interactionTracker].
@ProviderFor(interactionTracker)
final interactionTrackerProvider = Provider<InteractionTracker>.internal(
  interactionTracker,
  name: r'interactionTrackerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$interactionTrackerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InteractionTrackerRef = ProviderRef<InteractionTracker>;
String _$foodEligibilityServiceHash() =>
    r'6b8979a8d560f512d702efc21ad9f76c20be3a99';

/// See also [foodEligibilityService].
@ProviderFor(foodEligibilityService)
final foodEligibilityServiceProvider =
    AutoDisposeProvider<FoodEligibilityService>.internal(
      foodEligibilityService,
      name: r'foodEligibilityServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodEligibilityServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodEligibilityServiceRef =
    AutoDisposeProviderRef<FoodEligibilityService>;
String _$profileCompletenessServiceHash() =>
    r'c8954dc465875791cdc921316326ee096b1194b9';

/// See also [profileCompletenessService].
@ProviderFor(profileCompletenessService)
final profileCompletenessServiceProvider =
    AutoDisposeProvider<ProfileCompletenessService>.internal(
      profileCompletenessService,
      name: r'profileCompletenessServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileCompletenessServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileCompletenessServiceRef =
    AutoDisposeProviderRef<ProfileCompletenessService>;
String _$behavioralInferenceServiceHash() =>
    r'2033df8babdac6044e78bc035406a851730d6e81';

/// See also [behavioralInferenceService].
@ProviderFor(behavioralInferenceService)
final behavioralInferenceServiceProvider =
    AutoDisposeProvider<BehavioralInferenceService>.internal(
      behavioralInferenceService,
      name: r'behavioralInferenceServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$behavioralInferenceServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BehavioralInferenceServiceRef =
    AutoDisposeProviderRef<BehavioralInferenceService>;
String _$foodProfileHash() => r'a88ae40a811c4c19df65929f67f4d8f5988e6f57';

/// See also [foodProfile].
@ProviderFor(foodProfile)
final foodProfileProvider = AutoDisposeStreamProvider<FoodProfile>.internal(
  foodProfile,
  name: r'foodProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$foodProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodProfileRef = AutoDisposeStreamProviderRef<FoodProfile>;
String _$allergenCatalogHash() => r'23255bc2c597498aefa9d7da6d04ca6d40c78d8e';

/// See also [allergenCatalog].
@ProviderFor(allergenCatalog)
final allergenCatalogProvider =
    AutoDisposeFutureProvider<List<CatalogEntry>>.internal(
      allergenCatalog,
      name: r'allergenCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allergenCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllergenCatalogRef = AutoDisposeFutureProviderRef<List<CatalogEntry>>;
String _$intoleranceCatalogHash() =>
    r'01ab6e8f60237f6e279a9f400a7eb2c3c2f9ecbd';

/// See also [intoleranceCatalog].
@ProviderFor(intoleranceCatalog)
final intoleranceCatalogProvider =
    AutoDisposeFutureProvider<List<CatalogEntry>>.internal(
      intoleranceCatalog,
      name: r'intoleranceCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$intoleranceCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IntoleranceCatalogRef =
    AutoDisposeFutureProviderRef<List<CatalogEntry>>;
String _$foodRuleCatalogHash() => r'af34c413ca9e484d34da43e8f8283634519e704b';

/// See also [foodRuleCatalog].
@ProviderFor(foodRuleCatalog)
final foodRuleCatalogProvider =
    AutoDisposeFutureProvider<List<CatalogEntry>>.internal(
      foodRuleCatalog,
      name: r'foodRuleCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodRuleCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodRuleCatalogRef = AutoDisposeFutureProviderRef<List<CatalogEntry>>;
String _$cuisineCatalogHash() => r'6d0d25ac0a04606ff9498a8d353cda470e4e494c';

/// See also [cuisineCatalog].
@ProviderFor(cuisineCatalog)
final cuisineCatalogProvider =
    AutoDisposeFutureProvider<List<CatalogEntry>>.internal(
      cuisineCatalog,
      name: r'cuisineCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cuisineCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CuisineCatalogRef = AutoDisposeFutureProviderRef<List<CatalogEntry>>;
String _$flavorAttributeCatalogHash() =>
    r'0efe20bf9a32143cc8f9cb17974183439bfbc496';

/// See also [flavorAttributeCatalog].
@ProviderFor(flavorAttributeCatalog)
final flavorAttributeCatalogProvider =
    AutoDisposeFutureProvider<List<CatalogEntry>>.internal(
      flavorAttributeCatalog,
      name: r'flavorAttributeCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$flavorAttributeCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FlavorAttributeCatalogRef =
    AutoDisposeFutureProviderRef<List<CatalogEntry>>;
String _$ingredientCatalogHash() => r'fde285e134c9b42d654814ea39f598697e0771ea';

/// See also [ingredientCatalog].
@ProviderFor(ingredientCatalog)
final ingredientCatalogProvider =
    AutoDisposeFutureProvider<List<IngredientEntry>>.internal(
      ingredientCatalog,
      name: r'ingredientCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$ingredientCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IngredientCatalogRef =
    AutoDisposeFutureProviderRef<List<IngredientEntry>>;
String _$foodItemCatalogHash() => r'b6e6b65135ef2804f1d7ed3db56ba0d46777ab8f';

/// See also [foodItemCatalog].
@ProviderFor(foodItemCatalog)
final foodItemCatalogProvider =
    AutoDisposeFutureProvider<List<FoodItemEntry>>.internal(
      foodItemCatalog,
      name: r'foodItemCatalogProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodItemCatalogHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodItemCatalogRef = AutoDisposeFutureProviderRef<List<FoodItemEntry>>;
String _$foodProfileSnapshotHash() =>
    r'5db090bb22deeae86f1ac099019a22ee953001dc';

/// Assembles everything [FoodEligibilityService]/[ProfileCompletenessService]
/// need in one read — see [FoodProfileSnapshot].
///
/// Copied from [foodProfileSnapshot].
@ProviderFor(foodProfileSnapshot)
final foodProfileSnapshotProvider =
    AutoDisposeFutureProvider<FoodProfileSnapshot>.internal(
      foodProfileSnapshot,
      name: r'foodProfileSnapshotProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodProfileSnapshotHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FoodProfileSnapshotRef =
    AutoDisposeFutureProviderRef<FoodProfileSnapshot>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
