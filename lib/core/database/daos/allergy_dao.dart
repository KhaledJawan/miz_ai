import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/profile_tables.dart';

part 'allergy_dao.g.dart';

@DriftAccessor(tables: [Allergens, UserAllergies])
class AllergyDao extends DatabaseAccessor<AppDatabase> with _$AllergyDaoMixin {
  AllergyDao(super.db);

  Future<List<Allergen>> getAllAllergens() => select(allergens).get();

  Stream<List<UserAllergy>> watchUserAllergies(int localUserId) => (select(
    userAllergies,
  )..where((row) => row.localUserId.equals(localUserId))).watch();

  Future<List<UserAllergy>> getUserAllergies(int localUserId) => (select(
    userAllergies,
  )..where((row) => row.localUserId.equals(localUserId))).get();

  Future<List<UserAllergy>> getSevereActiveAllergies(int localUserId) =>
      (select(userAllergies)..where(
            (row) =>
                row.localUserId.equals(localUserId) &
                row.isActive.equals(true) &
                row.severity.equals('severe'),
          ))
          .get();

  Future<void> replaceUserAllergies(
    int localUserId,
    List<UserAllergiesCompanion> rows,
  ) {
    return transaction(() async {
      await (delete(
        userAllergies,
      )..where((row) => row.localUserId.equals(localUserId))).go();
      for (final row in rows) {
        await into(userAllergies).insert(row);
      }
    });
  }

  Future<void> clearUserAllergies(int localUserId) => (delete(
    userAllergies,
  )..where((row) => row.localUserId.equals(localUserId))).go();
}
