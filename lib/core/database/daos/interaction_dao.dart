import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/interaction_tables.dart';

part 'interaction_dao.g.dart';

@DriftAccessor(tables: [UserFoodInteractions, UserHiddenEntities])
class InteractionDao extends DatabaseAccessor<AppDatabase>
    with _$InteractionDaoMixin {
  InteractionDao(super.db);

  Future<int> insertInteraction(UserFoodInteractionsCompanion row) =>
      into(userFoodInteractions).insert(row);

  Future<void> insertInteractions(List<UserFoodInteractionsCompanion> rows) =>
      batch((b) => b.insertAll(userFoodInteractions, rows));

  Future<List<UserFoodInteraction>> getRecentInteractions(
    int localUserId, {
    List<String>? eventTypes,
    DateTime? since,
    int limit = 500,
  }) {
    final query = select(userFoodInteractions)
      ..where((row) => row.localUserId.equals(localUserId))
      ..orderBy([(row) => OrderingTerm.desc(row.occurredAt)])
      ..limit(limit);
    if (eventTypes != null && eventTypes.isNotEmpty) {
      query.where((row) => row.eventType.isIn(eventTypes));
    }
    if (since != null) {
      query.where((row) => row.occurredAt.isBiggerOrEqualValue(since));
    }
    return query.get();
  }

  Future<int> countInteractionsSince(int localUserId, DateTime since) {
    final count = userFoodInteractions.id.count();
    final query = selectOnly(userFoodInteractions)
      ..addColumns([count])
      ..where(
        userFoodInteractions.localUserId.equals(localUserId) &
            userFoodInteractions.occurredAt.isBiggerOrEqualValue(since),
      );
    return query.map((row) => row.read(count) ?? 0).getSingle();
  }

  Future<void> deleteAllInteractions(int localUserId) => (delete(
    userFoodInteractions,
  )..where((row) => row.localUserId.equals(localUserId))).go();

  Future<bool> isHidden(
    int localUserId,
    String entityType,
    String entityId,
  ) async {
    final row =
        await (select(userHiddenEntities)..where(
              (r) =>
                  r.localUserId.equals(localUserId) &
                  r.entityType.equals(entityType) &
                  r.entityId.equals(entityId),
            ))
            .getSingleOrNull();
    return row != null;
  }

  Future<void> hideEntity(UserHiddenEntitiesCompanion row) =>
      into(userHiddenEntities).insertOnConflictUpdate(row);

  Future<void> unhideEntity(
    int localUserId,
    String entityType,
    String entityId,
  ) =>
      (delete(userHiddenEntities)..where(
            (r) =>
                r.localUserId.equals(localUserId) &
                r.entityType.equals(entityType) &
                r.entityId.equals(entityId),
          ))
          .go();
}
