import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database_provider.dart';
import 'bookmark_repository.dart';
import 'drift_bookmark_repository.dart';
import 'saved_item.dart';

part 'bookmark_providers.g.dart';

@riverpod
BookmarkRepository bookmarkRepository(BookmarkRepositoryRef ref) =>
    DriftBookmarkRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<SavedItem>> savedItems(SavedItemsRef ref) =>
    ref.watch(bookmarkRepositoryProvider).watchAll();

@Riverpod(keepAlive: true)
class SavedItemsQuery extends _$SavedItemsQuery {
  @override
  String build() => '';

  void setQuery(String value) => state = value.trim().toLowerCase();
}

@Riverpod(keepAlive: true)
class SavedItemsFilter extends _$SavedItemsFilter {
  @override
  SavedItemFilter build() => SavedItemFilter.all;

  void select(SavedItemFilter value) => state = value;
}

@riverpod
List<SavedItem> filteredSavedItems(FilteredSavedItemsRef ref) {
  final items = ref.watch(savedItemsProvider).valueOrNull ?? const [];
  final query = ref.watch(savedItemsQueryProvider);
  final filter = ref.watch(savedItemsFilterProvider);
  return items
      .where((item) {
        final matchesQuery =
            query.isEmpty ||
            item.title.toLowerCase().contains(query) ||
            (item.subtitle?.toLowerCase().contains(query) ?? false);
        final matchesFilter = switch (filter) {
          SavedItemFilter.all => true,
          SavedItemFilter.restaurants =>
            item.type == SavedItemType.restaurant ||
                item.type == SavedItemType.cafe,
          SavedItemFilter.foods =>
            item.type == SavedItemType.food ||
                item.type == SavedItemType.scannedDish ||
                item.type == SavedItemType.discovery,
          SavedItemFilter.menuItems => item.type == SavedItemType.menuItem,
        };
        return matchesQuery && matchesFilter;
      })
      .toList(growable: false);
}
