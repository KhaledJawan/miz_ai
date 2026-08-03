// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarkRepositoryHash() =>
    r'1b932efca0fc61e897aa695d714b68655b47a192';

/// See also [bookmarkRepository].
@ProviderFor(bookmarkRepository)
final bookmarkRepositoryProvider =
    AutoDisposeProvider<BookmarkRepository>.internal(
      bookmarkRepository,
      name: r'bookmarkRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookmarkRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookmarkRepositoryRef = AutoDisposeProviderRef<BookmarkRepository>;
String _$savedItemsHash() => r'5072e9edc9c1ed24e0138bebd28b534c9d3fc847';

/// See also [savedItems].
@ProviderFor(savedItems)
final savedItemsProvider = AutoDisposeStreamProvider<List<SavedItem>>.internal(
  savedItems,
  name: r'savedItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SavedItemsRef = AutoDisposeStreamProviderRef<List<SavedItem>>;
String _$filteredSavedItemsHash() =>
    r'60d7ed7d1cb505f5ec6296ca6df30a257d4a994b';

/// See also [filteredSavedItems].
@ProviderFor(filteredSavedItems)
final filteredSavedItemsProvider =
    AutoDisposeProvider<List<SavedItem>>.internal(
      filteredSavedItems,
      name: r'filteredSavedItemsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredSavedItemsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredSavedItemsRef = AutoDisposeProviderRef<List<SavedItem>>;
String _$savedItemsQueryHash() => r'cb0cbfe25cd474a47fbe962cedbc5a9c38141c84';

/// See also [SavedItemsQuery].
@ProviderFor(SavedItemsQuery)
final savedItemsQueryProvider =
    NotifierProvider<SavedItemsQuery, String>.internal(
      SavedItemsQuery.new,
      name: r'savedItemsQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedItemsQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SavedItemsQuery = Notifier<String>;
String _$savedItemsFilterHash() => r'0aa87bb6c375a8c85b93bbcf88b61cfe11996d5d';

/// See also [SavedItemsFilter].
@ProviderFor(SavedItemsFilter)
final savedItemsFilterProvider =
    NotifierProvider<SavedItemsFilter, SavedItemFilter>.internal(
      SavedItemsFilter.new,
      name: r'savedItemsFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedItemsFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SavedItemsFilter = Notifier<SavedItemFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
