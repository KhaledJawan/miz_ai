import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/local_user.dart';
import 'bookmark_repository.dart';
import 'saved_item.dart' as domain;

class DriftBookmarkRepository implements BookmarkRepository {
  DriftBookmarkRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<domain.SavedItem>> watchAll() {
    final query = _database.select(_database.savedItems)
      ..where((row) => row.localUserId.equals(kLocalUserId))
      ..orderBy([(row) => OrderingTerm.desc(row.savedAt)]);
    return query.watch().map(
      (rows) => rows.map(_toDomain).toList(growable: false),
    );
  }

  @override
  Future<Set<String>> restaurantIds() async {
    final rows =
        await (_database.select(_database.savedItems)..where(
              (row) =>
                  row.localUserId.equals(kLocalUserId) &
                  row.itemType.equals(domain.SavedItemType.restaurant.name),
            ))
            .get();
    return rows.map((row) => row.itemId).toSet();
  }

  @override
  Future<void> save(domain.SavedItem item) {
    return _database
        .into(_database.savedItems)
        .insertOnConflictUpdate(
          SavedItemsCompanion.insert(
            itemType: item.type.name,
            itemId: item.id,
            title: item.title,
            subtitle: Value(item.subtitle),
            imageAsset: Value(item.imageAsset),
            savedAt: Value(item.savedAt),
          ),
        );
  }

  @override
  Future<void> remove(domain.SavedItemType type, String id) {
    return (_database.delete(_database.savedItems)..where(
          (row) =>
              row.localUserId.equals(kLocalUserId) &
              row.itemType.equals(type.name) &
              row.itemId.equals(id),
        ))
        .go();
  }

  domain.SavedItem _toDomain(SavedItem row) {
    return domain.SavedItem(
      id: row.itemId,
      type: domain.SavedItemType.values.firstWhere(
        (type) => type.name == row.itemType,
        orElse: () => domain.SavedItemType.discovery,
      ),
      title: row.title,
      subtitle: row.subtitle,
      imageAsset: row.imageAsset,
      savedAt: row.savedAt,
    );
  }
}
