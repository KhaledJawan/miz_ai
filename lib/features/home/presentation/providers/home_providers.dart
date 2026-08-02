import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../restaurant/data/restaurant_providers.dart';
import '../../../restaurant/domain/restaurant.dart';
import '../../../restaurant/presentation/providers/favorites_controller.dart';
import '../../domain/greeting.dart';

part 'home_providers.g.dart';

@riverpod
Greeting currentGreeting(CurrentGreetingRef ref) =>
    greetingForHour(DateTime.now().hour);

@riverpod
Future<List<Restaurant>> nearbyRestaurants(NearbyRestaurantsRef ref) async {
  final restaurants = await ref.watch(allRestaurantsProvider.future);
  final sorted = [...restaurants]
    ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
  return sorted.take(4).toList();
}

@riverpod
Future<List<Restaurant>> favoriteRestaurants(FavoriteRestaurantsRef ref) async {
  final favoriteIds = ref.watch(favoritesControllerProvider);
  if (favoriteIds.isEmpty) return const [];
  final restaurants = await ref.watch(allRestaurantsProvider.future);
  return restaurants.where((r) => favoriteIds.contains(r.id)).toList();
}
