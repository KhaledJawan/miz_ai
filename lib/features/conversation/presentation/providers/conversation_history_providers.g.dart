// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationHistoryRepositoryHash() =>
    r'0c00b5d79a43429a182c805f1fa7c7db56a83ee5';

/// See also [conversationHistoryRepository].
@ProviderFor(conversationHistoryRepository)
final conversationHistoryRepositoryProvider =
    AutoDisposeProvider<ConversationHistoryRepository>.internal(
      conversationHistoryRepository,
      name: r'conversationHistoryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationHistoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConversationHistoryRepositoryRef =
    AutoDisposeProviderRef<ConversationHistoryRepository>;
String _$conversationHistoryHash() =>
    r'7b0ce657ff69309c586698e9eaced21845d37f59';

/// See also [conversationHistory].
@ProviderFor(conversationHistory)
final conversationHistoryProvider =
    AutoDisposeStreamProvider<List<ConversationArchive>>.internal(
      conversationHistory,
      name: r'conversationHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConversationHistoryRef =
    AutoDisposeStreamProviderRef<List<ConversationArchive>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
