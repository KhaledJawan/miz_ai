import 'package:drift/drift.dart';

/// Local, offline conversation snapshots. The complete typed message list is
/// stored as JSON because a session is read and written as one immutable
/// archive unit; individual messages are never queried independently.
class ConversationArchives extends Table {
  IntColumn get localUserId => integer().withDefault(const Constant(1))();
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get messagesJson => text()();
  TextColumn get remoteConversationId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {localUserId, id};
}
