import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_controller.g.dart';

/// Session-only favorites (bookmark) state. Persisted to Supabase
/// `bookmarks` from Milestone 6 onward — see docs/DATABASE.md.
@riverpod
class FavoritesController extends _$FavoritesController {
  @override
  Set<String> build() => const {};

  void toggle(String restaurantId) {
    final next = {...state};
    if (!next.remove(restaurantId)) next.add(restaurantId);
    state = next;
  }

  bool isFavorite(String restaurantId) => state.contains(restaurantId);
}
