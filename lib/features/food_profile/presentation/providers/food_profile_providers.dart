import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/food_profile_repository_impl.dart';
import '../../data/interaction_tracker_impl.dart';
import '../../domain/behavioral_inference_service.dart';
import '../../domain/entities.dart';
import '../../domain/food_eligibility_service.dart';
import '../../domain/food_profile_repository.dart';
import '../../domain/food_profile_snapshot.dart';
import '../../domain/interaction_tracker.dart';
import '../../domain/profile_completeness_service.dart';

part 'food_profile_providers.g.dart';

/// Exposes the interface type only — swapping the Drift-backed
/// implementation later never touches a call site (CLAUDE.md §7).
@Riverpod(keepAlive: true)
FoodProfileRepository foodProfileRepository(FoodProfileRepositoryRef ref) =>
    FoodProfileRepositoryImpl(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
InteractionTracker interactionTracker(InteractionTrackerRef ref) {
  final tracker = InteractionTrackerImpl(ref.watch(appDatabaseProvider));
  ref.onDispose(() => tracker.flush());
  return tracker;
}

@riverpod
FoodEligibilityService foodEligibilityService(FoodEligibilityServiceRef ref) =>
    const FoodEligibilityService();

@riverpod
ProfileCompletenessService profileCompletenessService(
  ProfileCompletenessServiceRef ref,
) => const ProfileCompletenessService();

@riverpod
BehavioralInferenceService behavioralInferenceService(
  BehavioralInferenceServiceRef ref,
) => const BehavioralInferenceService();

@riverpod
Stream<FoodProfile> foodProfile(FoodProfileRef ref) =>
    ref.watch(foodProfileRepositoryProvider).watchProfile();

@riverpod
Future<List<CatalogEntry>> allergenCatalog(AllergenCatalogRef ref) =>
    ref.watch(foodProfileRepositoryProvider).getAllergenCatalog();

@riverpod
Future<List<CatalogEntry>> intoleranceCatalog(IntoleranceCatalogRef ref) =>
    ref.watch(foodProfileRepositoryProvider).getIntoleranceCatalog();

@riverpod
Future<List<CatalogEntry>> foodRuleCatalog(FoodRuleCatalogRef ref) =>
    ref.watch(foodProfileRepositoryProvider).getFoodRuleCatalog();

@riverpod
Future<List<CatalogEntry>> cuisineCatalog(CuisineCatalogRef ref) =>
    ref.watch(foodProfileRepositoryProvider).getCuisineCatalog();

@riverpod
Future<List<CatalogEntry>> flavorAttributeCatalog(
  FlavorAttributeCatalogRef ref,
) => ref.watch(foodProfileRepositoryProvider).getFlavorAttributeCatalog();

@riverpod
Future<List<IngredientEntry>> ingredientCatalog(IngredientCatalogRef ref) =>
    ref.watch(foodProfileRepositoryProvider).getIngredientCatalog();

@riverpod
Future<List<FoodItemEntry>> foodItemCatalog(FoodItemCatalogRef ref) =>
    ref.watch(foodProfileRepositoryProvider).getFoodItemCatalog();

/// Assembles everything [FoodEligibilityService]/[ProfileCompletenessService]
/// need in one read — see [FoodProfileSnapshot].
@riverpod
Future<FoodProfileSnapshot> foodProfileSnapshot(
  FoodProfileSnapshotRef ref,
) async {
  final repository = ref.watch(foodProfileRepositoryProvider);
  final profile = await repository.ensureProfile();
  final results = await (
    repository.getFoodRules(),
    repository.getAllergies(),
    repository.getIntolerances(),
    repository.getIngredientPreferences(),
    repository.getCuisinePreferences(),
    repository.getFlavorPreferences(),
    repository.getFoodItemPreferences(),
  ).wait;

  return FoodProfileSnapshot(
    profile: profile,
    foodRules: results.$1,
    allergies: results.$2,
    intolerances: results.$3,
    ingredientPreferences: results.$4,
    cuisinePreferences: results.$5,
    flavorPreferences: results.$6,
    foodItemPreferences: results.$7,
  );
}
