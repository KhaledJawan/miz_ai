import 'package:drift/drift.dart' show Value;

import '../../../core/database/app_database.dart' as drift;
import '../../../core/database/local_user.dart';
import '../domain/entities.dart';
import '../domain/food_profile_enums.dart';
import '../domain/food_profile_repository.dart';

/// Drift-backed [FoodProfileRepository]. Owns every mapping between Drift
/// rows and domain entities so nothing above this layer imports Drift
/// types — see docs/ARCHITECTURE.md §4. The `drift.` prefix disambiguates
/// Drift's auto-generated row classes (e.g. `drift.FoodProfile`,
/// `drift.UserAllergy`) from this feature's own domain entities of the
/// same name.
class FoodProfileRepositoryImpl implements FoodProfileRepository {
  FoodProfileRepositoryImpl(this._db);

  final drift.AppDatabase _db;
  static const _localUserId = kLocalUserId;

  // ---- Profile ----

  @override
  Future<FoodProfile> ensureProfile() async {
    final row = await _db.foodProfileDao.ensureProfile(_localUserId);
    return _mapProfile(row);
  }

  @override
  Stream<FoodProfile> watchProfile() => _db.foodProfileDao
      .watchProfile(_localUserId)
      .asyncMap(
        (row) async => _mapProfile(
          row ?? await _db.foodProfileDao.ensureProfile(_localUserId),
        ),
      );

