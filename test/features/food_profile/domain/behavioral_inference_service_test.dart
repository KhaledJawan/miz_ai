import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/food_profile/domain/behavioral_inference_service.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';

void main() {
  const service = BehavioralInferenceService(minEvidenceCount: 3);

  group('deriveCuisineSignals', () {
    test('a single open event never produces a signal', () {
      final signals = service.deriveCuisineSignals(
        const [FoodInteractionSummary(eventType: 'open', foodItemId: 1)],
        {1: 100},
      );

      expect(signals, isEmpty);
    });

    test(
      'repeatedly opening the same cuisine produces a low-confidence like',
      () {
        final events = List.generate(
          4,
          (_) => const FoodInteractionSummary(eventType: 'open', foodItemId: 1),
        );

        final signals = service.deriveCuisineSignals(events, {1: 100});

        expect(signals, hasLength(1));
        expect(signals.single.cuisineId, 100);
        expect(signals.single.suggestedState, PreferenceState.like);
        expect(signals.single.confidence, lessThan(1.0));
        expect(signals.single.confidence, greaterThanOrEqualTo(0.25));
      },
    );

    test(
      'repeatedly hiding a cuisine produces a dislike signal, never a stronger exclusion',
      () {
        final events = List.generate(
          5,
          (_) => const FoodInteractionSummary(eventType: 'hide', foodItemId: 2),
        );

        final signals = service.deriveCuisineSignals(events, {2: 200});

        expect(signals.single.suggestedState, PreferenceState.dislike);
        // Confidence must stay well below an explicit answer's certainty.
        expect(signals.single.confidence, lessThan(0.7));
      },
    );

    test('mixed positive and negative signals cancel out below threshold', () {
      final events = [
        const FoodInteractionSummary(eventType: 'open', foodItemId: 1),
        const FoodInteractionSummary(eventType: 'open', foodItemId: 1),
        const FoodInteractionSummary(eventType: 'hide', foodItemId: 1),
        const FoodInteractionSummary(eventType: 'hide', foodItemId: 1),
      ];

      final signals = service.deriveCuisineSignals(events, {1: 100});

      expect(signals, isEmpty);
    });
  });

  group('deriveIngredientCategorySignals', () {
    test(
      'hiding several seafood dishes creates a low-confidence dislike, not an allergy',
      () {
        final events = List.generate(
          3,
          (i) => FoodInteractionSummary(eventType: 'hide', foodItemId: i),
        );
        final ingredientsByFoodItem = {
          0: [500], // seafood ingredient id
          1: [500],
          2: [500],
        };

        final signals = service.deriveIngredientCategorySignals(
          events,
          ingredientsByFoodItem,
        );

        expect(signals, hasLength(1));
        expect(signals.single.ingredientId, 500);
        expect(signals.single.suggestedState, PreferenceState.dislike);
        // This is the exact case the brief calls out: never becomes a
        // strict exclusion or allergy — the signal only carries a
        // preference suggestion, no RestrictionType at all.
        expect(signals.single.confidence, lessThan(1.0));
      },
    );
  });
}
