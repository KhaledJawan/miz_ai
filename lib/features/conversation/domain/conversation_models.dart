enum ConversationStatus {
  idle,
  loading,
  unavailable,
  timeout,
  rateLimited,
  placesUnavailable,
  noResults,
  error,
}

enum ConversationAuthor { user, miz }

/// A real place returned by the `search_nearby_places` tool, already
/// normalized server-side — see `supabase/functions/miz-ai/types.ts`
/// `NormalizedPlace`. Never fabricated client-side.
class AiPlace {
  const AiPlace({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.reviewCount,
    this.openNow,
    this.primaryType,
    this.types = const [],
    this.distanceMeters,
  });

  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double? rating;
  final int? reviewCount;
  final bool? openNow;
  final String? primaryType;
  final List<String> types;
  final int? distanceMeters;

  factory AiPlace.fromJson(Map<String, dynamic> json) => AiPlace(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String? ?? '',
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    rating: (json['rating'] as num?)?.toDouble(),
    reviewCount: json['reviewCount'] as int?,
    openNow: json['openNow'] as bool?,
    primaryType: json['primaryType'] as String?,
    types: (json['types'] as List<dynamic>? ?? const <dynamic>[])
        .map((e) => e as String)
        .toList(),
    distanceMeters: json['distanceMeters'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    if (rating != null) 'rating': rating,
    if (reviewCount != null) 'reviewCount': reviewCount,
    if (openNow != null) 'openNow': openNow,
    if (primaryType != null) 'primaryType': primaryType,
    'types': types,
    if (distanceMeters != null) 'distanceMeters': distanceMeters,
  };
}

/// Internal-only record of which backend tool ran and whether it
/// succeeded. Never rendered to the user (CLAUDE.md AI rules /
/// docs/API.md §3) — kept for future diagnostics.
class AiToolExecution {
  const AiToolExecution({required this.name, required this.status});

  final String name;
  final String status;

  factory AiToolExecution.fromJson(Map<String, dynamic> json) =>
      AiToolExecution(
        name: json['name'] as String,
        status: json['status'] as String,
      );
}

class ConversationMessage {
  const ConversationMessage({
    required this.id,
    required this.author,
    required this.text,
    this.places = const [],
  });

  final String id;
  final ConversationAuthor author;
  final String text;
  final List<AiPlace> places;

  factory ConversationMessage.fromJson(Map<String, dynamic> json) =>
      ConversationMessage(
        id: json['id'] as String,
        author: ConversationAuthor.values.firstWhere(
          (author) => author.name == json['author'],
          orElse: () => ConversationAuthor.miz,
        ),
        text: json['text'] as String? ?? '',
        places: (json['places'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(AiPlace.fromJson)
            .toList(growable: false),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'author': author.name,
    'text': text,
    'places': places.map((place) => place.toJson()).toList(growable: false),
  };
}

class ConversationArchive {
  const ConversationArchive({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    this.remoteConversationId,
  });

  final String id;
  final String title;
  final List<ConversationMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? remoteConversationId;
}

/// A precise device position, used transiently for a single request and
/// never persisted — see `TransientPositionReader`.
class ConversationLocation {
  const ConversationLocation({
    required this.latitude,
    required this.longitude,
    this.accuracyMeters,
  });

  final double latitude;
  final double longitude;
  final double? accuracyMeters;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    if (accuracyMeters != null) 'accuracyMeters': accuracyMeters,
  };
}

/// The user's manually/recently selected city, with known coordinates —
/// see `city_coordinates.dart`.
class ConversationCity {
  const ConversationCity({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  };
}

/// Everything sent to the miz-ai Edge Function for one turn. History is
/// bounded by the caller (`ConversationController`) before this is built —
/// this type does not enforce a limit itself.
class ConversationRequest {
  const ConversationRequest({
    required this.message,
    required this.locale,
    this.conversationId,
    this.history = const [],
    this.location,
    this.selectedCity,
    this.foodProfileContext,
  });

