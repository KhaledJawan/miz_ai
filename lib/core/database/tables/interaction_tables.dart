import 'package:drift/drift.dart';

/// Local interaction/event log — see [InteractionTracker]. `entityId` is
/// text because entities today come from mixed id spaces (Drift integer
/// ids for food-profile entities, `Restaurant.id` strings for restaurants).
class UserFoodInteractions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  TextColumn get sessionId => text()();
  TextColumn get eventType => text()();
  TextColumn get entityType => text().nullable()();
  TextColumn get entityId => text().nullable()();
  TextColumn get screenName => text().nullable()();
  TextColumn get sourceSection => text().nullable()();
  IntColumn get positionIndex => integer().nullable()();
  TextColumn get searchQuery => text().nullable()();
  IntColumn get dwellTimeMs => integer().nullable()();
  TextColumn get metadataJson => text().nullable()();
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}

class UserHiddenEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {localUserId, entityType, entityId},
  ];
}

/// Transparency log for meaningful profile changes — every explicit edit
/// and every accepted behavioral-inference write lands here.
class ProfileChangeHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get localUserId => integer()();
  TextColumn get section => text()();
  TextColumn get fieldKey => text()();
  TextColumn get oldValueJson => text().nullable()();
  TextColumn get newValueJson => text().nullable()();
  TextColumn get source => text()();
  DateTimeColumn get changedAt => dateTime().withDefault(currentDateAndTime)();
}
