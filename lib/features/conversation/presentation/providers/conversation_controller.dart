import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../food_profile/domain/food_profile_ai_context.dart';
import '../../../food_profile/presentation/providers/food_profile_providers.dart';
import '../../../location/data/transient_position_reader.dart';
import '../../../location/domain/city_coordinates.dart';
import '../../../location/presentation/providers/city_controller.dart';
import '../../../profile_settings/presentation/providers/app_settings_controller.dart';
import '../../data/miz_ai_service.dart';
import '../../data/unavailable_conversation_service.dart';
import '../../domain/conversation_models.dart';
import '../../domain/conversation_service.dart';
import 'conversation_history_providers.dart';

part 'conversation_controller.g.dart';

/// Bounded so a long-running chat never resends unlimited history — must
/// stay <= the Edge Function's own `MAX_HISTORY_TURNS` (see
/// supabase/functions/miz-ai/request_schema.ts).
const _maxHistoryTurns = 12;

@riverpod
ConversationService conversationService(ConversationServiceRef ref) {
  final isSupabaseConfigured = AppConfig.fromEnvironment().supabase != null;
  if (!isSupabaseConfigured) return const UnavailableConversationService();
  return MizAiService(functionsClient: Supabase.instance.client.functions);
}

/// Overridable seam so tests never touch the real Geolocator platform
/// channel — `TransientPositionReader` itself already fails safe (returns
/// `null`) on any real device/permission error, but a test environment
/// has no platform channel to answer at all.
@riverpod
TransientPositionReader transientPositionReader(
  TransientPositionReaderRef ref,
) => const TransientPositionReader();

@riverpod
class FoodProfileAiContextForRequest extends _$FoodProfileAiContextForRequest {
  @override
  Future<Map<String, dynamic>?> build() async {
    try {
      final snapshot = await ref.watch(foodProfileSnapshotProvider.future);
      return buildFoodProfileAiContext(snapshot);
    } catch (_) {
      // Best-effort only — a message can always be sent without
      // personalization context.
      return null;
    }
  }
}

@riverpod
class ConversationController extends _$ConversationController {
  var _sequence = 0;
  var _requestInFlight = false;

  @override
  ConversationState build(ConversationLaunchArgs launchArgs) {
    final prompt = launchArgs.prompt.trim();
    final now = DateTime.now();
    final archiveId = 'conversation-${now.microsecondsSinceEpoch}';
    if (prompt.isEmpty) {
      return ConversationState(
        localArchiveId: archiveId,
        createdAt: now,
        menuContext: launchArgs.menuContext,
      );
    }
    final initial = ConversationState(
      messages: [_userMessage(prompt)],
      status: ConversationStatus.loading,
      localArchiveId: archiveId,
      createdAt: now,
      menuContext: launchArgs.menuContext,
    );
    unawaited(Future<void>.microtask(() => _request(prompt)));
    return initial;
  }

  ConversationMessage _userMessage(String text) => ConversationMessage(
    id: 'user-${_sequence++}',
    author: ConversationAuthor.user,
    text: text,
  );

  Future<void> send(String value) async {
    final prompt = value.trim();
    if (prompt.isEmpty || _requestInFlight) return;
    state = state.copyWith(
      messages: [...state.messages, _userMessage(prompt)],
      status: ConversationStatus.loading,
      requiresLocation: false,
      retryAvailable: true,
    );
    await _request(prompt);
  }

  Future<void> retry() async {
    if (_requestInFlight) return;
    final userMessages = state.messages.where(
      (message) => message.author == ConversationAuthor.user,
    );
    if (userMessages.isEmpty) return;
    state = state.copyWith(
      status: ConversationStatus.loading,
      requiresLocation: false,
      retryAvailable: true,
    );
    await _request(userMessages.last.text);
  }

  /// Called after the user returns from the city picker (see
  /// `AppRoutes.city`) following a `requiresLocation` response — resends
  /// only on this explicit follow-up action, never automatically.
  Future<void> retryAfterLocationSelected() => retry();

  void startNewSearch() {
    final now = DateTime.now();
    state = ConversationState(
      localArchiveId: 'conversation-${now.microsecondsSinceEpoch}',
      createdAt: now,
    );
  }

  /// Saves a local, offline snapshot when the user intentionally leaves this
  /// thread for History or starts a new one. Empty threads are never archived.
  Future<bool> archiveCurrent() async {
    if (state.messages.isEmpty) return false;
    final now = DateTime.now();
    final firstUserMessage = state.messages
        .where((message) => message.author == ConversationAuthor.user)
        .firstOrNull;
    final rawTitle = firstUserMessage?.text.trim() ?? '';
    final title = rawTitle.length > 64
        ? '${rawTitle.substring(0, 61)}…'
        : rawTitle;
    await ref
        .read(conversationHistoryRepositoryProvider)
        .save(
          ConversationArchive(
            id:
                state.localArchiveId ??
                'conversation-${now.microsecondsSinceEpoch}',
            title: title.isEmpty ? 'Miz' : title,
            messages: List.unmodifiable(state.messages),
            remoteConversationId: state.conversationId,
            createdAt: state.createdAt ?? now,
            updatedAt: now,
          ),
        );
    return true;
  }

