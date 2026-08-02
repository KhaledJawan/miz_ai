import 'restaurant.dart';

/// Repository contract for restaurant data. `presentation/` depends only on
/// this interface — the mock implementation ([MockRestaurantRepository] in
/// `data/`) is swapped for a Supabase-backed one in Milestone 6 without any
/// feature code changing. See docs/ARCHITECTURE.md §4.
abstract interface class RestaurantRepository {
  Future<List<Restaurant>> getAll();
}