  final String message;
  final String locale;
  final String? conversationId;
  final List<ConversationMessage> history;
  final ConversationLocation? location;
  final ConversationCity? selectedCity;
  final Map<String, dynamic>? foodProfileContext;
}

class ConversationReply {
  const ConversationReply({
    required this.text,
    this.places = const [],
    this.toolExecutions = const [],
    this.requiresLocation = false,
    this.requiresClarification = false,
    this.clarificationQuestion,
    this.conversationId,
  });

  final String text;
  final List<AiPlace> places;
  final List<AiToolExecution> toolExecutions;
  final bool requiresLocation;
  final bool requiresClarification;
  final String? clarificationQuestion;
  final String? conversationId;
}

/// The AI backend itself could not be reached at all — Supabase isn't
/// configured for this build, or the network connection failed/dropped
/// before a response was received. Never thrown for a response the backend
/// actually sent back (see [AiResponseFormatException] for that case).
class ConversationUnavailableException implements Exception {
  const ConversationUnavailableException([this.reason]);

  /// Debug-only detail (e.g. the underlying `SocketException`). Never
  /// shown to users — see `ConversationState.debugErrorDetail`.
  final String? reason;

  @override
  String toString() => reason == null
      ? 'ConversationUnavailableException'
      : 'ConversationUnavailableException: $reason';
}

/// The Edge Function responded (a 2xx status), but the body could not be
/// understood as the documented `MizAiResponse` JSON shape — e.g. a proxy
/// hop rewrote `Content-Type` away from `application/json` so the HTTP
/// client decoded the body as a raw string instead of a Map. Distinct from
/// [ConversationUnavailableException] because the backend genuinely
/// answered; only the client failed to parse that answer.
class AiResponseFormatException implements Exception {
  const AiResponseFormatException(this.receivedType, this.preview);

  final String receivedType;
  final String preview;

  @override
  String toString() =>
      "AiResponseFormatException(receivedType: $receivedType, preview: '$preview')";
}

class ConversationState {
  const ConversationState({
    this.messages = const [],
    this.status = ConversationStatus.idle,
    this.conversationId,
    this.requiresLocation = false,
    this.retryAvailable = true,
    this.debugErrorCode,
    this.debugErrorDetail,
    this.localArchiveId,
    this.createdAt,
  });

  final List<ConversationMessage> messages;
  final ConversationStatus status;
  final String? conversationId;
  final bool requiresLocation;
  final bool retryAvailable;

  /// The originating `miz-ai` error code (e.g. `AI_TIMEOUT`) or, for an
  /// unclassified exception, its runtime type. Never shown to users in a
  /// release build — see `_ConversationStatusObject` (debug-mode only).
  final String? debugErrorCode;

  /// `Exception.toString()` of the exception that produced [status], kept
  /// only for the same debug-mode surface as [debugErrorCode].
  final String? debugErrorDetail;
  final String? localArchiveId;
  final DateTime? createdAt;

  ConversationState copyWith({
    List<ConversationMessage>? messages,
    ConversationStatus? status,
    String? conversationId,
    bool? requiresLocation,
    bool? retryAvailable,
    String? debugErrorCode,
    String? debugErrorDetail,
    String? localArchiveId,
    DateTime? createdAt,
  }) => ConversationState(
    messages: messages ?? this.messages,
    status: status ?? this.status,
    conversationId: conversationId ?? this.conversationId,
    requiresLocation: requiresLocation ?? this.requiresLocation,
    retryAvailable: retryAvailable ?? this.retryAvailable,
    // Deliberately not defaulted to `this.*` — every status transition
    // should explicitly say whether debug detail applies to it, so a new
    // success doesn't silently keep showing a stale previous error.
    debugErrorCode: debugErrorCode,
    debugErrorDetail: debugErrorDetail,
    localArchiveId: localArchiveId ?? this.localArchiveId,
    createdAt: createdAt ?? this.createdAt,
  );
}
