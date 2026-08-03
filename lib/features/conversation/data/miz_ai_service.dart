import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:supabase_flutter/supabase_flutter.dart'
    show FunctionException, FunctionsClient;

import '../../../core/logging/app_logger.dart';
import '../domain/conversation_models.dart';
import '../domain/conversation_service.dart';

/// The real `ConversationService` adapter: calls the `miz-ai` Supabase
/// Edge Function via `supabase_flutter`'s Functions client — never Gemini
/// or Google Places directly (see docs/API.md §3, CLAUDE.md §11). A signed-in
/// user's JWT is attached automatically by the client SDK; a guest sends
/// none, which the function treats as anonymous. Depends on `FunctionsClient`
/// directly (not the whole `SupabaseClient`) so it's mockable in tests
/// without constructing a full Supabase client.
class MizAiService implements ConversationService {
  const MizAiService({required this.functionsClient});

  final FunctionsClient functionsClient;

  static const _functionName = 'miz-ai';

  @override
  Future<ConversationReply> respond(ConversationRequest request) async {
    final body = <String, dynamic>{
      'message': request.message,
      'locale': request.locale,
      if (request.conversationId != null)
        'conversationId': request.conversationId,
      'history': [
        for (final message in request.history)
          {
            'role': message.author == ConversationAuthor.user
                ? 'user'
                : 'assistant',
            'text': message.text,
          },
      ],
      if (request.location != null) 'location': request.location!.toJson(),
      if (request.selectedCity != null)
        'selectedCity': request.selectedCity!.toJson(),
      if (request.foodProfileContext != null)
        'foodProfileContext': request.foodProfileContext,
    };

    if (kDebugMode) {
      // Request content itself is not logged (message text, food profile,
      // precise coordinates) — only shape/presence, enough to diagnose a
      // server-side INVALID_REQUEST without exposing user content.
      AppLogger.warning(
        'miz-ai request: messageLength=${request.message.length} '
        'locale=${request.locale} conversationId=${request.conversationId} '
        'historyLength=${request.history.length} '
        'hasLocation=${request.location != null} '
        'selectedCity=${request.selectedCity == null ? null : {
          'name': request.selectedCity!.name,
          'latitude': request.selectedCity!.latitude,
          'longitude': request.selectedCity!.longitude,
        }} '
        'foodProfileContextKeys=${request.foodProfileContext?.keys.toList()}',
      );
    }
    try {
      final response = await functionsClient.invoke(_functionName, body: body);
      final json = _asResponseJson(response.data);
      _throwStructuredErrorIfPresent(json);
      return _replyFromJson(json);
    } on FunctionException catch (error) {
      _throwTyped(error);
    } on TimeoutException {
      throw const ConversationAiException(
        'AI_TIMEOUT',
        'The request timed out.',
      );
    } on SocketException catch (error) {
      // The server may well have already answered — this only means the
      // connection was lost/never established on the client's end, not
      // that the request failed backend-side. See AiResponseFormatException
      // for the (different) case where a response body did arrive but
      // couldn't be parsed.
      throw ConversationUnavailableException('network error: $error');
    }
  }

  /// A 2xx status always means the Edge Function ran to completion — see
  /// `supabase/functions/miz-ai/index.ts`, which only ever returns
  /// `Response.json(...)`. `FunctionsClient.invoke` only decodes JSON when
  /// it reads a `Content-Type: application/json` response header though; if
  /// a proxy/gateway hop between the client and Supabase rewrites or drops
  /// that header, `response.data` arrives here as a raw `String` instead of
  /// a `Map` even though the server sent well-formed JSON. Recover by
  /// decoding it manually before giving up — this is the difference between
  /// silently discarding a real answer and just working around a header
  /// quirk.
  Map<String, dynamic> _asResponseJson(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } on FormatException {
        // Falls through to the diagnostic exception below.
      }
    }
    final preview = data.toString();
    throw AiResponseFormatException(
      data.runtimeType.toString(),
      preview.length > 200 ? '${preview.substring(0, 200)}...' : preview,
    );
  }

  ConversationReply _replyFromJson(Map<String, dynamic> json) {
    return ConversationReply(
      text: json['message'] as String? ?? '',
      places: _placesFrom(json['places']),
      toolExecutions: _toolExecutionsFrom(json['toolExecutions']),
      requiresLocation: json['requiresLocation'] as bool? ?? false,
      requiresClarification: json['requiresClarification'] as bool? ?? false,
      clarificationQuestion: json['clarificationQuestion'] as String?,
      conversationId: json['conversationId'] as String?,
    );
  }

  List<AiPlace> _placesFrom(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((entry) => AiPlace.fromJson(Map<String, dynamic>.from(entry)))
        .toList();
  }

  List<AiToolExecution> _toolExecutionsFrom(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(
          (entry) => AiToolExecution.fromJson(Map<String, dynamic>.from(entry)),
        )
        .toList();
  }

  Never _throwTyped(FunctionException error) {
    final details = error.details;
    if (details is Map) {
      final json = Map<String, dynamic>.from(details);
      _throwStructuredErrorIfPresent(json);
      if (json['error'] is Map) {
        final errorMap = Map<String, dynamic>.from(json['error'] as Map);
        final code = errorMap['code'] as String? ?? 'SERVER_ERROR';
        final message =
            errorMap['message'] as String? ?? 'Something went wrong.';
        throw ConversationAiException(code, message);
      }
    }
    throw ConversationAiException(
      'SERVER_ERROR',
      'Something went wrong (${error.status}).',
    );
  }

  void _throwStructuredErrorIfPresent(Map<String, dynamic> json) {
    if (json['success'] != false) return;
    final code = json['errorCode'] as String? ?? 'SERVER_ERROR';
    final message = json['userMessage'] as String? ?? 'Something went wrong.';
    throw ConversationAiException(
      code,
      message,
      retryAvailable: json['retryAvailable'] as bool? ?? true,
    );
  }
}
