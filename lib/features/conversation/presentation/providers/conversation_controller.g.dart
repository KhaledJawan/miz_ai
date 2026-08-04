// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationServiceHash() =>
    r'2196800f918e0f95bd02280eeb51a8322815db3f';

/// See also [conversationService].
@ProviderFor(conversationService)
final conversationServiceProvider =
    AutoDisposeProvider<ConversationService>.internal(
      conversationService,
      name: r'conversationServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConversationServiceRef = AutoDisposeProviderRef<ConversationService>;
String _$transientPositionReaderHash() =>
    r'a84dc279a5e2014bd96fdd6258d08b3a17d66830';

/// Overridable seam so tests never touch the real Geolocator platform
/// channel — `TransientPositionReader` itself already fails safe (returns
/// `null`) on any real device/permission error, but a test environment
/// has no platform channel to answer at all.
///
/// Copied from [transientPositionReader].
@ProviderFor(transientPositionReader)
final transientPositionReaderProvider =
    AutoDisposeProvider<TransientPositionReader>.internal(
      transientPositionReader,
      name: r'transientPositionReaderProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transientPositionReaderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransientPositionReaderRef =
    AutoDisposeProviderRef<TransientPositionReader>;
String _$foodProfileAiContextForRequestHash() =>
    r'7a4eafe2e56a4d69783fcdef4048ee9efef8c68a';

/// See also [FoodProfileAiContextForRequest].
@ProviderFor(FoodProfileAiContextForRequest)
final foodProfileAiContextForRequestProvider =
    AutoDisposeAsyncNotifierProvider<
      FoodProfileAiContextForRequest,
      Map<String, dynamic>?
    >.internal(
      FoodProfileAiContextForRequest.new,
      name: r'foodProfileAiContextForRequestProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$foodProfileAiContextForRequestHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FoodProfileAiContextForRequest =
    AutoDisposeAsyncNotifier<Map<String, dynamic>?>;
String _$conversationControllerHash() =>
    r'a89ae56c848bb4717cafad499c74f02531e0d736';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ConversationController
    extends BuildlessAutoDisposeNotifier<ConversationState> {
  late final ConversationLaunchArgs launchArgs;

  ConversationState build(ConversationLaunchArgs launchArgs);
}

/// See also [ConversationController].
@ProviderFor(ConversationController)
const conversationControllerProvider = ConversationControllerFamily();

/// See also [ConversationController].
class ConversationControllerFamily extends Family<ConversationState> {
  /// See also [ConversationController].
  const ConversationControllerFamily();

  /// See also [ConversationController].
  ConversationControllerProvider call(ConversationLaunchArgs launchArgs) {
    return ConversationControllerProvider(launchArgs);
  }

  @override
  ConversationControllerProvider getProviderOverride(
    covariant ConversationControllerProvider provider,
  ) {
    return call(provider.launchArgs);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'conversationControllerProvider';
}

/// See also [ConversationController].
class ConversationControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ConversationController,
          ConversationState
        > {
  /// See also [ConversationController].
  ConversationControllerProvider(ConversationLaunchArgs launchArgs)
    : this._internal(
        () => ConversationController()..launchArgs = launchArgs,
        from: conversationControllerProvider,
        name: r'conversationControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$conversationControllerHash,
        dependencies: ConversationControllerFamily._dependencies,
        allTransitiveDependencies:
            ConversationControllerFamily._allTransitiveDependencies,
        launchArgs: launchArgs,
      );

  ConversationControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.launchArgs,
  }) : super.internal();

  final ConversationLaunchArgs launchArgs;

  @override
  ConversationState runNotifierBuild(
    covariant ConversationController notifier,
  ) {
    return notifier.build(launchArgs);
  }

  @override
  Override overrideWith(ConversationController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConversationControllerProvider._internal(
        () => create()..launchArgs = launchArgs,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        launchArgs: launchArgs,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ConversationController, ConversationState>
  createElement() {
    return _ConversationControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationControllerProvider &&
        other.launchArgs == launchArgs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, launchArgs.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConversationControllerRef
    on AutoDisposeNotifierProviderRef<ConversationState> {
  /// The parameter `launchArgs` of this provider.
  ConversationLaunchArgs get launchArgs;
}

class _ConversationControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ConversationController,
          ConversationState
        >
    with ConversationControllerRef {
  _ConversationControllerProviderElement(super.provider);

  @override
  ConversationLaunchArgs get launchArgs =>
      (origin as ConversationControllerProvider).launchArgs;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
