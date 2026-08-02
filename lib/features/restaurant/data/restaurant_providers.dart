import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/restaurant.dart';
import '../domain/restaurant_repository.dart';
import 'mock_restaurant_repository.dart';

part 'restaurant_providers.g.dart';

/// Exposes the [RestaurantRepository] interface type, not the concrete mock
/// implementation — this is the seam Milestone 6 swaps to Supabase. See
/// docs/ARCHITECTURE.md §4 and ADR-007.
@riverpod
RestaurantRepository restaurantRepository(RestaurantRepositoryRef ref) =>
    MockRestaurantRepository();

@riverpod
Future<List<Restaurant>> allRestaurants(AllRestaurantsRef ref) {
  return ref.watch(restaurantRepositoryProvider).getAll();
}
