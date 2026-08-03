import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/drift_conversation_history_repository.dart';
import '../../domain/conversation_history_repository.dart';
import '../../domain/conversation_models.dart';

part 'conversation_history_providers.g.dart';

@riverpod
ConversationHistoryRepository conversationHistoryRepository(
  ConversationHistoryRepositoryRef ref,
) => DriftConversationHistoryRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<ConversationArchive>> conversationHistory(
  ConversationHistoryRef ref,
) => ref.watch(conversationHistoryRepositoryProvider).watchAll();
