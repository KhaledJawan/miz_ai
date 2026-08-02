import 'entities.dart';
import 'food_profile_enums.dart';
import 'food_profile_snapshot.dart';

enum FoodEligibilityStatus { eligible, excluded, warning, unknown }

class FoodEligibilityReason {
  const FoodEligibilityReason(this.code, {this.detail});

  /// A stable code (e.g. `allergyContains`, `strictExclude`,
  /// `unknownIngredientData`) — never a free-text sentence, so the UI can
  /// localize it and future callers can branch on it.
  final String code;
  final String? detail;
}

class FoodEligibilityResult {
  const FoodEligibilityResult({
    required this.status,
    this.blockingReasons = const [],
    this.warningReasons = const [],
    this.matchedPreferences = const [],
    this.unknownData = const [],
    required this.confidence,
  });

  final FoodEligibilityStatus status;
  final List<FoodEligibilityReason> blockingReasons;
  final List<FoodEligibilityReason> warningReasons;
  final List<FoodEligibilityReason> matchedPreferences;
  final List<FoodEligibilityReason> unknownData;
  final double confidence;

  bool get isSafeToShow => status != FoodEligibilityStatus.excluded;
}

/// Deterministic, AI-free eligibility engine — no machine learning, no
/// remote calls, no probabilistic scoring beyond the explicit rules below.
/// Pure Dart (no Flutter/Drift imports) so it's testable in isolation and
/// ready to be the safety layer under a future AI/recommendation system —
/// see docs/DECISIONS.md and the food-profile safety rules in CLAUDE.md.
///
/// Rule order (first match that excludes wins; warnings/preferences are
/// additive):
/// 1. Confirmed allergen (`contains`) matching an active allergy → excluded.
/// 2. `mayContain` a *severe* active allergy → excluded (conservative —
///    severe allergies are never downgraded to a warning).
/// 3. `mayContain` a non-severe active allergy → warning.
/// 4. Strict dietary/religious food-rule (`required`) whose linked
///    ingredients the item contains → excluded.
/// 5. Restricted ingredient (any [RestrictionType] other than `none`,
///    e.g. dietary/ethical/religious exclude or intolerance) → excluded.
/// 6. Unknown ingredient/allergen data for the item → status can never be
///    `eligible`; downgraded to `unknown` if nothing else already excluded
///    or warned.
/// 7. Personal dislikes/likes → recorded as [matchedPreferences] for
///    ranking only, never affect eligibility.
class FoodEligibilityService {
  const FoodEligibilityService();

  FoodEligibilityResult evaluate({
    required FoodItemEntry item,
    required FoodProfileSnapshot snapshot,
    required bool hasCompleteIngredientData,
    required bool hasCompleteAllergenData,
  }) {
    final blocking = <FoodEligibilityReason>[];
    final warnings = <FoodEligibilityReason>[];
    final matched = <FoodEligibilityReason>[];
    final unknown = <FoodEligibilityReason>[];

    // 1 & 2 & 3: allergens.
    for (final allergenId in item.allergenIds) {
      if (snapshot.activeAllergenIds.contains(allergenId)) {
        blocking.add(
          FoodEligibilityReason('allergyContains', detail: '$allergenId'),
        );
      }
    }
    for (final allergenId in item.mayContainAllergenIds) {
      if (snapshot.severeAllergenIds.contains(allergenId)) {
        blocking.add(
          FoodEligibilityReason(
            'allergyMayContainSevere',
            detail: '$allergenId',
          ),
        );
      } else if (snapshot.activeAllergenIds.contains(allergenId)) {
        warnings.add(
          FoodEligibilityReason('allergyMayContain', detail: '$allergenId'),
        );
      }
    }

    // 4: strict food rules. A food rule maps to ingredients via its code
    // (e.g. `noPork` excludes the `pork` ingredient); the onboarding/data
    // layer keeps that mapping, so here we only need the ingredient side —
    // strict food rules are enforced through restrictedIngredientIds by the
    // time they reach this service (see FoodProfileProviders), keeping this
    // method's contract to a single ingredient-restriction check (5).

    // 5: restricted ingredients (covers strict dietary/religious/ethical
    // excludes and ingredient-level intolerances/allergies).
    final allItemIngredientIds = {
      ...item.primaryIngredientIds,
      ...item.mayContainIngredientIds,
    };
    for (final ingredientId in allItemIngredientIds) {
      if (snapshot.restrictedIngredientIds.contains(ingredientId)) {
        blocking.add(
          FoodEligibilityReason(
            'restrictedIngredient',
            detail: '$ingredientId',
          ),
        );
      }
    }

    // 6: unknown data — never let an item with incomplete safety data read
    // as confidently "eligible."
    if (!hasCompleteIngredientData || !hasCompleteAllergenData) {
      unknown.add(const FoodEligibilityReason('incompleteSafetyData'));
    }

    // 7: preferences — ranking signal only, never eligibility.
    for (final pref in snapshot.ingredientPreferences) {
      if (allItemIngredientIds.contains(pref.ingredientId) &&
          (pref.preferenceState == PreferenceState.love ||
              pref.preferenceState == PreferenceState.like)) {
        matched.add(
          FoodEligibilityReason('likedIngredient', detail: pref.ingredientCode),
        );
      }
    }

    final FoodEligibilityStatus status;
    if (blocking.isNotEmpty) {
      status = FoodEligibilityStatus.excluded;
    } else if (unknown.isNotEmpty) {
      status = FoodEligibilityStatus.unknown;
    } else if (warnings.isNotEmpty) {
      status = FoodEligibilityStatus.warning;
    } else {
      status = FoodEligibilityStatus.eligible;
    }

    final confidence = blocking.isNotEmpty
        ? 1.0
        : unknown.isNotEmpty
        ? 0.4
        : warnings.isNotEmpty
        ? 0.75
        : 1.0;

    return FoodEligibilityResult(
      status: status,
      blockingReasons: blocking,
      warningReasons: warnings,
      matchedPreferences: matched,
      unknownData: unknown,
      confidence: confidence,
    );
  }
}
