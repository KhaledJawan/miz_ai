import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/bookmarks/bookmark_providers.dart';
import '../../../../core/bookmarks/saved_item.dart';

part 'favorites_controller.g.dart';

/// Compatibility controller for restaurant favorite call sites. It now reads
/// and writes the same Drift-backed saved-items repository as Bookmarks.
@Riverpod(keepAlive: true)
class FavoritesController extends _$FavoritesController {
  @override
  Set<String> build() {
    unawaited(_hydrate());
    return const {};
  }

  Future<void> _hydrate() async {
    final ids = await ref.read(bookmarkRepositoryProvider).restaurantIds();
    state = ids;
  }

  void toggle(String restaurantId, {String? title, String? imageAsset}) {
    final next = {...state};
    if (next.remove(restaurantId)) {
      unawaited(
        ref
            .read(bookmarkRepositoryProvider)
            .remove(SavedItemType.restaurant, restaurantId),
      );
    } else {
      next.add(restaurantId);
      unawaited(
        ref
            .read(bookmarkRepositoryProvider)
            .save(
              SavedItem(
                id: restaurantId,
                type: SavedItemType.restaurant,
                title: title ?? restaurantId,
                imageAsset: imageAsset,
                savedAt: DateTime.now(),
              ),
            ),
      );
    }
    state = next;
  }

  bool isFavorite(String restaurantId) => state.contains(restaurantId);
}
