import 'saved_item.dart';

abstract interface class BookmarkRepository {
  Stream<List<SavedItem>> watchAll();
  Future<Set<String>> restaurantIds();
  Future<void> save(SavedItem item);
  Future<void> remove(SavedItemType type, String id);
}
