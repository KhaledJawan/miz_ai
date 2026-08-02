/// Enums for the Food Preference Profile domain. Every enum here is stored
/// in Drift as its stable `.name` string (never an integer index) — see
/// `lib/core/database/tables/*`. Reordering values here never corrupts
/// stored data; renaming a value is a real migration.
library;

enum DietType {
  vegan,
  vegetarian,
  pescatarian,
  flexitarian,
  omnivore,
  other,
  preferNotToSay,
  unknown,
}

/// How strongly a [FoodRule] applies. Never "required" and "avoid" at once
/// for the same rule — the onboarding UI enforces no contradictory pairs.
enum RequirementLevel { required, preferred, avoid, unknown }

enum AllergySeverity { unspecified, mild, moderate, severe }

/// Where an answer came from. Explicit answers always outrank inferred
/// ones and are never silently overwritten by them.
enum PreferenceSource { explicit, behavioralInference }

/// The like/dislike/curiosity axis — always independent from
/// [RestrictionType]. An allergy is never expressed only as "dislike".
enum PreferenceState {
  love,
  like,
  neutral,
  dislike,
  curious,
  neverTried,
  unknown,
}

/// The safety/eligibility axis — independent from [PreferenceState].
enum RestrictionType {
  none,
  strictExclude,
  dietaryExclude,
  ethicalExclude,
  religiousExclude,
  intolerance,
  allergy,
}

enum OnboardingStatus { notStarted, inProgress, completed, skipped }

enum AdventurousnessLevel { almostNever, sometimes, often, almostAlways }

enum MealWeightPreference { light, balanced, filling, dependsOnSituation }

enum BudgetLevel { low, medium, high, noPreference }

enum EatingPriority {
  taste,
  price,
  health,
  portionSize,
  ingredients,
  appearance,
  preparationTime,
  popularity,
  familiarity,
  somethingNew,
}

enum InteractionEventType {
  impression,
  tap,
  open,
  close,
  search,
  filterApply,
  filterRemove,
  like,
  dislike,
  save,
  unsave,
  hide,
  unhide,
  share,
  viewMenu,
  viewRestaurant,
  viewFood,
  startOrder,
  addToCart,
  removeFromCart,
  order,
  reorder,
  rating,
  onboardingAnswer,
  profileEdit,
}

enum InteractionEntityType {
  food,
  menuItem,
  restaurant,
  cuisine,
  ingredient,
  category,
  searchResult,
  recommendation,
  profileSection,
}

/// Parses a stored `.name` string back into an enum value, falling back to
/// [fallback] for unknown/legacy values instead of throwing — a stray or
/// future value in the database must never crash the app.
T enumFromName<T extends Enum>(List<T> values, String? name, T fallback) {
  if (name == null) return fallback;
  for (final value in values) {
    if (value.name == name) return value;
  }
  return fallback;
}
