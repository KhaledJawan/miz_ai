import 'conversation_models.dart';

export 'conversation_models.dart'
    show
        AiResponseFormatException,
        ConversationReply,
        ConversationRequest,
        ConversationUnavailableException;

/// Thrown for every documented miz-ai error code other than the generic
/// "unavailable" case (which keeps using [ConversationUnavailableException]
/// for backward compatibility with the existing unavailable-adapter UI
/// state). See `supabase/functions/miz-ai/errors.ts` for the source of
/// truth on these codes.
class ConversationAiException implements Exception {
  const ConversationAiException(
    this.code,
    this.message, {
    this.retryAvailable = true,
  });

  final String code;
  final String message;
  final bool retryAvailable;
}

abstract interface class ConversationService {
  Future<ConversationReply> respond(ConversationRequest request);
}
