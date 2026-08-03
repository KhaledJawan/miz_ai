import 'package:drift/drift.dart';

class SavedItems extends Table {
  IntColumn get localUserId =>
      integer().withDefault(const Constant(1))(); // kLocalUserId
  TextColumn get itemType => text()();
  TextColumn get itemId => text()();
  TextColumn get title => text()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get imageAsset => text().nullable()();
  TextColumn get metadataJson => text().nullable()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {localUserId, itemType, itemId};
}
