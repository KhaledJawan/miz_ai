import 'food_profile_enums.dart';

class FoodInteractionSummary {
  const FoodInteractionSummary({
    required this.eventType,
    required this.foodItemId,
  });

  final String eventType; // matches InteractionEventType.name
  final int foodItemId;
}

/// A candidate the user has not explicitly confirmed yet. Always tagged
/// [PreferenceSource.behavioralInference] and never written over an
/// explicit row — see docs/DECISIONS.md and CLAUDE.md's behavioral-signal
/// rule ("must never automatically create strict exclusions").
class InferredCuisineSignal {
  const InferredCuisineSignal({
    required this.cuisineId,
    required this.suggestedState,
    required this.evidenceCount,
    required this.confidence,
  });

  final int cuisineId;
  final PreferenceState suggestedState;
  final int evidenceCount;
  final double confidence;
}

class InferredIngredientCategorySignal {
  const InferredIngredientCategorySignal({
    required this.ingredientId,
    required this.suggestedState,
    required this.evidenceCount,
    required this.confidence,
  });

  final int ingredientId;
  final PreferenceState suggestedState;
  final int evidenceCount;
  final double confidence;
}

const Set<String> _kPositiveEvents = {'open', 'like', 'save', 'reorder'};
const Set<String> _kNegativeEvents = {'hide', 'dislike'};

/// Lightweight, deterministic aggregation over recent interactions — no AI,
/// no scheduler infrastructure (this runs synchronously over an already-
/// fetched interaction list; the caller decides cadence, e.g. after every
/// N new interactions). A single click never moves the needle: a signal is
/// only emitted once evidence crosses [minEvidenceCount] in one direction,
/// matching the brief's "repeatedly... may slightly increase confidence"
/// framing rather than reacting to one tap.
class BehavioralInferenceService {
  const BehavioralInferenceService({this.minEvidenceCount = 3});

  final int minEvidenceCount;

  List<InferredCuisineSignal> deriveCuisineSignals(
    List<FoodInteractionSummary> events,
    Map<int, int?> cuisineIdByFoodItemId,
  ) {
    final tally = <int, int>{};
    for (final event in events) {
      final cuisineId = cuisineIdByFoodItemId[event.foodItemId];
      if (cuisineId == null) continue;
      if (_kPositiveEvents.contains(event.eventType)) {
        tally[cuisineId] = (tally[cuisineId] ?? 0) + 1;
      } else if (_kNegativeEvents.contains(event.eventType)) {
        tally[cuisineId] = (tally[cuisineId] ?? 0) - 1;
      }
    }

    return [
      for (final entry in tally.entries)
        if (entry.value.abs() >= minEvidenceCount)
          InferredCuisineSignal(
            cuisineId: entry.key,
            suggestedState: entry.value > 0
                ? PreferenceState.like
                : PreferenceState.dislike,
            evidenceCount: entry.value.abs(),
            confidence: _confidenceFor(entry.value.abs()),
          ),
    ];
  }

  List<InferredIngredientCategorySignal> deriveIngredientCategorySignals(
    List<FoodInteractionSummary> events,
    Map<int, List<int>> primaryIngredientIdsByFoodItemId,
  ) {
    final tally = <int, int>{};
    for (final event in events) {
      final ingredientIds = primaryIngredientIdsByFoodItemId[event.foodItemId];
      if (ingredientIds == null) continue;
      final delta = _kPositiveEvents.contains(event.eventType)
          ? 1
          : _kNegativeEvents.contains(event.eventType)
          ? -1
          : 0;
      if (delta == 0) continue;
      for (final ingredientId in ingredientIds) {
        tally[ingredientId] = (tally[ingredientId] ?? 0) + delta;
      }
    }

    return [
      for (final entry in tally.entries)
        if (entry.value.abs() >= minEvidenceCount)
          InferredIngredientCategorySignal(
            ingredientId: entry.key,
            suggestedState: entry.value > 0
                ? PreferenceState.like
                : PreferenceState.dislike,
            evidenceCount: entry.value.abs(),
            confidence: _confidenceFor(entry.value.abs()),
          ),
    ];
  }

  /// Confidence grows with evidence but is capped well below 1.0 —
  /// inferred signals must never read as certain as an explicit answer.
  double _confidenceFor(int evidenceCount) {
    final scaled = 0.25 + (evidenceCount - minEvidenceCount) * 0.05;
    return scaled.clamp(0.25, 0.6);
  }
}
