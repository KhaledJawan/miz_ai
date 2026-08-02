import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/profile_tables.dart';

part 'food_profile_dao.g.dart';

@DriftAccessor(tables: [FoodProfiles])
class FoodProfileDao extends DatabaseAccessor<AppDatabase>
    with _$FoodProfileDaoMixin {
  FoodProfileDao(super.db);

  Future<FoodProfile?> getProfile(int localUserId) => (select(
    foodProfiles,
  )..where((row) => row.localUserId.equals(localUserId))).getSingleOrNull();

  Stream<FoodProfile?> watchProfile(int localUserId) => (select(
    foodProfiles,
  )..where((row) => row.localUserId.equals(localUserId))).watchSingleOrNull();

  /// Creates the row if it doesn't exist yet (first launch) and always
  /// returns the current profile.
  Future<FoodProfile> ensureProfile(int localUserId) async {
    final existing = await getProfile(localUserId);
    if (existing != null) return existing;
    await into(foodProfiles).insert(
      FoodProfilesCompanion.insert(localUserId: localUserId),
      mode: InsertMode.insertOrIgnore,
    );
    return (await getProfile(localUserId))!;
  }

  Future<void> updateProfile(int localUserId, FoodProfilesCompanion patch) =>
      (update(
        foodProfiles,
      )..where((row) => row.localUserId.equals(localUserId))).write(patch);
}
