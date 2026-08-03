import 'conversation_models.dart';

abstract interface class ConversationHistoryRepository {
  Stream<List<ConversationArchive>> watchAll();
  Future<void> save(ConversationArchive archive);
  Future<void> delete(String id);
}
