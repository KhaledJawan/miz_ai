import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/profile_tables.dart';

part 'intolerance_dao.g.dart';

@DriftAccessor(tables: [Intolerances, UserIntolerances])
class IntoleranceDao extends DatabaseAccessor<AppDatabase>
    with _$IntoleranceDaoMixin {
  IntoleranceDao(super.db);

  Future<List<Intolerance>> getAllIntolerances() => select(intolerances).get();

  Stream<List<UserIntolerance>> watchUserIntolerances(int localUserId) =>
      (select(
        userIntolerances,
      )..where((row) => row.localUserId.equals(localUserId))).watch();

  Future<List<UserIntolerance>> getUserIntolerances(int localUserId) => (select(
    userIntolerances,
  )..where((row) => row.localUserId.equals(localUserId))).get();

  Future<void> replaceUserIntolerances(
    int localUserId,
    List<UserIntolerancesCompanion> rows,
  ) {
    return transaction(() async {
      await (delete(
        userIntolerances,
      )..where((row) => row.localUserId.equals(localUserId))).go();
      for (final row in rows) {
        await into(userIntolerances).insert(row);
      }
    });
  }
}
