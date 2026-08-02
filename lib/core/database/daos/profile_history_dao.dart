import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/interaction_tables.dart';

part 'profile_history_dao.g.dart';

@DriftAccessor(tables: [ProfileChangeHistory])
class ProfileHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$ProfileHistoryDaoMixin {
  ProfileHistoryDao(super.db);

  Future<void> logChange(ProfileChangeHistoryCompanion row) =>
      into(profileChangeHistory).insert(row);

  Future<List<ProfileChangeHistoryData>> getHistory(
    int localUserId, {
    int limit = 100,
  }) =>
      (select(profileChangeHistory)
            ..where((row) => row.localUserId.equals(localUserId))
            ..orderBy([(row) => OrderingTerm.desc(row.changedAt)])
            ..limit(limit))
          .get();
}
