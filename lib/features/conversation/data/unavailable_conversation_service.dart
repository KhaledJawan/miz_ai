import '../domain/conversation_service.dart';

/// Honest default until Supabase (and therefore the secure `MizAiService`
/// adapter) is configured.
class UnavailableConversationService implements ConversationService {
  const UnavailableConversationService();

  @override
  Future<ConversationReply> respond(ConversationRequest request) {
    throw const ConversationUnavailableException(
      'Supabase is not configured for this build',
    );
  }
}