  @override
  Future<void> updateDiet(DietType dietType) async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      drift.FoodProfilesCompanion(dietType: Value(dietType.name)),
    );
  }

  @override
  Future<void> updateEatingStyle({
    AdventurousnessLevel? adventurousnessLevel,
    MealWeightPreference? preferredMealWeight,
    BudgetLevel? budgetLevel,
    List<EatingPriority>? topPriorities,
  }) async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      drift.FoodProfilesCompanion(
        adventurousnessLevel: adventurousnessLevel == null
            ? const Value.absent()
            : Value(adventurousnessLevel.name),
        preferredMealWeight: preferredMealWeight == null
            ? const Value.absent()
            : Value(preferredMealWeight.name),
        budgetLevel: budgetLevel == null
            ? const Value.absent()
            : Value(budgetLevel.name),
        topPriorities: topPriorities == null
            ? const Value.absent()
            : Value(topPriorities.map((p) => p.name).join(',')),
      ),
    );
  }

  @override
  Future<void> setOnboardingStep(int step) async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      drift.FoodProfilesCompanion(
        onboardingStep: Value(step),
        onboardingStatus: const Value('inProgress'),
      ),
    );
  }

  @override
  Future<void> completeOnboarding({required int onboardingVersion}) async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      drift.FoodProfilesCompanion(
        onboardingStatus: const Value('completed'),
        onboardingVersion: Value(onboardingVersion),
        completedAt: Value(DateTime.now()),
      ),
    );
    await recomputeCompleteness();
  }

  @override
  Future<void> skipOnboarding() async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      drift.FoodProfilesCompanion(
        onboardingStatus: const Value('skipped'),
        skippedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> restartOnboarding() async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      const drift.FoodProfilesCompanion(
        onboardingStatus: Value('inProgress'),
        onboardingStep: Value(0),
      ),
    );
  }

  @override
  Future<void> setPersonalizationEnabled(bool enabled) async {
    await ensureProfile();
    await _db.foodProfileDao.updateProfile(
      _localUserId,
      drift.FoodProfilesCompanion(personalizationEnabled: Value(enabled)),
    );
  }

  @override
  Future<void> recomputeCompleteness() async {
    // Hook only: ProfileCompletenessService (domain, pure) computes the
    // score from a snapshot; FoodProfileProviders wires the two together
    // so this repository stays free of business logic.
  }

  FoodProfile _mapProfile(drift.FoodProfile row) => FoodProfile(
    id: row.id,
    localUserId: row.localUserId,
    dietType: enumFromName(DietType.values, row.dietType, DietType.unknown),
    adventurousnessLevel: row.adventurousnessLevel == null
        ? null
        : enumFromName(
            AdventurousnessLevel.values,
            row.adventurousnessLevel,
            AdventurousnessLevel.sometimes,
          ),
    preferredMealWeight: row.preferredMealWeight == null
        ? null
        : enumFromName(
            MealWeightPreference.values,
            row.preferredMealWeight,
            MealWeightPreference.balanced,
          ),
    budgetLevel: row.budgetLevel == null
        ? null
        : enumFromName(
            BudgetLevel.values,
            row.budgetLevel,
            BudgetLevel.noPreference,
          ),
    topPriorities: (row.topPriorities ?? '')
        .split(',')
        .where((s) => s.isNotEmpty)
        .map(
          (s) => enumFromName(EatingPriority.values, s, EatingPriority.taste),
        )
        .toList(),
    onboardingStatus: enumFromName(
      OnboardingStatus.values,
      row.onboardingStatus,
      OnboardingStatus.notStarted,
    ),
    onboardingVersion: row.onboardingVersion,
    onboardingStep: row.onboardingStep,
    personalizationEnabled: row.personalizationEnabled,
    profileCompleteness: row.profileCompleteness,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    completedAt: row.completedAt,
    skippedAt: row.skippedAt,
  );

  // ---- Catalogs ----

  @override
  Future<List<CatalogEntry>> getAllergenCatalog() async =>
      (await _db.allergyDao.getAllAllergens())
          .map(
            (row) => CatalogEntry(
              id: row.id,
              code: row.code,
              category: row.category,
            ),
          )
          .toList();

  @override
  Future<List<CatalogEntry>> getIntoleranceCatalog() async =>
      (await _db.intoleranceDao.getAllIntolerances())
          .map((row) => CatalogEntry(id: row.id, code: row.code))
          .toList();

  @override
  Future<List<CatalogEntry>> getFoodRuleCatalog() async {
    final rows = await _db.select(_db.foodRules).get();
    return rows
        .map(
          (row) =>
              CatalogEntry(id: row.id, code: row.code, category: row.category),
        )
        .toList();
  }

  @override
  Future<List<CatalogEntry>> getCuisineCatalog() async =>
      (await _db.cuisinePreferenceDao.getAllCuisines())
          .map(
            (row) =>
                CatalogEntry(id: row.id, code: row.code, category: row.region),
          )
          .toList();

  @override
  Future<List<CatalogEntry>> getFlavorAttributeCatalog() async =>
      (await _db.flavorPreferenceDao.getAllFlavorAttributes())
          .map((row) => CatalogEntry(id: row.id, code: row.code))
          .toList();

  @override
  Future<List<IngredientEntry>> getIngredientCatalog() async =>
      (await _db.ingredientPreferenceDao.getAllIngredients())
          .map(
            (row) => IngredientEntry(
              id: row.id,
              code: row.code,
              parentId: row.parentId,
              category: row.category,
              isAnimalProduct: row.isAnimalProduct,
              isMeat: row.isMeat,
              isSeafood: row.isSeafood,
              isAlcoholRelated: row.isAlcoholRelated,
            ),
          )
          .toList();

  @override
  Future<List<FoodItemEntry>> getFoodItemCatalog() async {
    final items = await _db.foodItemDao.getAllFoodItems();
    final result = <FoodItemEntry>[];
    for (final item in items) {
      final ingredientLinks = await _db.foodItemDao.getIngredientLinks(item.id);
      final allergenLinks = await _db.foodItemDao.getAllergenLinks(item.id);
      result.add(
        FoodItemEntry(
          id: item.id,
          code: item.canonicalName,
          cuisineId: item.cuisineId,
          imageAsset: item.localImageAsset,
          primaryIngredientIds: ingredientLinks
              .where((l) => l.isPrimary)
              .map((l) => l.ingredientId)
              .toList(),
          mayContainIngredientIds: ingredientLinks
              .where((l) => l.mayContain)
              .map((l) => l.ingredientId)
              .toList(),
          allergenIds: allergenLinks
              .where((l) => l.relationType == 'contains')
              .map((l) => l.allergenId)
              .toList(),
          mayContainAllergenIds: allergenLinks
              .where((l) => l.relationType == 'mayContain')
              .map((l) => l.allergenId)
              .toList(),
        ),
      );
    }
    return result;
  }

  // ---- Food rules ----

  @override
  Future<List<UserFoodRuleSelection>> getFoodRules() async {
    final rules = await _db.select(_db.foodRules).get();
    final codeById = {for (final r in rules) r.id: r.code};
    final rows = await (_db.select(
      _db.userFoodRules,
    )..where((row) => row.localUserId.equals(_localUserId))).get();
    return rows
        .map(
          (row) => UserFoodRuleSelection(
            id: row.id,
            foodRuleId: row.foodRuleId,
            foodRuleCode: codeById[row.foodRuleId] ?? 'unknown',
            requirementLevel: enumFromName(
              RequirementLevel.values,
              row.requirementLevel,
              RequirementLevel.unknown,
            ),
            source: enumFromName(
              PreferenceSource.values,
              row.source,
              PreferenceSource.explicit,
            ),
            notes: row.notes,
          ),
        )
        .toList();
  }

  @override
  Future<void> replaceFoodRules(List<UserFoodRuleSelection> selections) async {
    await _db.transaction(() async {
      await (_db.delete(
        _db.userFoodRules,
      )..where((row) => row.localUserId.equals(_localUserId))).go();
      for (final selection in selections) {
        await _db
            .into(_db.userFoodRules)
            .insert(
              drift.UserFoodRulesCompanion.insert(
                localUserId: _localUserId,
                foodRuleId: selection.foodRuleId,
                requirementLevel: selection.requirementLevel.name,
                source: selection.source.name,
                notes: Value(selection.notes),
              ),
            );
      }
    });
  }

  // ---- Allergies ----

  @override
  Future<List<UserAllergy>> getAllergies() async {
    final allergens = await _db.allergyDao.getAllAllergens();
    final codeById = {for (final a in allergens) a.id: a.code};
    final rows = await _db.allergyDao.getUserAllergies(_localUserId);
    return rows.map((row) => _mapAllergy(row, codeById)).toList();
  }

  @override
  Stream<List<UserAllergy>> watchAllergies() async* {
    final allergens = await _db.allergyDao.getAllAllergens();
    final codeById = {for (final a in allergens) a.id: a.code};
    yield* _db.allergyDao
        .watchUserAllergies(_localUserId)
        .map((rows) => rows.map((row) => _mapAllergy(row, codeById)).toList());
  }

  UserAllergy _mapAllergy(drift.UserAllergy row, Map<int, String> codeById) =>
      UserAllergy(
        id: row.id,
        allergenId: row.allergenId,
        allergenCode: row.allergenId == null ? null : codeById[row.allergenId],
        customName: row.customName,
        severity: enumFromName(
          AllergySeverity.values,
          row.severity,
          AllergySeverity.unspecified,
        ),
        notes: row.notes,
        isActive: row.isActive,
        source: enumFromName(
          PreferenceSource.values,
          row.source,
          PreferenceSource.explicit,
        ),
      );

  @override
  Future<void> replaceAllergies(List<UserAllergy> allergies) async {
    await _db.allergyDao.replaceUserAllergies(
      _localUserId,
      allergies
          .map(
            (a) => drift.UserAllergiesCompanion.insert(
              localUserId: _localUserId,
              allergenId: Value(a.allergenId),
              customName: Value(a.customName),
              severity: Value(a.severity.name),
              notes: Value(a.notes),
              isActive: Value(a.isActive),
              source: Value(a.source.name),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> clearAllergies() =>
      _db.allergyDao.clearUserAllergies(_localUserId);

  // ---- Intolerances ----

  @override
  Future<List<UserIntolerance>> getIntolerances() async {
    final catalog = await _db.intoleranceDao.getAllIntolerances();
    final codeById = {for (final i in catalog) i.id: i.code};
    final rows = await _db.intoleranceDao.getUserIntolerances(_localUserId);
    return rows
        .map(
          (row) => UserIntolerance(
            id: row.id,
            intoleranceId: row.intoleranceId,
            intoleranceCode: row.intoleranceId == null
                ? null
                : codeById[row.intoleranceId],
            customName: row.customName,
            severity: enumFromName(
              AllergySeverity.values,
              row.severity,
              AllergySeverity.unspecified,
            ),
            notes: row.notes,
            isActive: row.isActive,
          ),
        )
        .toList();
  }

  @override
  Future<void> replaceIntolerances(List<UserIntolerance> intolerances) async {
    await _db.intoleranceDao.replaceUserIntolerances(
      _localUserId,
      intolerances
          .map(
            (i) => drift.UserIntolerancesCompanion.insert(
              localUserId: _localUserId,
              intoleranceId: Value(i.intoleranceId),
              customName: Value(i.customName),
              severity: Value(i.severity.name),
              notes: Value(i.notes),
              isActive: Value(i.isActive),
            ),
          )
          .toList(),
    );
  }

  // ---- Ingredient preferences ----

  @override
  Future<List<UserIngredientPreferenceEntry>> getIngredientPreferences() async {
    final catalog = await _db.ingredientPreferenceDao.getAllIngredients();
    final codeById = {for (final i in catalog) i.id: i.code};
    final rows = await _db.ingredientPreferenceDao.getUserPreferences(
      _localUserId,
    );
    return rows
        .map(
          (row) => UserIngredientPreferenceEntry(
            id: row.id,
            ingredientId: row.ingredientId,
            ingredientCode: codeById[row.ingredientId] ?? 'unknown',
            preferenceState: enumFromName(
              PreferenceState.values,
              row.preferenceState,
              PreferenceState.unknown,
            ),
            restrictionType: enumFromName(
              RestrictionType.values,
              row.restrictionType,
              RestrictionType.none,
            ),
            source: enumFromName(
              PreferenceSource.values,
              row.source,
              PreferenceSource.explicit,
            ),
            confidence: row.confidence,
            notes: row.notes,
          ),
        )
        .toList();
  }

  @override
  Future<void> upsertIngredientPreference(
    int ingredientId,
    PreferenceState state,
    RestrictionType restriction,
  ) => _db.ingredientPreferenceDao.upsertPreference(
    drift.UserIngredientPreferencesCompanion.insert(
      localUserId: _localUserId,
      ingredientId: ingredientId,
      preferenceState: Value(state.name),
      restrictionType: Value(restriction.name),
    ),
  );

  // ---- Cuisine preferences ----

  @override
  Future<List<UserCuisinePreferenceEntry>> getCuisinePreferences() async {
    final catalog = await _db.cuisinePreferenceDao.getAllCuisines();
    final codeById = {for (final c in catalog) c.id: c.code};
    final rows = await _db.cuisinePreferenceDao.getUserPreferences(
      _localUserId,
    );
    return rows
        .map(
          (row) => UserCuisinePreferenceEntry(
            id: row.id,
            cuisineId: row.cuisineId,
            cuisineCode: codeById[row.cuisineId] ?? 'unknown',
            preferenceState: enumFromName(
              PreferenceState.values,
              row.preferenceState,
              PreferenceState.unknown,
            ),
            curiosityScore: row.curiosityScore,
            source: enumFromName(
              PreferenceSource.values,
              row.source,
              PreferenceSource.explicit,
            ),
            confidence: row.confidence,
          ),
        )
        .toList();
  }

  @override
  Future<void> upsertCuisinePreference(int cuisineId, PreferenceState state) =>
      _db.cuisinePreferenceDao.upsertPreference(
        drift.UserCuisinePreferencesCompanion.insert(
          localUserId: _localUserId,
          cuisineId: cuisineId,
          preferenceState: Value(state.name),
        ),
      );

  // ---- Flavor preferences ----

  @override
  Future<List<UserFlavorPreferenceEntry>> getFlavorPreferences() async {
    final catalog = await _db.flavorPreferenceDao.getAllFlavorAttributes();
    final codeById = {for (final f in catalog) f.id: f.code};
    final rows = await _db.flavorPreferenceDao.getUserPreferences(_localUserId);
    return rows
        .map(
          (row) => UserFlavorPreferenceEntry(
            id: row.id,
            flavorAttributeId: row.flavorAttributeId,
            flavorAttributeCode: codeById[row.flavorAttributeId] ?? 'unknown',
            preferenceLevel: row.preferenceLevel,
            source: enumFromName(
              PreferenceSource.values,
              row.source,
              PreferenceSource.explicit,
            ),
          ),
        )
        .toList();
  }

  @override
  Future<void> upsertFlavorPreference(int flavorAttributeId, int level) =>
      _db.flavorPreferenceDao.upsertPreference(
        drift.UserFlavorPreferencesCompanion.insert(
          localUserId: _localUserId,
          flavorAttributeId: flavorAttributeId,
          preferenceLevel: Value(level),
        ),
      );

  // ---- Food item preferences ----

  @override
  Future<List<UserFoodItemPreferenceEntry>> getFoodItemPreferences() async {
    final rows = await _db.foodItemDao.getUserPreferences(_localUserId);
    return rows
        .map(
          (row) => UserFoodItemPreferenceEntry(
            id: row.id,
            foodItemId: row.foodItemId,
            preferenceState: enumFromName(
              PreferenceState.values,
              row.preferenceState,
              PreferenceState.unknown,
            ),
            source: enumFromName(
              PreferenceSource.values,
              row.source,
              PreferenceSource.explicit,
            ),
          ),
        )
        .toList();
  }

  @override
  Future<void> upsertFoodItemPreference(
    int foodItemId,
    PreferenceState state,
  ) => _db.foodItemDao.upsertPreference(
    drift.UserFoodItemPreferencesCompanion.insert(
      localUserId: _localUserId,
      foodItemId: foodItemId,
      preferenceState: Value(state.name),
    ),
  );

  // ---- Reset / privacy ----

  @override
  Future<void> resetFoodProfile() async {
    await _db.transaction(() async {
      await clearAllergies();
      await replaceIntolerances(const []);
      await replaceFoodRules(const []);
      await (_db.delete(
        _db.userIngredientPreferences,
      )..where((row) => row.localUserId.equals(_localUserId))).go();
      await (_db.delete(
        _db.userCuisinePreferences,
      )..where((row) => row.localUserId.equals(_localUserId))).go();
      await (_db.delete(
        _db.userFlavorPreferences,
      )..where((row) => row.localUserId.equals(_localUserId))).go();
      await (_db.delete(
        _db.userFoodItemPreferences,
      )..where((row) => row.localUserId.equals(_localUserId))).go();
      await _db.foodProfileDao.updateProfile(
        _localUserId,
        const drift.FoodProfilesCompanion(
          dietType: Value('unknown'),
          onboardingStatus: Value('notStarted'),
          onboardingStep: Value(0),
          profileCompleteness: Value(0),
        ),
      );
    });
  }

  @override
  Future<void> deleteInteractionHistory() =>
      _db.interactionDao.deleteAllInteractions(_localUserId);
}
