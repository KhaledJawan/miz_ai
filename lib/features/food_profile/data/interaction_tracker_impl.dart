import 'dart:async';
import 'dart:math';

import 'package:drift/drift.dart' show Value;

import '../../../core/database/app_database.dart' as drift;
import '../../../core/database/local_user.dart';
import '../domain/food_profile_enums.dart';
import '../domain/interaction_tracker.dart';

/// Batches inserts (flushed on a short timer or when the queue grows, and
/// always on [flush]/dispose) so tracking calls never block the UI thread,
/// and dedupes impression events per session so scroll-triggered rebuilds
/// don't spam the interaction log — see docs/ARCHITECTURE.md and the
/// brief's "avoid duplicate impression events" requirement.
class InteractionTrackerImpl implements InteractionTracker {
  InteractionTrackerImpl(this._db) : sessionId = _generateSessionId();

  final drift.AppDatabase _db;
  final String sessionId;

  final _pending = <drift.UserFoodInteractionsCompanion>[];
  final _seenImpressions = <String>{};
  Timer? _flushTimer;

  static const _maxBatchSize = 20;
  static const _flushInterval = Duration(seconds: 2);

  static String _generateSessionId() {
    final random = Random();
    final suffix = List.generate(
      8,
      (_) => random.nextInt(16).toRadixString(16),
    ).join();
    return '${DateTime.now().millisecondsSinceEpoch}-$suffix';
  }

  void _enqueue(drift.UserFoodInteractionsCompanion row) {
    _pending.add(row);
    _flushTimer ??= Timer(_flushInterval, () {
      _flushTimer = null;
      unawaited(flush());
    });
    if (_pending.length >= _maxBatchSize) {
      unawaited(flush());
    }
  }

  @override
  Future<void> flush() async {
    _flushTimer?.cancel();
    _flushTimer = null;
    if (_pending.isEmpty) return;
    final batch = List<drift.UserFoodInteractionsCompanion>.from(_pending);
    _pending.clear();
    await _db.interactionDao.insertInteractions(batch);
  }

  @override
  Future<void> trackImpression({
    required InteractionEntityType entityType,
    required String entityId,
    required String screenName,
    String? sourceSection,
    int? positionIndex,
  }) async {
    final key = '${entityType.name}:$entityId:$screenName';
    if (!_seenImpressions.add(key)) return;
    _enqueue(
      drift.UserFoodInteractionsCompanion.insert(
        localUserId: kLocalUserId,
        sessionId: sessionId,
        eventType: InteractionEventType.impression.name,
        entityType: Value(entityType.name),
        entityId: Value(entityId),
        screenName: Value(screenName),
        sourceSection: Value(sourceSection),
        positionIndex: Value(positionIndex),
      ),
    );
  }

  @override
  Future<void> trackTap({
    required InteractionEntityType entityType,
    required String entityId,
    required String screenName,
    String? sourceSection,
    int? positionIndex,
  }) async {
    _enqueue(
      drift.UserFoodInteractionsCompanion.insert(
        localUserId: kLocalUserId,
        sessionId: sessionId,
        eventType: InteractionEventType.tap.name,
        entityType: Value(entityType.name),
        entityId: Value(entityId),
        screenName: Value(screenName),
        sourceSection: Value(sourceSection),
        positionIndex: Value(positionIndex),
      ),
    );
  }

  @override
  Future<void> trackFoodOpened(String foodItemId, {String? sourceSection}) =>
      _trackSimple(
        InteractionEventType.viewFood,
        InteractionEntityType.food,
        foodItemId,
        sourceSection: sourceSection,
      );

  @override
  Future<void> trackRestaurantTapped(
    String restaurantId, {
    String? sourceSection,
    int? positionIndex,
  }) => _trackSimple(
    InteractionEventType.viewRestaurant,
    InteractionEntityType.restaurant,
    restaurantId,
    sourceSection: sourceSection,
    positionIndex: positionIndex,
  );

  @override
  Future<void> trackSearch(String query, {String? screenName}) async {
    _enqueue(
      drift.UserFoodInteractionsCompanion.insert(
        localUserId: kLocalUserId,
        sessionId: sessionId,
        eventType: InteractionEventType.search.name,
        screenName: Value(screenName),
        searchQuery: Value(query),
      ),
    );
  }

  @override
  Future<void> trackPreferenceChanged({
    required String section,
    required String fieldKey,
  }) async {
    _enqueue(
      drift.UserFoodInteractionsCompanion.insert(
        localUserId: kLocalUserId,
        sessionId: sessionId,
        eventType: InteractionEventType.profileEdit.name,
        entityType: Value(InteractionEntityType.profileSection.name),
        entityId: Value(section),
        metadataJson: Value('{"field":"$fieldKey"}'),
      ),
    );
  }

  @override
  Future<void> trackLike(InteractionEntityType entityType, String entityId) =>
      _trackSimple(InteractionEventType.like, entityType, entityId);

  @override
  Future<void> trackDislike(
    InteractionEntityType entityType,
    String entityId,
  ) => _trackSimple(InteractionEventType.dislike, entityType, entityId);

  @override
  Future<void> trackSave(InteractionEntityType entityType, String entityId) =>
      _trackSimple(InteractionEventType.save, entityType, entityId);

  @override
  Future<void> trackHide(
    InteractionEntityType entityType,
    String entityId, {
    String? reason,
  }) async {
    await _db.interactionDao.hideEntity(
      drift.UserHiddenEntitiesCompanion.insert(
        localUserId: kLocalUserId,
        entityType: entityType.name,
        entityId: entityId,
        reason: Value(reason),
      ),
    );
    await _trackSimple(InteractionEventType.hide, entityType, entityId);
  }

  @override
  Future<void> trackOnboardingAnswer(String section) async {
    _enqueue(
      drift.UserFoodInteractionsCompanion.insert(
        localUserId: kLocalUserId,
        sessionId: sessionId,
        eventType: InteractionEventType.onboardingAnswer.name,
        entityType: Value(InteractionEntityType.profileSection.name),
        entityId: Value(section),
      ),
    );
  }

  Future<void> _trackSimple(
    InteractionEventType eventType,
    InteractionEntityType entityType,
    String entityId, {
    String? sourceSection,
    int? positionIndex,
  }) async {
    _enqueue(
      drift.UserFoodInteractionsCompanion.insert(
        localUserId: kLocalUserId,
        sessionId: sessionId,
        eventType: eventType.name,
        entityType: Value(entityType.name),
        entityId: Value(entityId),
        sourceSection: Value(sourceSection),
        positionIndex: Value(positionIndex),
      ),
    );
  }
}
