import 'food_profile_enums.dart';

/// Clean tracking API — feature widgets call these instead of ever
/// inserting into the interaction table directly (CLAUDE.md §7: no
/// business logic / raw persistence in widgets). The Drift-backed
/// implementation lives in `data/interaction_tracker_impl.dart` and
/// batches inserts so tracking never blocks the UI thread.
abstract interface class InteractionTracker {
  Future<void> trackImpression({
    required InteractionEntityType entityType,
    required String entityId,
    required String screenName,
    String? sourceSection,
    int? positionIndex,
  });

  Future<void> trackTap({
    required InteractionEntityType entityType,
    required String entityId,
    required String screenName,
    String? sourceSection,
    int? positionIndex,
  });

  Future<void> trackFoodOpened(String foodItemId, {String? sourceSection});

  Future<void> trackRestaurantTapped(
    String restaurantId, {
    String? sourceSection,
    int? positionIndex,
  });

  Future<void> trackSearch(String query, {String? screenName});

  Future<void> trackPreferenceChanged({
    required String section,
    required String fieldKey,
  });

  Future<void> trackLike(InteractionEntityType entityType, String entityId);
  Future<void> trackDislike(InteractionEntityType entityType, String entityId);
  Future<void> trackSave(InteractionEntityType entityType, String entityId);
  Future<void> trackHide(
    InteractionEntityType entityType,
    String entityId, {
    String? reason,
  });

  Future<void> trackOnboardingAnswer(String section);

  /// Flushes any batched events immediately — call on app background/pause
  /// so nothing is lost between launches.
  Future<void> flush();
}