  Future<void> archiveAndStartNewSearch() async {
    await archiveCurrent();
    startNewSearch();
  }

  Future<void> _request(String prompt) async {
    _requestInFlight = true;
    try {
      final history = state.messages
          .where(
            (message) =>
                message.text != prompt ||
                message.author != ConversationAuthor.user,
          )
          .toList();
      final bounded = history.length > _maxHistoryTurns
          ? history.sublist(history.length - _maxHistoryTurns)
          : history;

      final locale = ref.read(appSettingsControllerProvider).languageCode;
      final city = ref.read(cityControllerProvider).valueOrNull?.selectedCity;
      final selectedCity = city == null ? null : coordinatesForCity(city);
      final position = await ref
          .read(transientPositionReaderProvider)
          .currentPositionIfAlreadyGranted();
      final foodProfileContext = await ref.read(
        foodProfileAiContextForRequestProvider.future,
      );

      final reply = await ref
          .read(conversationServiceProvider)
          .respond(
            ConversationRequest(
              message: prompt,
              locale: locale,
              conversationId: state.conversationId,
              history: bounded,
              location: position == null
                  ? null
                  : ConversationLocation(
                      latitude: position.latitude,
                      longitude: position.longitude,
                    ),
              selectedCity: selectedCity == null
                  ? null
                  : ConversationCity(
                      name: selectedCity.name,
                      latitude: selectedCity.latitude,
                      longitude: selectedCity.longitude,
                    ),
              foodProfileContext: foodProfileContext,
              menuContext: state.menuContext,
            ),
          );

      // A reply with no text and no places (e.g. the requiresLocation
      // short-circuit) has nothing to show — appending it would render an
      // empty message bubble, and its empty text would later poison the
      // next request's history (this exact case caused a live
      // INVALID_REQUEST regression: see docs/DECISIONS.md).
      final hasContent = reply.text.isNotEmpty || reply.places.isNotEmpty;
      state = state.copyWith(
        messages: hasContent
            ? [
                ...state.messages,
                ConversationMessage(
                  id: 'miz-${_sequence++}',
                  author: ConversationAuthor.miz,
                  text: reply.text,
                  places: reply.places,
                ),
              ]
            : state.messages,
        status: ConversationStatus.idle,
        conversationId: reply.conversationId,
        requiresLocation: reply.requiresLocation,
      );
    } on ConversationUnavailableException catch (error, stackTrace) {
      AppLogger.error(
        'Conversation service unavailable',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: ConversationStatus.unavailable,
        debugErrorCode: 'CONVERSATION_UNAVAILABLE',
        debugErrorDetail: error.toString(),
      );
    } on ConversationAiException catch (error, stackTrace) {
      // Every documented miz-ai error code lands here with its code intact
      // (see `docs/API.md` §5) — logged in full even though only a safe,
      // generic title/body reaches the user-facing card.
      AppLogger.error(
        'miz-ai returned ${error.code}: ${error.message}',
        error: error,
        stackTrace: stackTrace,
      );
      if (error.code == 'LOCATION_REQUIRED') {
        state = state.copyWith(
          status: ConversationStatus.idle,
          requiresLocation: true,
        );
      } else {
        state = state.copyWith(
          status: _statusForErrorCode(error.code),
          retryAvailable: error.retryAvailable,
          debugErrorCode: error.code,
          debugErrorDetail: error.message,
        );
      }
    } catch (error, stackTrace) {
      // Anything landing here is NOT one of the typed exceptions above —
      // e.g. a response-parsing bug in `MizAiService` — so it's the most
      // important case to log with its real type/message/stack rather than
      // silently collapsing a possibly-successful backend call into the
      // generic error card (see docs/API.md §5 and CLAUDE.md §4).
      AppLogger.error(
        'Unhandled exception while requesting a miz-ai reply',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: ConversationStatus.error,
        retryAvailable: true,
        debugErrorCode: error.runtimeType.toString(),
        debugErrorDetail: error.toString(),
      );
    } finally {
      _requestInFlight = false;
    }
  }

  ConversationStatus _statusForErrorCode(String code) => switch (code) {
    'AI_TIMEOUT' => ConversationStatus.timeout,
    'AI_RATE_LIMIT' || 'AI_QUOTA_EXCEEDED' => ConversationStatus.rateLimited,
    'PLACES_TIMEOUT' ||
    'PLACES_UNAVAILABLE' ||
    'PLACES_CONFIGURATION_ERROR' ||
    'PLACES_QUOTA_EXCEEDED' => ConversationStatus.placesUnavailable,
    'NO_RESULTS' => ConversationStatus.noResults,
    'AI_UNAVAILABLE' ||
    'AI_CONFIGURATION_ERROR' => ConversationStatus.unavailable,
    _ => ConversationStatus.error,
  };
}
