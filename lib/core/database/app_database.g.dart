// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodProfilesTable extends FoodProfiles
    with TableInfo<$FoodProfilesTable, FoodProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dietTypeMeta = const VerificationMeta(
    'dietType',
  );
  @override
  late final GeneratedColumn<String> dietType = GeneratedColumn<String>(
    'diet_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  static const VerificationMeta _adventurousnessLevelMeta =
      const VerificationMeta('adventurousnessLevel');
  @override
  late final GeneratedColumn<String> adventurousnessLevel =
      GeneratedColumn<String>(
        'adventurousness_level',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _preferredMealWeightMeta =
      const VerificationMeta('preferredMealWeight');
  @override
  late final GeneratedColumn<String> preferredMealWeight =
      GeneratedColumn<String>(
        'preferred_meal_weight',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _budgetLevelMeta = const VerificationMeta(
    'budgetLevel',
  );
  @override
  late final GeneratedColumn<String> budgetLevel = GeneratedColumn<String>(
    'budget_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _topPrioritiesMeta = const VerificationMeta(
    'topPriorities',
  );
  @override
  late final GeneratedColumn<String> topPriorities = GeneratedColumn<String>(
    'top_priorities',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingStatusMeta = const VerificationMeta(
    'onboardingStatus',
  );
  @override
  late final GeneratedColumn<String> onboardingStatus = GeneratedColumn<String>(
    'onboarding_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('notStarted'),
  );
  static const VerificationMeta _onboardingVersionMeta = const VerificationMeta(
    'onboardingVersion',
  );
  @override
  late final GeneratedColumn<int> onboardingVersion = GeneratedColumn<int>(
    'onboarding_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _onboardingStepMeta = const VerificationMeta(
    'onboardingStep',
  );
  @override
  late final GeneratedColumn<int> onboardingStep = GeneratedColumn<int>(
    'onboarding_step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _personalizationEnabledMeta =
      const VerificationMeta('personalizationEnabled');
  @override
  late final GeneratedColumn<bool> personalizationEnabled =
      GeneratedColumn<bool>(
        'personalization_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("personalization_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _profileCompletenessMeta =
      const VerificationMeta('profileCompleteness');
  @override
  late final GeneratedColumn<double> profileCompleteness =
      GeneratedColumn<double>(
        'profile_completeness',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skippedAtMeta = const VerificationMeta(
    'skippedAt',
  );
  @override
  late final GeneratedColumn<DateTime> skippedAt = GeneratedColumn<DateTime>(
    'skipped_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    dietType,
    adventurousnessLevel,
    preferredMealWeight,
    budgetLevel,
    topPriorities,
    onboardingStatus,
    onboardingVersion,
    onboardingStep,
    personalizationEnabled,
    profileCompleteness,
    createdAt,
    updatedAt,
    completedAt,
    skippedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('diet_type')) {
      context.handle(
        _dietTypeMeta,
        dietType.isAcceptableOrUnknown(data['diet_type']!, _dietTypeMeta),
      );
    }
    if (data.containsKey('adventurousness_level')) {
      context.handle(
        _adventurousnessLevelMeta,
        adventurousnessLevel.isAcceptableOrUnknown(
          data['adventurousness_level']!,
          _adventurousnessLevelMeta,
        ),
      );
    }
    if (data.containsKey('preferred_meal_weight')) {
      context.handle(
        _preferredMealWeightMeta,
        preferredMealWeight.isAcceptableOrUnknown(
          data['preferred_meal_weight']!,
          _preferredMealWeightMeta,
        ),
      );
    }
    if (data.containsKey('budget_level')) {
      context.handle(
        _budgetLevelMeta,
        budgetLevel.isAcceptableOrUnknown(
          data['budget_level']!,
          _budgetLevelMeta,
        ),
      );
    }
    if (data.containsKey('top_priorities')) {
      context.handle(
        _topPrioritiesMeta,
        topPriorities.isAcceptableOrUnknown(
          data['top_priorities']!,
          _topPrioritiesMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_status')) {
      context.handle(
        _onboardingStatusMeta,
        onboardingStatus.isAcceptableOrUnknown(
          data['onboarding_status']!,
          _onboardingStatusMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_version')) {
      context.handle(
        _onboardingVersionMeta,
        onboardingVersion.isAcceptableOrUnknown(
          data['onboarding_version']!,
          _onboardingVersionMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_step')) {
      context.handle(
        _onboardingStepMeta,
        onboardingStep.isAcceptableOrUnknown(
          data['onboarding_step']!,
          _onboardingStepMeta,
        ),
      );
    }
    if (data.containsKey('personalization_enabled')) {
      context.handle(
        _personalizationEnabledMeta,
        personalizationEnabled.isAcceptableOrUnknown(
          data['personalization_enabled']!,
          _personalizationEnabledMeta,
        ),
      );
    }
    if (data.containsKey('profile_completeness')) {
      context.handle(
        _profileCompletenessMeta,
        profileCompleteness.isAcceptableOrUnknown(
          data['profile_completeness']!,
          _profileCompletenessMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('skipped_at')) {
      context.handle(
        _skippedAtMeta,
        skippedAt.isAcceptableOrUnknown(data['skipped_at']!, _skippedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId},
  ];
  @override
  FoodProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      dietType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diet_type'],
      )!,
      adventurousnessLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}adventurousness_level'],
      ),
      preferredMealWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_meal_weight'],
      ),
      budgetLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}budget_level'],
      ),
      topPriorities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}top_priorities'],
      ),
      onboardingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}onboarding_status'],
      )!,
      onboardingVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}onboarding_version'],
      )!,
      onboardingStep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}onboarding_step'],
      )!,
      personalizationEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}personalization_enabled'],
      )!,
      profileCompleteness: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}profile_completeness'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      skippedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}skipped_at'],
      ),
    );
  }

  @override
  $FoodProfilesTable createAlias(String alias) {
    return $FoodProfilesTable(attachedDatabase, alias);
  }
}

class FoodProfile extends DataClass implements Insertable<FoodProfile> {
  final int id;
  final int localUserId;
  final String dietType;
  final String? adventurousnessLevel;
  final String? preferredMealWeight;
  final String? budgetLevel;
  final String? topPriorities;
  final String onboardingStatus;
  final int onboardingVersion;
  final int onboardingStep;
  final bool personalizationEnabled;
  final double profileCompleteness;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final DateTime? skippedAt;
  const FoodProfile({
    required this.id,
    required this.localUserId,
    required this.dietType,
    this.adventurousnessLevel,
    this.preferredMealWeight,
    this.budgetLevel,
    this.topPriorities,
    required this.onboardingStatus,
    required this.onboardingVersion,
    required this.onboardingStep,
    required this.personalizationEnabled,
    required this.profileCompleteness,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.skippedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['diet_type'] = Variable<String>(dietType);
    if (!nullToAbsent || adventurousnessLevel != null) {
      map['adventurousness_level'] = Variable<String>(adventurousnessLevel);
    }
    if (!nullToAbsent || preferredMealWeight != null) {
      map['preferred_meal_weight'] = Variable<String>(preferredMealWeight);
    }
    if (!nullToAbsent || budgetLevel != null) {
      map['budget_level'] = Variable<String>(budgetLevel);
    }
    if (!nullToAbsent || topPriorities != null) {
      map['top_priorities'] = Variable<String>(topPriorities);
    }
    map['onboarding_status'] = Variable<String>(onboardingStatus);
    map['onboarding_version'] = Variable<int>(onboardingVersion);
    map['onboarding_step'] = Variable<int>(onboardingStep);
    map['personalization_enabled'] = Variable<bool>(personalizationEnabled);
    map['profile_completeness'] = Variable<double>(profileCompleteness);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || skippedAt != null) {
      map['skipped_at'] = Variable<DateTime>(skippedAt);
    }
    return map;
  }

  FoodProfilesCompanion toCompanion(bool nullToAbsent) {
    return FoodProfilesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      dietType: Value(dietType),
      adventurousnessLevel: adventurousnessLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(adventurousnessLevel),
      preferredMealWeight: preferredMealWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredMealWeight),
      budgetLevel: budgetLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetLevel),
      topPriorities: topPriorities == null && nullToAbsent
          ? const Value.absent()
          : Value(topPriorities),
      onboardingStatus: Value(onboardingStatus),
      onboardingVersion: Value(onboardingVersion),
      onboardingStep: Value(onboardingStep),
      personalizationEnabled: Value(personalizationEnabled),
      profileCompleteness: Value(profileCompleteness),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      skippedAt: skippedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(skippedAt),
    );
  }

  factory FoodProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodProfile(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      dietType: serializer.fromJson<String>(json['dietType']),
      adventurousnessLevel: serializer.fromJson<String?>(
        json['adventurousnessLevel'],
      ),
      preferredMealWeight: serializer.fromJson<String?>(
        json['preferredMealWeight'],
      ),
      budgetLevel: serializer.fromJson<String?>(json['budgetLevel']),
      topPriorities: serializer.fromJson<String?>(json['topPriorities']),
      onboardingStatus: serializer.fromJson<String>(json['onboardingStatus']),
      onboardingVersion: serializer.fromJson<int>(json['onboardingVersion']),
      onboardingStep: serializer.fromJson<int>(json['onboardingStep']),
      personalizationEnabled: serializer.fromJson<bool>(
        json['personalizationEnabled'],
      ),
      profileCompleteness: serializer.fromJson<double>(
        json['profileCompleteness'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      skippedAt: serializer.fromJson<DateTime?>(json['skippedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'dietType': serializer.toJson<String>(dietType),
      'adventurousnessLevel': serializer.toJson<String?>(adventurousnessLevel),
      'preferredMealWeight': serializer.toJson<String?>(preferredMealWeight),
      'budgetLevel': serializer.toJson<String?>(budgetLevel),
      'topPriorities': serializer.toJson<String?>(topPriorities),
      'onboardingStatus': serializer.toJson<String>(onboardingStatus),
      'onboardingVersion': serializer.toJson<int>(onboardingVersion),
      'onboardingStep': serializer.toJson<int>(onboardingStep),
      'personalizationEnabled': serializer.toJson<bool>(personalizationEnabled),
      'profileCompleteness': serializer.toJson<double>(profileCompleteness),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'skippedAt': serializer.toJson<DateTime?>(skippedAt),
    };
  }

  FoodProfile copyWith({
    int? id,
    int? localUserId,
    String? dietType,
    Value<String?> adventurousnessLevel = const Value.absent(),
    Value<String?> preferredMealWeight = const Value.absent(),
    Value<String?> budgetLevel = const Value.absent(),
    Value<String?> topPriorities = const Value.absent(),
    String? onboardingStatus,
    int? onboardingVersion,
    int? onboardingStep,
    bool? personalizationEnabled,
    double? profileCompleteness,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<DateTime?> skippedAt = const Value.absent(),
  }) => FoodProfile(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    dietType: dietType ?? this.dietType,
    adventurousnessLevel: adventurousnessLevel.present
        ? adventurousnessLevel.value
        : this.adventurousnessLevel,
    preferredMealWeight: preferredMealWeight.present
        ? preferredMealWeight.value
        : this.preferredMealWeight,
    budgetLevel: budgetLevel.present ? budgetLevel.value : this.budgetLevel,
    topPriorities: topPriorities.present
        ? topPriorities.value
        : this.topPriorities,
    onboardingStatus: onboardingStatus ?? this.onboardingStatus,
    onboardingVersion: onboardingVersion ?? this.onboardingVersion,
    onboardingStep: onboardingStep ?? this.onboardingStep,
    personalizationEnabled:
        personalizationEnabled ?? this.personalizationEnabled,
    profileCompleteness: profileCompleteness ?? this.profileCompleteness,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    skippedAt: skippedAt.present ? skippedAt.value : this.skippedAt,
  );
  FoodProfile copyWithCompanion(FoodProfilesCompanion data) {
    return FoodProfile(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      dietType: data.dietType.present ? data.dietType.value : this.dietType,
      adventurousnessLevel: data.adventurousnessLevel.present
          ? data.adventurousnessLevel.value
          : this.adventurousnessLevel,
      preferredMealWeight: data.preferredMealWeight.present
          ? data.preferredMealWeight.value
          : this.preferredMealWeight,
      budgetLevel: data.budgetLevel.present
          ? data.budgetLevel.value
          : this.budgetLevel,
      topPriorities: data.topPriorities.present
          ? data.topPriorities.value
          : this.topPriorities,
      onboardingStatus: data.onboardingStatus.present
          ? data.onboardingStatus.value
          : this.onboardingStatus,
      onboardingVersion: data.onboardingVersion.present
          ? data.onboardingVersion.value
          : this.onboardingVersion,
      onboardingStep: data.onboardingStep.present
          ? data.onboardingStep.value
          : this.onboardingStep,
      personalizationEnabled: data.personalizationEnabled.present
          ? data.personalizationEnabled.value
          : this.personalizationEnabled,
      profileCompleteness: data.profileCompleteness.present
          ? data.profileCompleteness.value
          : this.profileCompleteness,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      skippedAt: data.skippedAt.present ? data.skippedAt.value : this.skippedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodProfile(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('dietType: $dietType, ')
          ..write('adventurousnessLevel: $adventurousnessLevel, ')
          ..write('preferredMealWeight: $preferredMealWeight, ')
          ..write('budgetLevel: $budgetLevel, ')
          ..write('topPriorities: $topPriorities, ')
          ..write('onboardingStatus: $onboardingStatus, ')
          ..write('onboardingVersion: $onboardingVersion, ')
          ..write('onboardingStep: $onboardingStep, ')
          ..write('personalizationEnabled: $personalizationEnabled, ')
          ..write('profileCompleteness: $profileCompleteness, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('skippedAt: $skippedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    dietType,
    adventurousnessLevel,
    preferredMealWeight,
    budgetLevel,
    topPriorities,
    onboardingStatus,
    onboardingVersion,
    onboardingStep,
    personalizationEnabled,
    profileCompleteness,
    createdAt,
    updatedAt,
    completedAt,
    skippedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodProfile &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.dietType == this.dietType &&
          other.adventurousnessLevel == this.adventurousnessLevel &&
          other.preferredMealWeight == this.preferredMealWeight &&
          other.budgetLevel == this.budgetLevel &&
          other.topPriorities == this.topPriorities &&
          other.onboardingStatus == this.onboardingStatus &&
          other.onboardingVersion == this.onboardingVersion &&
          other.onboardingStep == this.onboardingStep &&
          other.personalizationEnabled == this.personalizationEnabled &&
          other.profileCompleteness == this.profileCompleteness &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt &&
          other.skippedAt == this.skippedAt);
}

class FoodProfilesCompanion extends UpdateCompanion<FoodProfile> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<String> dietType;
  final Value<String?> adventurousnessLevel;
  final Value<String?> preferredMealWeight;
  final Value<String?> budgetLevel;
  final Value<String?> topPriorities;
  final Value<String> onboardingStatus;
  final Value<int> onboardingVersion;
  final Value<int> onboardingStep;
  final Value<bool> personalizationEnabled;
  final Value<double> profileCompleteness;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> skippedAt;
  const FoodProfilesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.dietType = const Value.absent(),
    this.adventurousnessLevel = const Value.absent(),
    this.preferredMealWeight = const Value.absent(),
    this.budgetLevel = const Value.absent(),
    this.topPriorities = const Value.absent(),
    this.onboardingStatus = const Value.absent(),
    this.onboardingVersion = const Value.absent(),
    this.onboardingStep = const Value.absent(),
    this.personalizationEnabled = const Value.absent(),
    this.profileCompleteness = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.skippedAt = const Value.absent(),
  });
  FoodProfilesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    this.dietType = const Value.absent(),
    this.adventurousnessLevel = const Value.absent(),
    this.preferredMealWeight = const Value.absent(),
    this.budgetLevel = const Value.absent(),
    this.topPriorities = const Value.absent(),
    this.onboardingStatus = const Value.absent(),
    this.onboardingVersion = const Value.absent(),
    this.onboardingStep = const Value.absent(),
    this.personalizationEnabled = const Value.absent(),
    this.profileCompleteness = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.skippedAt = const Value.absent(),
  }) : localUserId = Value(localUserId);
  static Insertable<FoodProfile> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<String>? dietType,
    Expression<String>? adventurousnessLevel,
    Expression<String>? preferredMealWeight,
    Expression<String>? budgetLevel,
    Expression<String>? topPriorities,
    Expression<String>? onboardingStatus,
    Expression<int>? onboardingVersion,
    Expression<int>? onboardingStep,
    Expression<bool>? personalizationEnabled,
    Expression<double>? profileCompleteness,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? skippedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (dietType != null) 'diet_type': dietType,
      if (adventurousnessLevel != null)
        'adventurousness_level': adventurousnessLevel,
      if (preferredMealWeight != null)
        'preferred_meal_weight': preferredMealWeight,
      if (budgetLevel != null) 'budget_level': budgetLevel,
      if (topPriorities != null) 'top_priorities': topPriorities,
      if (onboardingStatus != null) 'onboarding_status': onboardingStatus,
      if (onboardingVersion != null) 'onboarding_version': onboardingVersion,
      if (onboardingStep != null) 'onboarding_step': onboardingStep,
      if (personalizationEnabled != null)
        'personalization_enabled': personalizationEnabled,
      if (profileCompleteness != null)
        'profile_completeness': profileCompleteness,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (skippedAt != null) 'skipped_at': skippedAt,
    });
  }

  FoodProfilesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<String>? dietType,
    Value<String?>? adventurousnessLevel,
    Value<String?>? preferredMealWeight,
    Value<String?>? budgetLevel,
    Value<String?>? topPriorities,
    Value<String>? onboardingStatus,
    Value<int>? onboardingVersion,
    Value<int>? onboardingStep,
    Value<bool>? personalizationEnabled,
    Value<double>? profileCompleteness,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime?>? skippedAt,
  }) {
    return FoodProfilesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      dietType: dietType ?? this.dietType,
      adventurousnessLevel: adventurousnessLevel ?? this.adventurousnessLevel,
      preferredMealWeight: preferredMealWeight ?? this.preferredMealWeight,
      budgetLevel: budgetLevel ?? this.budgetLevel,
      topPriorities: topPriorities ?? this.topPriorities,
      onboardingStatus: onboardingStatus ?? this.onboardingStatus,
      onboardingVersion: onboardingVersion ?? this.onboardingVersion,
      onboardingStep: onboardingStep ?? this.onboardingStep,
      personalizationEnabled:
          personalizationEnabled ?? this.personalizationEnabled,
      profileCompleteness: profileCompleteness ?? this.profileCompleteness,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      skippedAt: skippedAt ?? this.skippedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (dietType.present) {
      map['diet_type'] = Variable<String>(dietType.value);
    }
    if (adventurousnessLevel.present) {
      map['adventurousness_level'] = Variable<String>(
        adventurousnessLevel.value,
      );
    }
    if (preferredMealWeight.present) {
      map['preferred_meal_weight'] = Variable<String>(
        preferredMealWeight.value,
      );
    }
    if (budgetLevel.present) {
      map['budget_level'] = Variable<String>(budgetLevel.value);
    }
    if (topPriorities.present) {
      map['top_priorities'] = Variable<String>(topPriorities.value);
    }
    if (onboardingStatus.present) {
      map['onboarding_status'] = Variable<String>(onboardingStatus.value);
    }
    if (onboardingVersion.present) {
      map['onboarding_version'] = Variable<int>(onboardingVersion.value);
    }
    if (onboardingStep.present) {
      map['onboarding_step'] = Variable<int>(onboardingStep.value);
    }
    if (personalizationEnabled.present) {
      map['personalization_enabled'] = Variable<bool>(
        personalizationEnabled.value,
      );
    }
    if (profileCompleteness.present) {
      map['profile_completeness'] = Variable<double>(profileCompleteness.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (skippedAt.present) {
      map['skipped_at'] = Variable<DateTime>(skippedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodProfilesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('dietType: $dietType, ')
          ..write('adventurousnessLevel: $adventurousnessLevel, ')
          ..write('preferredMealWeight: $preferredMealWeight, ')
          ..write('budgetLevel: $budgetLevel, ')
          ..write('topPriorities: $topPriorities, ')
          ..write('onboardingStatus: $onboardingStatus, ')
          ..write('onboardingVersion: $onboardingVersion, ')
          ..write('onboardingStep: $onboardingStep, ')
          ..write('personalizationEnabled: $personalizationEnabled, ')
          ..write('profileCompleteness: $profileCompleteness, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('skippedAt: $skippedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodRulesTable extends FoodRules
    with TableInfo<$FoodRulesTable, FoodRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    displayNameKey,
    category,
    isBuiltIn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FoodRulesTable createAlias(String alias) {
    return $FoodRulesTable(attachedDatabase, alias);
  }
}

class FoodRule extends DataClass implements Insertable<FoodRule> {
  final int id;
  final String code;
  final String displayNameKey;
  final String category;
  final bool isBuiltIn;
  final DateTime createdAt;
  const FoodRule({
    required this.id,
    required this.code,
    required this.displayNameKey,
    required this.category,
    required this.isBuiltIn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['display_name_key'] = Variable<String>(displayNameKey);
    map['category'] = Variable<String>(category);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodRulesCompanion toCompanion(bool nullToAbsent) {
    return FoodRulesCompanion(
      id: Value(id),
      code: Value(code),
      displayNameKey: Value(displayNameKey),
      category: Value(category),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
    );
  }

  factory FoodRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodRule(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      category: serializer.fromJson<String>(json['category']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'category': serializer.toJson<String>(category),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FoodRule copyWith({
    int? id,
    String? code,
    String? displayNameKey,
    String? category,
    bool? isBuiltIn,
    DateTime? createdAt,
  }) => FoodRule(
    id: id ?? this.id,
    code: code ?? this.code,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    category: category ?? this.category,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
  );
  FoodRule copyWithCompanion(FoodRulesCompanion data) {
    return FoodRule(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      category: data.category.present ? data.category.value : this.category,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodRule(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('category: $category, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, displayNameKey, category, isBuiltIn, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodRule &&
          other.id == this.id &&
          other.code == this.code &&
          other.displayNameKey == this.displayNameKey &&
          other.category == this.category &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt);
}

class FoodRulesCompanion extends UpdateCompanion<FoodRule> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> displayNameKey;
  final Value<String> category;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  const FoodRulesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.category = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodRulesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String displayNameKey,
    required String category,
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : code = Value(code),
       displayNameKey = Value(displayNameKey),
       category = Value(category);
  static Insertable<FoodRule> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? displayNameKey,
    Expression<String>? category,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (category != null) 'category': category,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? displayNameKey,
    Value<String>? category,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
  }) {
    return FoodRulesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      category: category ?? this.category,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodRulesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('category: $category, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserFoodRulesTable extends UserFoodRules
    with TableInfo<$UserFoodRulesTable, UserFoodRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFoodRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodRuleIdMeta = const VerificationMeta(
    'foodRuleId',
  );
  @override
  late final GeneratedColumn<int> foodRuleId = GeneratedColumn<int>(
    'food_rule_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food_rules (id)',
    ),
  );
  static const VerificationMeta _requirementLevelMeta = const VerificationMeta(
    'requirementLevel',
  );
  @override
  late final GeneratedColumn<String> requirementLevel = GeneratedColumn<String>(
    'requirement_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    foodRuleId,
    requirementLevel,
    source,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_food_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserFoodRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('food_rule_id')) {
      context.handle(
        _foodRuleIdMeta,
        foodRuleId.isAcceptableOrUnknown(
          data['food_rule_id']!,
          _foodRuleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodRuleIdMeta);
    }
    if (data.containsKey('requirement_level')) {
      context.handle(
        _requirementLevelMeta,
        requirementLevel.isAcceptableOrUnknown(
          data['requirement_level']!,
          _requirementLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requirementLevelMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId, foodRuleId},
  ];
  @override
  UserFoodRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFoodRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      foodRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_rule_id'],
      )!,
      requirementLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requirement_level'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserFoodRulesTable createAlias(String alias) {
    return $UserFoodRulesTable(attachedDatabase, alias);
  }
}

class UserFoodRule extends DataClass implements Insertable<UserFoodRule> {
  final int id;
  final int localUserId;
  final int foodRuleId;
  final String requirementLevel;
  final String source;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserFoodRule({
    required this.id,
    required this.localUserId,
    required this.foodRuleId,
    required this.requirementLevel,
    required this.source,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['food_rule_id'] = Variable<int>(foodRuleId);
    map['requirement_level'] = Variable<String>(requirementLevel);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserFoodRulesCompanion toCompanion(bool nullToAbsent) {
    return UserFoodRulesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      foodRuleId: Value(foodRuleId),
      requirementLevel: Value(requirementLevel),
      source: Value(source),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserFoodRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFoodRule(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      foodRuleId: serializer.fromJson<int>(json['foodRuleId']),
      requirementLevel: serializer.fromJson<String>(json['requirementLevel']),
      source: serializer.fromJson<String>(json['source']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'foodRuleId': serializer.toJson<int>(foodRuleId),
      'requirementLevel': serializer.toJson<String>(requirementLevel),
      'source': serializer.toJson<String>(source),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserFoodRule copyWith({
    int? id,
    int? localUserId,
    int? foodRuleId,
    String? requirementLevel,
    String? source,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserFoodRule(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    foodRuleId: foodRuleId ?? this.foodRuleId,
    requirementLevel: requirementLevel ?? this.requirementLevel,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserFoodRule copyWithCompanion(UserFoodRulesCompanion data) {
    return UserFoodRule(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      foodRuleId: data.foodRuleId.present
          ? data.foodRuleId.value
          : this.foodRuleId,
      requirementLevel: data.requirementLevel.present
          ? data.requirementLevel.value
          : this.requirementLevel,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodRule(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('foodRuleId: $foodRuleId, ')
          ..write('requirementLevel: $requirementLevel, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    foodRuleId,
    requirementLevel,
    source,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFoodRule &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.foodRuleId == this.foodRuleId &&
          other.requirementLevel == this.requirementLevel &&
          other.source == this.source &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserFoodRulesCompanion extends UpdateCompanion<UserFoodRule> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int> foodRuleId;
  final Value<String> requirementLevel;
  final Value<String> source;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserFoodRulesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.foodRuleId = const Value.absent(),
    this.requirementLevel = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserFoodRulesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required int foodRuleId,
    required String requirementLevel,
    required String source,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       foodRuleId = Value(foodRuleId),
       requirementLevel = Value(requirementLevel),
       source = Value(source);
  static Insertable<UserFoodRule> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? foodRuleId,
    Expression<String>? requirementLevel,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (foodRuleId != null) 'food_rule_id': foodRuleId,
      if (requirementLevel != null) 'requirement_level': requirementLevel,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserFoodRulesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int>? foodRuleId,
    Value<String>? requirementLevel,
    Value<String>? source,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserFoodRulesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      foodRuleId: foodRuleId ?? this.foodRuleId,
      requirementLevel: requirementLevel ?? this.requirementLevel,
      source: source ?? this.source,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (foodRuleId.present) {
      map['food_rule_id'] = Variable<int>(foodRuleId.value);
    }
    if (requirementLevel.present) {
      map['requirement_level'] = Variable<String>(requirementLevel.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodRulesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('foodRuleId: $foodRuleId, ')
          ..write('requirementLevel: $requirementLevel, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AllergensTable extends Allergens
    with TableInfo<$AllergensTable, Allergen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllergensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('common'),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    displayNameKey,
    category,
    isBuiltIn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allergens';
  @override
  VerificationContext validateIntegrity(
    Insertable<Allergen> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Allergen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Allergen(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AllergensTable createAlias(String alias) {
    return $AllergensTable(attachedDatabase, alias);
  }
}

class Allergen extends DataClass implements Insertable<Allergen> {
  final int id;
  final String code;
  final String displayNameKey;
  final String category;
  final bool isBuiltIn;
  final DateTime createdAt;
  const Allergen({
    required this.id,
    required this.code,
    required this.displayNameKey,
    required this.category,
    required this.isBuiltIn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['display_name_key'] = Variable<String>(displayNameKey);
    map['category'] = Variable<String>(category);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AllergensCompanion toCompanion(bool nullToAbsent) {
    return AllergensCompanion(
      id: Value(id),
      code: Value(code),
      displayNameKey: Value(displayNameKey),
      category: Value(category),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
    );
  }

  factory Allergen.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Allergen(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      category: serializer.fromJson<String>(json['category']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'category': serializer.toJson<String>(category),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Allergen copyWith({
    int? id,
    String? code,
    String? displayNameKey,
    String? category,
    bool? isBuiltIn,
    DateTime? createdAt,
  }) => Allergen(
    id: id ?? this.id,
    code: code ?? this.code,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    category: category ?? this.category,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
  );
  Allergen copyWithCompanion(AllergensCompanion data) {
    return Allergen(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      category: data.category.present ? data.category.value : this.category,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Allergen(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('category: $category, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, displayNameKey, category, isBuiltIn, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Allergen &&
          other.id == this.id &&
          other.code == this.code &&
          other.displayNameKey == this.displayNameKey &&
          other.category == this.category &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt);
}

class AllergensCompanion extends UpdateCompanion<Allergen> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> displayNameKey;
  final Value<String> category;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  const AllergensCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.category = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AllergensCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String displayNameKey,
    this.category = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : code = Value(code),
       displayNameKey = Value(displayNameKey);
  static Insertable<Allergen> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? displayNameKey,
    Expression<String>? category,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (category != null) 'category': category,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AllergensCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? displayNameKey,
    Value<String>? category,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
  }) {
    return AllergensCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      category: category ?? this.category,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllergensCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('category: $category, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserAllergiesTable extends UserAllergies
    with TableInfo<$UserAllergiesTable, UserAllergy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAllergiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allergenIdMeta = const VerificationMeta(
    'allergenId',
  );
  @override
  late final GeneratedColumn<int> allergenId = GeneratedColumn<int>(
    'allergen_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES allergens (id)',
    ),
  );
  static const VerificationMeta _customNameMeta = const VerificationMeta(
    'customName',
  );
  @override
  late final GeneratedColumn<String> customName = GeneratedColumn<String>(
    'custom_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unspecified'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('explicit'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    allergenId,
    customName,
    severity,
    notes,
    isActive,
    source,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_allergies';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAllergy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('allergen_id')) {
      context.handle(
        _allergenIdMeta,
        allergenId.isAcceptableOrUnknown(data['allergen_id']!, _allergenIdMeta),
      );
    }
    if (data.containsKey('custom_name')) {
      context.handle(
        _customNameMeta,
        customName.isAcceptableOrUnknown(data['custom_name']!, _customNameMeta),
      );
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAllergy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAllergy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      allergenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allergen_id'],
      ),
      customName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_name'],
      ),
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserAllergiesTable createAlias(String alias) {
    return $UserAllergiesTable(attachedDatabase, alias);
  }
}

class UserAllergy extends DataClass implements Insertable<UserAllergy> {
  final int id;
  final int localUserId;
  final int? allergenId;
  final String? customName;
  final String severity;
  final String? notes;
  final bool isActive;
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserAllergy({
    required this.id,
    required this.localUserId,
    this.allergenId,
    this.customName,
    required this.severity,
    this.notes,
    required this.isActive,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    if (!nullToAbsent || allergenId != null) {
      map['allergen_id'] = Variable<int>(allergenId);
    }
    if (!nullToAbsent || customName != null) {
      map['custom_name'] = Variable<String>(customName);
    }
    map['severity'] = Variable<String>(severity);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserAllergiesCompanion toCompanion(bool nullToAbsent) {
    return UserAllergiesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      allergenId: allergenId == null && nullToAbsent
          ? const Value.absent()
          : Value(allergenId),
      customName: customName == null && nullToAbsent
          ? const Value.absent()
          : Value(customName),
      severity: Value(severity),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserAllergy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAllergy(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      allergenId: serializer.fromJson<int?>(json['allergenId']),
      customName: serializer.fromJson<String?>(json['customName']),
      severity: serializer.fromJson<String>(json['severity']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'allergenId': serializer.toJson<int?>(allergenId),
      'customName': serializer.toJson<String?>(customName),
      'severity': serializer.toJson<String>(severity),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserAllergy copyWith({
    int? id,
    int? localUserId,
    Value<int?> allergenId = const Value.absent(),
    Value<String?> customName = const Value.absent(),
    String? severity,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserAllergy(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    allergenId: allergenId.present ? allergenId.value : this.allergenId,
    customName: customName.present ? customName.value : this.customName,
    severity: severity ?? this.severity,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserAllergy copyWithCompanion(UserAllergiesCompanion data) {
    return UserAllergy(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      allergenId: data.allergenId.present
          ? data.allergenId.value
          : this.allergenId,
      customName: data.customName.present
          ? data.customName.value
          : this.customName,
      severity: data.severity.present ? data.severity.value : this.severity,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAllergy(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('allergenId: $allergenId, ')
          ..write('customName: $customName, ')
          ..write('severity: $severity, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    allergenId,
    customName,
    severity,
    notes,
    isActive,
    source,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAllergy &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.allergenId == this.allergenId &&
          other.customName == this.customName &&
          other.severity == this.severity &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserAllergiesCompanion extends UpdateCompanion<UserAllergy> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int?> allergenId;
  final Value<String?> customName;
  final Value<String> severity;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserAllergiesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.allergenId = const Value.absent(),
    this.customName = const Value.absent(),
    this.severity = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserAllergiesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    this.allergenId = const Value.absent(),
    this.customName = const Value.absent(),
    this.severity = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId);
  static Insertable<UserAllergy> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? allergenId,
    Expression<String>? customName,
    Expression<String>? severity,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (allergenId != null) 'allergen_id': allergenId,
      if (customName != null) 'custom_name': customName,
      if (severity != null) 'severity': severity,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserAllergiesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int?>? allergenId,
    Value<String?>? customName,
    Value<String>? severity,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserAllergiesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      allergenId: allergenId ?? this.allergenId,
      customName: customName ?? this.customName,
      severity: severity ?? this.severity,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (allergenId.present) {
      map['allergen_id'] = Variable<int>(allergenId.value);
    }
    if (customName.present) {
      map['custom_name'] = Variable<String>(customName.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAllergiesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('allergenId: $allergenId, ')
          ..write('customName: $customName, ')
          ..write('severity: $severity, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IntolerancesTable extends Intolerances
    with TableInfo<$IntolerancesTable, Intolerance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IntolerancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    displayNameKey,
    isBuiltIn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'intolerances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Intolerance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Intolerance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Intolerance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $IntolerancesTable createAlias(String alias) {
    return $IntolerancesTable(attachedDatabase, alias);
  }
}

class Intolerance extends DataClass implements Insertable<Intolerance> {
  final int id;
  final String code;
  final String displayNameKey;
  final bool isBuiltIn;
  final DateTime createdAt;
  const Intolerance({
    required this.id,
    required this.code,
    required this.displayNameKey,
    required this.isBuiltIn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['display_name_key'] = Variable<String>(displayNameKey);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IntolerancesCompanion toCompanion(bool nullToAbsent) {
    return IntolerancesCompanion(
      id: Value(id),
      code: Value(code),
      displayNameKey: Value(displayNameKey),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
    );
  }

  factory Intolerance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Intolerance(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Intolerance copyWith({
    int? id,
    String? code,
    String? displayNameKey,
    bool? isBuiltIn,
    DateTime? createdAt,
  }) => Intolerance(
    id: id ?? this.id,
    code: code ?? this.code,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
  );
  Intolerance copyWithCompanion(IntolerancesCompanion data) {
    return Intolerance(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Intolerance(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, displayNameKey, isBuiltIn, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Intolerance &&
          other.id == this.id &&
          other.code == this.code &&
          other.displayNameKey == this.displayNameKey &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt);
}

class IntolerancesCompanion extends UpdateCompanion<Intolerance> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> displayNameKey;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  const IntolerancesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IntolerancesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String displayNameKey,
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : code = Value(code),
       displayNameKey = Value(displayNameKey);
  static Insertable<Intolerance> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? displayNameKey,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IntolerancesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? displayNameKey,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
  }) {
    return IntolerancesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IntolerancesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserIntolerancesTable extends UserIntolerances
    with TableInfo<$UserIntolerancesTable, UserIntolerance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserIntolerancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intoleranceIdMeta = const VerificationMeta(
    'intoleranceId',
  );
  @override
  late final GeneratedColumn<int> intoleranceId = GeneratedColumn<int>(
    'intolerance_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES intolerances (id)',
    ),
  );
  static const VerificationMeta _customNameMeta = const VerificationMeta(
    'customName',
  );
  @override
  late final GeneratedColumn<String> customName = GeneratedColumn<String>(
    'custom_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unspecified'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    intoleranceId,
    customName,
    severity,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_intolerances';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserIntolerance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('intolerance_id')) {
      context.handle(
        _intoleranceIdMeta,
        intoleranceId.isAcceptableOrUnknown(
          data['intolerance_id']!,
          _intoleranceIdMeta,
        ),
      );
    }
    if (data.containsKey('custom_name')) {
      context.handle(
        _customNameMeta,
        customName.isAcceptableOrUnknown(data['custom_name']!, _customNameMeta),
      );
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserIntolerance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserIntolerance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      intoleranceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intolerance_id'],
      ),
      customName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_name'],
      ),
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserIntolerancesTable createAlias(String alias) {
    return $UserIntolerancesTable(attachedDatabase, alias);
  }
}

class UserIntolerance extends DataClass implements Insertable<UserIntolerance> {
  final int id;
  final int localUserId;
  final int? intoleranceId;
  final String? customName;
  final String severity;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserIntolerance({
    required this.id,
    required this.localUserId,
    this.intoleranceId,
    this.customName,
    required this.severity,
    this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    if (!nullToAbsent || intoleranceId != null) {
      map['intolerance_id'] = Variable<int>(intoleranceId);
    }
    if (!nullToAbsent || customName != null) {
      map['custom_name'] = Variable<String>(customName);
    }
    map['severity'] = Variable<String>(severity);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserIntolerancesCompanion toCompanion(bool nullToAbsent) {
    return UserIntolerancesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      intoleranceId: intoleranceId == null && nullToAbsent
          ? const Value.absent()
          : Value(intoleranceId),
      customName: customName == null && nullToAbsent
          ? const Value.absent()
          : Value(customName),
      severity: Value(severity),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserIntolerance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserIntolerance(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      intoleranceId: serializer.fromJson<int?>(json['intoleranceId']),
      customName: serializer.fromJson<String?>(json['customName']),
      severity: serializer.fromJson<String>(json['severity']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'intoleranceId': serializer.toJson<int?>(intoleranceId),
      'customName': serializer.toJson<String?>(customName),
      'severity': serializer.toJson<String>(severity),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserIntolerance copyWith({
    int? id,
    int? localUserId,
    Value<int?> intoleranceId = const Value.absent(),
    Value<String?> customName = const Value.absent(),
    String? severity,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserIntolerance(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    intoleranceId: intoleranceId.present
        ? intoleranceId.value
        : this.intoleranceId,
    customName: customName.present ? customName.value : this.customName,
    severity: severity ?? this.severity,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserIntolerance copyWithCompanion(UserIntolerancesCompanion data) {
    return UserIntolerance(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      intoleranceId: data.intoleranceId.present
          ? data.intoleranceId.value
          : this.intoleranceId,
      customName: data.customName.present
          ? data.customName.value
          : this.customName,
      severity: data.severity.present ? data.severity.value : this.severity,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserIntolerance(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('intoleranceId: $intoleranceId, ')
          ..write('customName: $customName, ')
          ..write('severity: $severity, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    intoleranceId,
    customName,
    severity,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserIntolerance &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.intoleranceId == this.intoleranceId &&
          other.customName == this.customName &&
          other.severity == this.severity &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserIntolerancesCompanion extends UpdateCompanion<UserIntolerance> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int?> intoleranceId;
  final Value<String?> customName;
  final Value<String> severity;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserIntolerancesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.intoleranceId = const Value.absent(),
    this.customName = const Value.absent(),
    this.severity = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserIntolerancesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    this.intoleranceId = const Value.absent(),
    this.customName = const Value.absent(),
    this.severity = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId);
  static Insertable<UserIntolerance> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? intoleranceId,
    Expression<String>? customName,
    Expression<String>? severity,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (intoleranceId != null) 'intolerance_id': intoleranceId,
      if (customName != null) 'custom_name': customName,
      if (severity != null) 'severity': severity,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserIntolerancesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int?>? intoleranceId,
    Value<String?>? customName,
    Value<String>? severity,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserIntolerancesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      intoleranceId: intoleranceId ?? this.intoleranceId,
      customName: customName ?? this.customName,
      severity: severity ?? this.severity,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (intoleranceId.present) {
      map['intolerance_id'] = Variable<int>(intoleranceId.value);
    }
    if (customName.present) {
      map['custom_name'] = Variable<String>(customName.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserIntolerancesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('intoleranceId: $intoleranceId, ')
          ..write('customName: $customName, ')
          ..write('severity: $severity, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _canonicalNameMeta = const VerificationMeta(
    'canonicalName',
  );
  @override
  late final GeneratedColumn<String> canonicalName = GeneratedColumn<String>(
    'canonical_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAnimalProductMeta = const VerificationMeta(
    'isAnimalProduct',
  );
  @override
  late final GeneratedColumn<bool> isAnimalProduct = GeneratedColumn<bool>(
    'is_animal_product',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_animal_product" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isMeatMeta = const VerificationMeta('isMeat');
  @override
  late final GeneratedColumn<bool> isMeat = GeneratedColumn<bool>(
    'is_meat',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_meat" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSeafoodMeta = const VerificationMeta(
    'isSeafood',
  );
  @override
  late final GeneratedColumn<bool> isSeafood = GeneratedColumn<bool>(
    'is_seafood',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_seafood" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isAlcoholRelatedMeta = const VerificationMeta(
    'isAlcoholRelated',
  );
  @override
  late final GeneratedColumn<bool> isAlcoholRelated = GeneratedColumn<bool>(
    'is_alcohol_related',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_alcohol_related" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentId,
    code,
    canonicalName,
    displayNameKey,
    category,
    isAnimalProduct,
    isMeat,
    isSeafood,
    isAlcoholRelated,
    isBuiltIn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('canonical_name')) {
      context.handle(
        _canonicalNameMeta,
        canonicalName.isAcceptableOrUnknown(
          data['canonical_name']!,
          _canonicalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalNameMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_animal_product')) {
      context.handle(
        _isAnimalProductMeta,
        isAnimalProduct.isAcceptableOrUnknown(
          data['is_animal_product']!,
          _isAnimalProductMeta,
        ),
      );
    }
    if (data.containsKey('is_meat')) {
      context.handle(
        _isMeatMeta,
        isMeat.isAcceptableOrUnknown(data['is_meat']!, _isMeatMeta),
      );
    }
    if (data.containsKey('is_seafood')) {
      context.handle(
        _isSeafoodMeta,
        isSeafood.isAcceptableOrUnknown(data['is_seafood']!, _isSeafoodMeta),
      );
    }
    if (data.containsKey('is_alcohol_related')) {
      context.handle(
        _isAlcoholRelatedMeta,
        isAlcoholRelated.isAcceptableOrUnknown(
          data['is_alcohol_related']!,
          _isAlcoholRelatedMeta,
        ),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      canonicalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_name'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isAnimalProduct: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_animal_product'],
      )!,
      isMeat: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_meat'],
      )!,
      isSeafood: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_seafood'],
      )!,
      isAlcoholRelated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_alcohol_related'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final int? parentId;
  final String code;
  final String canonicalName;
  final String displayNameKey;
  final String category;
  final bool isAnimalProduct;
  final bool isMeat;
  final bool isSeafood;
  final bool isAlcoholRelated;
  final bool isBuiltIn;
  final DateTime createdAt;
  const Ingredient({
    required this.id,
    this.parentId,
    required this.code,
    required this.canonicalName,
    required this.displayNameKey,
    required this.category,
    required this.isAnimalProduct,
    required this.isMeat,
    required this.isSeafood,
    required this.isAlcoholRelated,
    required this.isBuiltIn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['code'] = Variable<String>(code);
    map['canonical_name'] = Variable<String>(canonicalName);
    map['display_name_key'] = Variable<String>(displayNameKey);
    map['category'] = Variable<String>(category);
    map['is_animal_product'] = Variable<bool>(isAnimalProduct);
    map['is_meat'] = Variable<bool>(isMeat);
    map['is_seafood'] = Variable<bool>(isSeafood);
    map['is_alcohol_related'] = Variable<bool>(isAlcoholRelated);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      code: Value(code),
      canonicalName: Value(canonicalName),
      displayNameKey: Value(displayNameKey),
      category: Value(category),
      isAnimalProduct: Value(isAnimalProduct),
      isMeat: Value(isMeat),
      isSeafood: Value(isSeafood),
      isAlcoholRelated: Value(isAlcoholRelated),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
    );
  }

  factory Ingredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      code: serializer.fromJson<String>(json['code']),
      canonicalName: serializer.fromJson<String>(json['canonicalName']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      category: serializer.fromJson<String>(json['category']),
      isAnimalProduct: serializer.fromJson<bool>(json['isAnimalProduct']),
      isMeat: serializer.fromJson<bool>(json['isMeat']),
      isSeafood: serializer.fromJson<bool>(json['isSeafood']),
      isAlcoholRelated: serializer.fromJson<bool>(json['isAlcoholRelated']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'code': serializer.toJson<String>(code),
      'canonicalName': serializer.toJson<String>(canonicalName),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'category': serializer.toJson<String>(category),
      'isAnimalProduct': serializer.toJson<bool>(isAnimalProduct),
      'isMeat': serializer.toJson<bool>(isMeat),
      'isSeafood': serializer.toJson<bool>(isSeafood),
      'isAlcoholRelated': serializer.toJson<bool>(isAlcoholRelated),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Ingredient copyWith({
    int? id,
    Value<int?> parentId = const Value.absent(),
    String? code,
    String? canonicalName,
    String? displayNameKey,
    String? category,
    bool? isAnimalProduct,
    bool? isMeat,
    bool? isSeafood,
    bool? isAlcoholRelated,
    bool? isBuiltIn,
    DateTime? createdAt,
  }) => Ingredient(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    code: code ?? this.code,
    canonicalName: canonicalName ?? this.canonicalName,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    category: category ?? this.category,
    isAnimalProduct: isAnimalProduct ?? this.isAnimalProduct,
    isMeat: isMeat ?? this.isMeat,
    isSeafood: isSeafood ?? this.isSeafood,
    isAlcoholRelated: isAlcoholRelated ?? this.isAlcoholRelated,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
  );
  Ingredient copyWithCompanion(IngredientsCompanion data) {
    return Ingredient(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      code: data.code.present ? data.code.value : this.code,
      canonicalName: data.canonicalName.present
          ? data.canonicalName.value
          : this.canonicalName,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      category: data.category.present ? data.category.value : this.category,
      isAnimalProduct: data.isAnimalProduct.present
          ? data.isAnimalProduct.value
          : this.isAnimalProduct,
      isMeat: data.isMeat.present ? data.isMeat.value : this.isMeat,
      isSeafood: data.isSeafood.present ? data.isSeafood.value : this.isSeafood,
      isAlcoholRelated: data.isAlcoholRelated.present
          ? data.isAlcoholRelated.value
          : this.isAlcoholRelated,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('code: $code, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('category: $category, ')
          ..write('isAnimalProduct: $isAnimalProduct, ')
          ..write('isMeat: $isMeat, ')
          ..write('isSeafood: $isSeafood, ')
          ..write('isAlcoholRelated: $isAlcoholRelated, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parentId,
    code,
    canonicalName,
    displayNameKey,
    category,
    isAnimalProduct,
    isMeat,
    isSeafood,
    isAlcoholRelated,
    isBuiltIn,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.code == this.code &&
          other.canonicalName == this.canonicalName &&
          other.displayNameKey == this.displayNameKey &&
          other.category == this.category &&
          other.isAnimalProduct == this.isAnimalProduct &&
          other.isMeat == this.isMeat &&
          other.isSeafood == this.isSeafood &&
          other.isAlcoholRelated == this.isAlcoholRelated &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> code;
  final Value<String> canonicalName;
  final Value<String> displayNameKey;
  final Value<String> category;
  final Value<bool> isAnimalProduct;
  final Value<bool> isMeat;
  final Value<bool> isSeafood;
  final Value<bool> isAlcoholRelated;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.code = const Value.absent(),
    this.canonicalName = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.category = const Value.absent(),
    this.isAnimalProduct = const Value.absent(),
    this.isMeat = const Value.absent(),
    this.isSeafood = const Value.absent(),
    this.isAlcoholRelated = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String code,
    required String canonicalName,
    required String displayNameKey,
    required String category,
    this.isAnimalProduct = const Value.absent(),
    this.isMeat = const Value.absent(),
    this.isSeafood = const Value.absent(),
    this.isAlcoholRelated = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : code = Value(code),
       canonicalName = Value(canonicalName),
       displayNameKey = Value(displayNameKey),
       category = Value(category);
  static Insertable<Ingredient> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? code,
    Expression<String>? canonicalName,
    Expression<String>? displayNameKey,
    Expression<String>? category,
    Expression<bool>? isAnimalProduct,
    Expression<bool>? isMeat,
    Expression<bool>? isSeafood,
    Expression<bool>? isAlcoholRelated,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (code != null) 'code': code,
      if (canonicalName != null) 'canonical_name': canonicalName,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (category != null) 'category': category,
      if (isAnimalProduct != null) 'is_animal_product': isAnimalProduct,
      if (isMeat != null) 'is_meat': isMeat,
      if (isSeafood != null) 'is_seafood': isSeafood,
      if (isAlcoholRelated != null) 'is_alcohol_related': isAlcoholRelated,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IngredientsCompanion copyWith({
    Value<int>? id,
    Value<int?>? parentId,
    Value<String>? code,
    Value<String>? canonicalName,
    Value<String>? displayNameKey,
    Value<String>? category,
    Value<bool>? isAnimalProduct,
    Value<bool>? isMeat,
    Value<bool>? isSeafood,
    Value<bool>? isAlcoholRelated,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
  }) {
    return IngredientsCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      code: code ?? this.code,
      canonicalName: canonicalName ?? this.canonicalName,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      category: category ?? this.category,
      isAnimalProduct: isAnimalProduct ?? this.isAnimalProduct,
      isMeat: isMeat ?? this.isMeat,
      isSeafood: isSeafood ?? this.isSeafood,
      isAlcoholRelated: isAlcoholRelated ?? this.isAlcoholRelated,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (canonicalName.present) {
      map['canonical_name'] = Variable<String>(canonicalName.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isAnimalProduct.present) {
      map['is_animal_product'] = Variable<bool>(isAnimalProduct.value);
    }
    if (isMeat.present) {
      map['is_meat'] = Variable<bool>(isMeat.value);
    }
    if (isSeafood.present) {
      map['is_seafood'] = Variable<bool>(isSeafood.value);
    }
    if (isAlcoholRelated.present) {
      map['is_alcohol_related'] = Variable<bool>(isAlcoholRelated.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('code: $code, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('category: $category, ')
          ..write('isAnimalProduct: $isAnimalProduct, ')
          ..write('isMeat: $isMeat, ')
          ..write('isSeafood: $isSeafood, ')
          ..write('isAlcoholRelated: $isAlcoholRelated, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserIngredientPreferencesTable extends UserIngredientPreferences
    with TableInfo<$UserIngredientPreferencesTable, UserIngredientPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserIngredientPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _preferenceStateMeta = const VerificationMeta(
    'preferenceState',
  );
  @override
  late final GeneratedColumn<String> preferenceState = GeneratedColumn<String>(
    'preference_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  static const VerificationMeta _restrictionTypeMeta = const VerificationMeta(
    'restrictionType',
  );
  @override
  late final GeneratedColumn<String> restrictionType = GeneratedColumn<String>(
    'restriction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('explicit'),
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    ingredientId,
    preferenceState,
    restrictionType,
    source,
    confidence,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_ingredient_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserIngredientPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('preference_state')) {
      context.handle(
        _preferenceStateMeta,
        preferenceState.isAcceptableOrUnknown(
          data['preference_state']!,
          _preferenceStateMeta,
        ),
      );
    }
    if (data.containsKey('restriction_type')) {
      context.handle(
        _restrictionTypeMeta,
        restrictionType.isAcceptableOrUnknown(
          data['restriction_type']!,
          _restrictionTypeMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId, ingredientId},
  ];
  @override
  UserIngredientPreference map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserIngredientPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      preferenceState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preference_state'],
      )!,
      restrictionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restriction_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserIngredientPreferencesTable createAlias(String alias) {
    return $UserIngredientPreferencesTable(attachedDatabase, alias);
  }
}

class UserIngredientPreference extends DataClass
    implements Insertable<UserIngredientPreference> {
  final int id;
  final int localUserId;
  final int ingredientId;
  final String preferenceState;
  final String restrictionType;
  final String source;
  final double confidence;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserIngredientPreference({
    required this.id,
    required this.localUserId,
    required this.ingredientId,
    required this.preferenceState,
    required this.restrictionType,
    required this.source,
    required this.confidence,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['preference_state'] = Variable<String>(preferenceState);
    map['restriction_type'] = Variable<String>(restrictionType);
    map['source'] = Variable<String>(source);
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserIngredientPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserIngredientPreferencesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      ingredientId: Value(ingredientId),
      preferenceState: Value(preferenceState),
      restrictionType: Value(restrictionType),
      source: Value(source),
      confidence: Value(confidence),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserIngredientPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserIngredientPreference(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      preferenceState: serializer.fromJson<String>(json['preferenceState']),
      restrictionType: serializer.fromJson<String>(json['restrictionType']),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<double>(json['confidence']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'preferenceState': serializer.toJson<String>(preferenceState),
      'restrictionType': serializer.toJson<String>(restrictionType),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<double>(confidence),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserIngredientPreference copyWith({
    int? id,
    int? localUserId,
    int? ingredientId,
    String? preferenceState,
    String? restrictionType,
    String? source,
    double? confidence,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserIngredientPreference(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    ingredientId: ingredientId ?? this.ingredientId,
    preferenceState: preferenceState ?? this.preferenceState,
    restrictionType: restrictionType ?? this.restrictionType,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserIngredientPreference copyWithCompanion(
    UserIngredientPreferencesCompanion data,
  ) {
    return UserIngredientPreference(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      preferenceState: data.preferenceState.present
          ? data.preferenceState.value
          : this.preferenceState,
      restrictionType: data.restrictionType.present
          ? data.restrictionType.value
          : this.restrictionType,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserIngredientPreference(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('preferenceState: $preferenceState, ')
          ..write('restrictionType: $restrictionType, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    ingredientId,
    preferenceState,
    restrictionType,
    source,
    confidence,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserIngredientPreference &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.ingredientId == this.ingredientId &&
          other.preferenceState == this.preferenceState &&
          other.restrictionType == this.restrictionType &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserIngredientPreferencesCompanion
    extends UpdateCompanion<UserIngredientPreference> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int> ingredientId;
  final Value<String> preferenceState;
  final Value<String> restrictionType;
  final Value<String> source;
  final Value<double> confidence;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserIngredientPreferencesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.preferenceState = const Value.absent(),
    this.restrictionType = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserIngredientPreferencesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required int ingredientId,
    this.preferenceState = const Value.absent(),
    this.restrictionType = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       ingredientId = Value(ingredientId);
  static Insertable<UserIngredientPreference> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? ingredientId,
    Expression<String>? preferenceState,
    Expression<String>? restrictionType,
    Expression<String>? source,
    Expression<double>? confidence,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (preferenceState != null) 'preference_state': preferenceState,
      if (restrictionType != null) 'restriction_type': restrictionType,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserIngredientPreferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int>? ingredientId,
    Value<String>? preferenceState,
    Value<String>? restrictionType,
    Value<String>? source,
    Value<double>? confidence,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserIngredientPreferencesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      ingredientId: ingredientId ?? this.ingredientId,
      preferenceState: preferenceState ?? this.preferenceState,
      restrictionType: restrictionType ?? this.restrictionType,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (preferenceState.present) {
      map['preference_state'] = Variable<String>(preferenceState.value);
    }
    if (restrictionType.present) {
      map['restriction_type'] = Variable<String>(restrictionType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserIngredientPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('preferenceState: $preferenceState, ')
          ..write('restrictionType: $restrictionType, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CuisinesTable extends Cuisines with TableInfo<$CuisinesTable, Cuisine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CuisinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    displayNameKey,
    region,
    isBuiltIn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cuisines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cuisine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cuisine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cuisine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CuisinesTable createAlias(String alias) {
    return $CuisinesTable(attachedDatabase, alias);
  }
}

class Cuisine extends DataClass implements Insertable<Cuisine> {
  final int id;
  final String code;
  final String displayNameKey;
  final String? region;
  final bool isBuiltIn;
  final DateTime createdAt;
  const Cuisine({
    required this.id,
    required this.code,
    required this.displayNameKey,
    this.region,
    required this.isBuiltIn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['display_name_key'] = Variable<String>(displayNameKey);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CuisinesCompanion toCompanion(bool nullToAbsent) {
    return CuisinesCompanion(
      id: Value(id),
      code: Value(code),
      displayNameKey: Value(displayNameKey),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
    );
  }

  factory Cuisine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cuisine(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      region: serializer.fromJson<String?>(json['region']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'region': serializer.toJson<String?>(region),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Cuisine copyWith({
    int? id,
    String? code,
    String? displayNameKey,
    Value<String?> region = const Value.absent(),
    bool? isBuiltIn,
    DateTime? createdAt,
  }) => Cuisine(
    id: id ?? this.id,
    code: code ?? this.code,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    region: region.present ? region.value : this.region,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
  );
  Cuisine copyWithCompanion(CuisinesCompanion data) {
    return Cuisine(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      region: data.region.present ? data.region.value : this.region,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cuisine(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('region: $region, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, displayNameKey, region, isBuiltIn, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cuisine &&
          other.id == this.id &&
          other.code == this.code &&
          other.displayNameKey == this.displayNameKey &&
          other.region == this.region &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt);
}

class CuisinesCompanion extends UpdateCompanion<Cuisine> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> displayNameKey;
  final Value<String?> region;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  const CuisinesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.region = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CuisinesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String displayNameKey,
    this.region = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : code = Value(code),
       displayNameKey = Value(displayNameKey);
  static Insertable<Cuisine> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? displayNameKey,
    Expression<String>? region,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (region != null) 'region': region,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CuisinesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? displayNameKey,
    Value<String?>? region,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
  }) {
    return CuisinesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      region: region ?? this.region,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CuisinesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('region: $region, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserCuisinePreferencesTable extends UserCuisinePreferences
    with TableInfo<$UserCuisinePreferencesTable, UserCuisinePreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCuisinePreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cuisineIdMeta = const VerificationMeta(
    'cuisineId',
  );
  @override
  late final GeneratedColumn<int> cuisineId = GeneratedColumn<int>(
    'cuisine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cuisines (id)',
    ),
  );
  static const VerificationMeta _preferenceStateMeta = const VerificationMeta(
    'preferenceState',
  );
  @override
  late final GeneratedColumn<String> preferenceState = GeneratedColumn<String>(
    'preference_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  static const VerificationMeta _curiosityScoreMeta = const VerificationMeta(
    'curiosityScore',
  );
  @override
  late final GeneratedColumn<double> curiosityScore = GeneratedColumn<double>(
    'curiosity_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('explicit'),
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    cuisineId,
    preferenceState,
    curiosityScore,
    source,
    confidence,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_cuisine_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserCuisinePreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('cuisine_id')) {
      context.handle(
        _cuisineIdMeta,
        cuisineId.isAcceptableOrUnknown(data['cuisine_id']!, _cuisineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cuisineIdMeta);
    }
    if (data.containsKey('preference_state')) {
      context.handle(
        _preferenceStateMeta,
        preferenceState.isAcceptableOrUnknown(
          data['preference_state']!,
          _preferenceStateMeta,
        ),
      );
    }
    if (data.containsKey('curiosity_score')) {
      context.handle(
        _curiosityScoreMeta,
        curiosityScore.isAcceptableOrUnknown(
          data['curiosity_score']!,
          _curiosityScoreMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId, cuisineId},
  ];
  @override
  UserCuisinePreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCuisinePreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      cuisineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cuisine_id'],
      )!,
      preferenceState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preference_state'],
      )!,
      curiosityScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}curiosity_score'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserCuisinePreferencesTable createAlias(String alias) {
    return $UserCuisinePreferencesTable(attachedDatabase, alias);
  }
}

class UserCuisinePreference extends DataClass
    implements Insertable<UserCuisinePreference> {
  final int id;
  final int localUserId;
  final int cuisineId;
  final String preferenceState;
  final double? curiosityScore;
  final String source;
  final double confidence;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserCuisinePreference({
    required this.id,
    required this.localUserId,
    required this.cuisineId,
    required this.preferenceState,
    this.curiosityScore,
    required this.source,
    required this.confidence,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['cuisine_id'] = Variable<int>(cuisineId);
    map['preference_state'] = Variable<String>(preferenceState);
    if (!nullToAbsent || curiosityScore != null) {
      map['curiosity_score'] = Variable<double>(curiosityScore);
    }
    map['source'] = Variable<String>(source);
    map['confidence'] = Variable<double>(confidence);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserCuisinePreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserCuisinePreferencesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      cuisineId: Value(cuisineId),
      preferenceState: Value(preferenceState),
      curiosityScore: curiosityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(curiosityScore),
      source: Value(source),
      confidence: Value(confidence),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserCuisinePreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCuisinePreference(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      cuisineId: serializer.fromJson<int>(json['cuisineId']),
      preferenceState: serializer.fromJson<String>(json['preferenceState']),
      curiosityScore: serializer.fromJson<double?>(json['curiosityScore']),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<double>(json['confidence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'cuisineId': serializer.toJson<int>(cuisineId),
      'preferenceState': serializer.toJson<String>(preferenceState),
      'curiosityScore': serializer.toJson<double?>(curiosityScore),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<double>(confidence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserCuisinePreference copyWith({
    int? id,
    int? localUserId,
    int? cuisineId,
    String? preferenceState,
    Value<double?> curiosityScore = const Value.absent(),
    String? source,
    double? confidence,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserCuisinePreference(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    cuisineId: cuisineId ?? this.cuisineId,
    preferenceState: preferenceState ?? this.preferenceState,
    curiosityScore: curiosityScore.present
        ? curiosityScore.value
        : this.curiosityScore,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserCuisinePreference copyWithCompanion(
    UserCuisinePreferencesCompanion data,
  ) {
    return UserCuisinePreference(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      cuisineId: data.cuisineId.present ? data.cuisineId.value : this.cuisineId,
      preferenceState: data.preferenceState.present
          ? data.preferenceState.value
          : this.preferenceState,
      curiosityScore: data.curiosityScore.present
          ? data.curiosityScore.value
          : this.curiosityScore,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCuisinePreference(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('cuisineId: $cuisineId, ')
          ..write('preferenceState: $preferenceState, ')
          ..write('curiosityScore: $curiosityScore, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    cuisineId,
    preferenceState,
    curiosityScore,
    source,
    confidence,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCuisinePreference &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.cuisineId == this.cuisineId &&
          other.preferenceState == this.preferenceState &&
          other.curiosityScore == this.curiosityScore &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserCuisinePreferencesCompanion
    extends UpdateCompanion<UserCuisinePreference> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int> cuisineId;
  final Value<String> preferenceState;
  final Value<double?> curiosityScore;
  final Value<String> source;
  final Value<double> confidence;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserCuisinePreferencesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.cuisineId = const Value.absent(),
    this.preferenceState = const Value.absent(),
    this.curiosityScore = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserCuisinePreferencesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required int cuisineId,
    this.preferenceState = const Value.absent(),
    this.curiosityScore = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       cuisineId = Value(cuisineId);
  static Insertable<UserCuisinePreference> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? cuisineId,
    Expression<String>? preferenceState,
    Expression<double>? curiosityScore,
    Expression<String>? source,
    Expression<double>? confidence,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (cuisineId != null) 'cuisine_id': cuisineId,
      if (preferenceState != null) 'preference_state': preferenceState,
      if (curiosityScore != null) 'curiosity_score': curiosityScore,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserCuisinePreferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int>? cuisineId,
    Value<String>? preferenceState,
    Value<double?>? curiosityScore,
    Value<String>? source,
    Value<double>? confidence,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserCuisinePreferencesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      cuisineId: cuisineId ?? this.cuisineId,
      preferenceState: preferenceState ?? this.preferenceState,
      curiosityScore: curiosityScore ?? this.curiosityScore,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (cuisineId.present) {
      map['cuisine_id'] = Variable<int>(cuisineId.value);
    }
    if (preferenceState.present) {
      map['preference_state'] = Variable<String>(preferenceState.value);
    }
    if (curiosityScore.present) {
      map['curiosity_score'] = Variable<double>(curiosityScore.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCuisinePreferencesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('cuisineId: $cuisineId, ')
          ..write('preferenceState: $preferenceState, ')
          ..write('curiosityScore: $curiosityScore, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FlavorAttributesTable extends FlavorAttributes
    with TableInfo<$FlavorAttributesTable, FlavorAttribute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlavorAttributesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, code, displayNameKey, isBuiltIn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flavor_attributes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlavorAttribute> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlavorAttribute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlavorAttribute(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
    );
  }

  @override
  $FlavorAttributesTable createAlias(String alias) {
    return $FlavorAttributesTable(attachedDatabase, alias);
  }
}

class FlavorAttribute extends DataClass implements Insertable<FlavorAttribute> {
  final int id;
  final String code;
  final String displayNameKey;
  final bool isBuiltIn;
  const FlavorAttribute({
    required this.id,
    required this.code,
    required this.displayNameKey,
    required this.isBuiltIn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['display_name_key'] = Variable<String>(displayNameKey);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    return map;
  }

  FlavorAttributesCompanion toCompanion(bool nullToAbsent) {
    return FlavorAttributesCompanion(
      id: Value(id),
      code: Value(code),
      displayNameKey: Value(displayNameKey),
      isBuiltIn: Value(isBuiltIn),
    );
  }

  factory FlavorAttribute.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlavorAttribute(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
    };
  }

  FlavorAttribute copyWith({
    int? id,
    String? code,
    String? displayNameKey,
    bool? isBuiltIn,
  }) => FlavorAttribute(
    id: id ?? this.id,
    code: code ?? this.code,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
  );
  FlavorAttribute copyWithCompanion(FlavorAttributesCompanion data) {
    return FlavorAttribute(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlavorAttribute(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, displayNameKey, isBuiltIn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlavorAttribute &&
          other.id == this.id &&
          other.code == this.code &&
          other.displayNameKey == this.displayNameKey &&
          other.isBuiltIn == this.isBuiltIn);
}

class FlavorAttributesCompanion extends UpdateCompanion<FlavorAttribute> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> displayNameKey;
  final Value<bool> isBuiltIn;
  const FlavorAttributesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
  });
  FlavorAttributesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String displayNameKey,
    this.isBuiltIn = const Value.absent(),
  }) : code = Value(code),
       displayNameKey = Value(displayNameKey);
  static Insertable<FlavorAttribute> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? displayNameKey,
    Expression<bool>? isBuiltIn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
    });
  }

  FlavorAttributesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? displayNameKey,
    Value<bool>? isBuiltIn,
  }) {
    return FlavorAttributesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlavorAttributesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }
}

class $UserFlavorPreferencesTable extends UserFlavorPreferences
    with TableInfo<$UserFlavorPreferencesTable, UserFlavorPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFlavorPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _flavorAttributeIdMeta = const VerificationMeta(
    'flavorAttributeId',
  );
  @override
  late final GeneratedColumn<int> flavorAttributeId = GeneratedColumn<int>(
    'flavor_attribute_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flavor_attributes (id)',
    ),
  );
  static const VerificationMeta _preferenceLevelMeta = const VerificationMeta(
    'preferenceLevel',
  );
  @override
  late final GeneratedColumn<int> preferenceLevel = GeneratedColumn<int>(
    'preference_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('explicit'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    flavorAttributeId,
    preferenceLevel,
    source,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_flavor_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserFlavorPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('flavor_attribute_id')) {
      context.handle(
        _flavorAttributeIdMeta,
        flavorAttributeId.isAcceptableOrUnknown(
          data['flavor_attribute_id']!,
          _flavorAttributeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flavorAttributeIdMeta);
    }
    if (data.containsKey('preference_level')) {
      context.handle(
        _preferenceLevelMeta,
        preferenceLevel.isAcceptableOrUnknown(
          data['preference_level']!,
          _preferenceLevelMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId, flavorAttributeId},
  ];
  @override
  UserFlavorPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFlavorPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      flavorAttributeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}flavor_attribute_id'],
      )!,
      preferenceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preference_level'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserFlavorPreferencesTable createAlias(String alias) {
    return $UserFlavorPreferencesTable(attachedDatabase, alias);
  }
}

class UserFlavorPreference extends DataClass
    implements Insertable<UserFlavorPreference> {
  final int id;
  final int localUserId;
  final int flavorAttributeId;
  final int preferenceLevel;
  final String source;
  final DateTime updatedAt;
  const UserFlavorPreference({
    required this.id,
    required this.localUserId,
    required this.flavorAttributeId,
    required this.preferenceLevel,
    required this.source,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['flavor_attribute_id'] = Variable<int>(flavorAttributeId);
    map['preference_level'] = Variable<int>(preferenceLevel);
    map['source'] = Variable<String>(source);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserFlavorPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserFlavorPreferencesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      flavorAttributeId: Value(flavorAttributeId),
      preferenceLevel: Value(preferenceLevel),
      source: Value(source),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserFlavorPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFlavorPreference(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      flavorAttributeId: serializer.fromJson<int>(json['flavorAttributeId']),
      preferenceLevel: serializer.fromJson<int>(json['preferenceLevel']),
      source: serializer.fromJson<String>(json['source']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'flavorAttributeId': serializer.toJson<int>(flavorAttributeId),
      'preferenceLevel': serializer.toJson<int>(preferenceLevel),
      'source': serializer.toJson<String>(source),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserFlavorPreference copyWith({
    int? id,
    int? localUserId,
    int? flavorAttributeId,
    int? preferenceLevel,
    String? source,
    DateTime? updatedAt,
  }) => UserFlavorPreference(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    flavorAttributeId: flavorAttributeId ?? this.flavorAttributeId,
    preferenceLevel: preferenceLevel ?? this.preferenceLevel,
    source: source ?? this.source,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserFlavorPreference copyWithCompanion(UserFlavorPreferencesCompanion data) {
    return UserFlavorPreference(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      flavorAttributeId: data.flavorAttributeId.present
          ? data.flavorAttributeId.value
          : this.flavorAttributeId,
      preferenceLevel: data.preferenceLevel.present
          ? data.preferenceLevel.value
          : this.preferenceLevel,
      source: data.source.present ? data.source.value : this.source,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFlavorPreference(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('flavorAttributeId: $flavorAttributeId, ')
          ..write('preferenceLevel: $preferenceLevel, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    flavorAttributeId,
    preferenceLevel,
    source,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFlavorPreference &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.flavorAttributeId == this.flavorAttributeId &&
          other.preferenceLevel == this.preferenceLevel &&
          other.source == this.source &&
          other.updatedAt == this.updatedAt);
}

class UserFlavorPreferencesCompanion
    extends UpdateCompanion<UserFlavorPreference> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int> flavorAttributeId;
  final Value<int> preferenceLevel;
  final Value<String> source;
  final Value<DateTime> updatedAt;
  const UserFlavorPreferencesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.flavorAttributeId = const Value.absent(),
    this.preferenceLevel = const Value.absent(),
    this.source = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserFlavorPreferencesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required int flavorAttributeId,
    this.preferenceLevel = const Value.absent(),
    this.source = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       flavorAttributeId = Value(flavorAttributeId);
  static Insertable<UserFlavorPreference> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? flavorAttributeId,
    Expression<int>? preferenceLevel,
    Expression<String>? source,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (flavorAttributeId != null) 'flavor_attribute_id': flavorAttributeId,
      if (preferenceLevel != null) 'preference_level': preferenceLevel,
      if (source != null) 'source': source,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserFlavorPreferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int>? flavorAttributeId,
    Value<int>? preferenceLevel,
    Value<String>? source,
    Value<DateTime>? updatedAt,
  }) {
    return UserFlavorPreferencesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      flavorAttributeId: flavorAttributeId ?? this.flavorAttributeId,
      preferenceLevel: preferenceLevel ?? this.preferenceLevel,
      source: source ?? this.source,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (flavorAttributeId.present) {
      map['flavor_attribute_id'] = Variable<int>(flavorAttributeId.value);
    }
    if (preferenceLevel.present) {
      map['preference_level'] = Variable<int>(preferenceLevel.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFlavorPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('flavorAttributeId: $flavorAttributeId, ')
          ..write('preferenceLevel: $preferenceLevel, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodItemsTable extends FoodItems
    with TableInfo<$FoodItemsTable, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _canonicalNameMeta = const VerificationMeta(
    'canonicalName',
  );
  @override
  late final GeneratedColumn<String> canonicalName = GeneratedColumn<String>(
    'canonical_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameKeyMeta = const VerificationMeta(
    'displayNameKey',
  );
  @override
  late final GeneratedColumn<String> displayNameKey = GeneratedColumn<String>(
    'display_name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cuisineIdMeta = const VerificationMeta(
    'cuisineId',
  );
  @override
  late final GeneratedColumn<int> cuisineId = GeneratedColumn<int>(
    'cuisine_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cuisines (id)',
    ),
  );
  static const VerificationMeta _localImageAssetMeta = const VerificationMeta(
    'localImageAsset',
  );
  @override
  late final GeneratedColumn<String> localImageAsset = GeneratedColumn<String>(
    'local_image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionKeyMeta = const VerificationMeta(
    'descriptionKey',
  );
  @override
  late final GeneratedColumn<String> descriptionKey = GeneratedColumn<String>(
    'description_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    canonicalName,
    displayNameKey,
    cuisineId,
    localImageAsset,
    descriptionKey,
    isBuiltIn,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('canonical_name')) {
      context.handle(
        _canonicalNameMeta,
        canonicalName.isAcceptableOrUnknown(
          data['canonical_name']!,
          _canonicalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalNameMeta);
    }
    if (data.containsKey('display_name_key')) {
      context.handle(
        _displayNameKeyMeta,
        displayNameKey.isAcceptableOrUnknown(
          data['display_name_key']!,
          _displayNameKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameKeyMeta);
    }
    if (data.containsKey('cuisine_id')) {
      context.handle(
        _cuisineIdMeta,
        cuisineId.isAcceptableOrUnknown(data['cuisine_id']!, _cuisineIdMeta),
      );
    }
    if (data.containsKey('local_image_asset')) {
      context.handle(
        _localImageAssetMeta,
        localImageAsset.isAcceptableOrUnknown(
          data['local_image_asset']!,
          _localImageAssetMeta,
        ),
      );
    }
    if (data.containsKey('description_key')) {
      context.handle(
        _descriptionKeyMeta,
        descriptionKey.isAcceptableOrUnknown(
          data['description_key']!,
          _descriptionKeyMeta,
        ),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      canonicalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_name'],
      )!,
      displayNameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_key'],
      )!,
      cuisineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cuisine_id'],
      ),
      localImageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_asset'],
      ),
      descriptionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_key'],
      ),
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FoodItemsTable createAlias(String alias) {
    return $FoodItemsTable(attachedDatabase, alias);
  }
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final int id;
  final String canonicalName;
  final String displayNameKey;
  final int? cuisineId;
  final String? localImageAsset;
  final String? descriptionKey;
  final bool isBuiltIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodItem({
    required this.id,
    required this.canonicalName,
    required this.displayNameKey,
    this.cuisineId,
    this.localImageAsset,
    this.descriptionKey,
    required this.isBuiltIn,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['canonical_name'] = Variable<String>(canonicalName);
    map['display_name_key'] = Variable<String>(displayNameKey);
    if (!nullToAbsent || cuisineId != null) {
      map['cuisine_id'] = Variable<int>(cuisineId);
    }
    if (!nullToAbsent || localImageAsset != null) {
      map['local_image_asset'] = Variable<String>(localImageAsset);
    }
    if (!nullToAbsent || descriptionKey != null) {
      map['description_key'] = Variable<String>(descriptionKey);
    }
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      canonicalName: Value(canonicalName),
      displayNameKey: Value(displayNameKey),
      cuisineId: cuisineId == null && nullToAbsent
          ? const Value.absent()
          : Value(cuisineId),
      localImageAsset: localImageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(localImageAsset),
      descriptionKey: descriptionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionKey),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<int>(json['id']),
      canonicalName: serializer.fromJson<String>(json['canonicalName']),
      displayNameKey: serializer.fromJson<String>(json['displayNameKey']),
      cuisineId: serializer.fromJson<int?>(json['cuisineId']),
      localImageAsset: serializer.fromJson<String?>(json['localImageAsset']),
      descriptionKey: serializer.fromJson<String?>(json['descriptionKey']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'canonicalName': serializer.toJson<String>(canonicalName),
      'displayNameKey': serializer.toJson<String>(displayNameKey),
      'cuisineId': serializer.toJson<int?>(cuisineId),
      'localImageAsset': serializer.toJson<String?>(localImageAsset),
      'descriptionKey': serializer.toJson<String?>(descriptionKey),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodItem copyWith({
    int? id,
    String? canonicalName,
    String? displayNameKey,
    Value<int?> cuisineId = const Value.absent(),
    Value<String?> localImageAsset = const Value.absent(),
    Value<String?> descriptionKey = const Value.absent(),
    bool? isBuiltIn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodItem(
    id: id ?? this.id,
    canonicalName: canonicalName ?? this.canonicalName,
    displayNameKey: displayNameKey ?? this.displayNameKey,
    cuisineId: cuisineId.present ? cuisineId.value : this.cuisineId,
    localImageAsset: localImageAsset.present
        ? localImageAsset.value
        : this.localImageAsset,
    descriptionKey: descriptionKey.present
        ? descriptionKey.value
        : this.descriptionKey,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      canonicalName: data.canonicalName.present
          ? data.canonicalName.value
          : this.canonicalName,
      displayNameKey: data.displayNameKey.present
          ? data.displayNameKey.value
          : this.displayNameKey,
      cuisineId: data.cuisineId.present ? data.cuisineId.value : this.cuisineId,
      localImageAsset: data.localImageAsset.present
          ? data.localImageAsset.value
          : this.localImageAsset,
      descriptionKey: data.descriptionKey.present
          ? data.descriptionKey.value
          : this.descriptionKey,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('cuisineId: $cuisineId, ')
          ..write('localImageAsset: $localImageAsset, ')
          ..write('descriptionKey: $descriptionKey, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    canonicalName,
    displayNameKey,
    cuisineId,
    localImageAsset,
    descriptionKey,
    isBuiltIn,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.canonicalName == this.canonicalName &&
          other.displayNameKey == this.displayNameKey &&
          other.cuisineId == this.cuisineId &&
          other.localImageAsset == this.localImageAsset &&
          other.descriptionKey == this.descriptionKey &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<int> id;
  final Value<String> canonicalName;
  final Value<String> displayNameKey;
  final Value<int?> cuisineId;
  final Value<String?> localImageAsset;
  final Value<String?> descriptionKey;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.canonicalName = const Value.absent(),
    this.displayNameKey = const Value.absent(),
    this.cuisineId = const Value.absent(),
    this.localImageAsset = const Value.absent(),
    this.descriptionKey = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    this.id = const Value.absent(),
    required String canonicalName,
    required String displayNameKey,
    this.cuisineId = const Value.absent(),
    this.localImageAsset = const Value.absent(),
    this.descriptionKey = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : canonicalName = Value(canonicalName),
       displayNameKey = Value(displayNameKey);
  static Insertable<FoodItem> custom({
    Expression<int>? id,
    Expression<String>? canonicalName,
    Expression<String>? displayNameKey,
    Expression<int>? cuisineId,
    Expression<String>? localImageAsset,
    Expression<String>? descriptionKey,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (canonicalName != null) 'canonical_name': canonicalName,
      if (displayNameKey != null) 'display_name_key': displayNameKey,
      if (cuisineId != null) 'cuisine_id': cuisineId,
      if (localImageAsset != null) 'local_image_asset': localImageAsset,
      if (descriptionKey != null) 'description_key': descriptionKey,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FoodItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? canonicalName,
    Value<String>? displayNameKey,
    Value<int?>? cuisineId,
    Value<String?>? localImageAsset,
    Value<String?>? descriptionKey,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      canonicalName: canonicalName ?? this.canonicalName,
      displayNameKey: displayNameKey ?? this.displayNameKey,
      cuisineId: cuisineId ?? this.cuisineId,
      localImageAsset: localImageAsset ?? this.localImageAsset,
      descriptionKey: descriptionKey ?? this.descriptionKey,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (canonicalName.present) {
      map['canonical_name'] = Variable<String>(canonicalName.value);
    }
    if (displayNameKey.present) {
      map['display_name_key'] = Variable<String>(displayNameKey.value);
    }
    if (cuisineId.present) {
      map['cuisine_id'] = Variable<int>(cuisineId.value);
    }
    if (localImageAsset.present) {
      map['local_image_asset'] = Variable<String>(localImageAsset.value);
    }
    if (descriptionKey.present) {
      map['description_key'] = Variable<String>(descriptionKey.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('displayNameKey: $displayNameKey, ')
          ..write('cuisineId: $cuisineId, ')
          ..write('localImageAsset: $localImageAsset, ')
          ..write('descriptionKey: $descriptionKey, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodItemIngredientsTable extends FoodItemIngredients
    with TableInfo<$FoodItemIngredientsTable, FoodItemIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _foodItemIdMeta = const VerificationMeta(
    'foodItemId',
  );
  @override
  late final GeneratedColumn<int> foodItemId = GeneratedColumn<int>(
    'food_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food_items (id)',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _mayContainMeta = const VerificationMeta(
    'mayContain',
  );
  @override
  late final GeneratedColumn<bool> mayContain = GeneratedColumn<bool>(
    'may_contain',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("may_contain" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodItemId,
    ingredientId,
    isPrimary,
    mayContain,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_item_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItemIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_item_id')) {
      context.handle(
        _foodItemIdMeta,
        foodItemId.isAcceptableOrUnknown(
          data['food_item_id']!,
          _foodItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodItemIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('may_contain')) {
      context.handle(
        _mayContainMeta,
        mayContain.isAcceptableOrUnknown(data['may_contain']!, _mayContainMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {foodItemId, ingredientId},
  ];
  @override
  FoodItemIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItemIngredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      foodItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_item_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      mayContain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}may_contain'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FoodItemIngredientsTable createAlias(String alias) {
    return $FoodItemIngredientsTable(attachedDatabase, alias);
  }
}

class FoodItemIngredient extends DataClass
    implements Insertable<FoodItemIngredient> {
  final int id;
  final int foodItemId;
  final int ingredientId;
  final bool isPrimary;
  final bool mayContain;
  final DateTime createdAt;
  const FoodItemIngredient({
    required this.id,
    required this.foodItemId,
    required this.ingredientId,
    required this.isPrimary,
    required this.mayContain,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_item_id'] = Variable<int>(foodItemId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['may_contain'] = Variable<bool>(mayContain);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodItemIngredientsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemIngredientsCompanion(
      id: Value(id),
      foodItemId: Value(foodItemId),
      ingredientId: Value(ingredientId),
      isPrimary: Value(isPrimary),
      mayContain: Value(mayContain),
      createdAt: Value(createdAt),
    );
  }

  factory FoodItemIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItemIngredient(
      id: serializer.fromJson<int>(json['id']),
      foodItemId: serializer.fromJson<int>(json['foodItemId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      mayContain: serializer.fromJson<bool>(json['mayContain']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodItemId': serializer.toJson<int>(foodItemId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'mayContain': serializer.toJson<bool>(mayContain),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FoodItemIngredient copyWith({
    int? id,
    int? foodItemId,
    int? ingredientId,
    bool? isPrimary,
    bool? mayContain,
    DateTime? createdAt,
  }) => FoodItemIngredient(
    id: id ?? this.id,
    foodItemId: foodItemId ?? this.foodItemId,
    ingredientId: ingredientId ?? this.ingredientId,
    isPrimary: isPrimary ?? this.isPrimary,
    mayContain: mayContain ?? this.mayContain,
    createdAt: createdAt ?? this.createdAt,
  );
  FoodItemIngredient copyWithCompanion(FoodItemIngredientsCompanion data) {
    return FoodItemIngredient(
      id: data.id.present ? data.id.value : this.id,
      foodItemId: data.foodItemId.present
          ? data.foodItemId.value
          : this.foodItemId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      mayContain: data.mayContain.present
          ? data.mayContain.value
          : this.mayContain,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemIngredient(')
          ..write('id: $id, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('mayContain: $mayContain, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    foodItemId,
    ingredientId,
    isPrimary,
    mayContain,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItemIngredient &&
          other.id == this.id &&
          other.foodItemId == this.foodItemId &&
          other.ingredientId == this.ingredientId &&
          other.isPrimary == this.isPrimary &&
          other.mayContain == this.mayContain &&
          other.createdAt == this.createdAt);
}

class FoodItemIngredientsCompanion extends UpdateCompanion<FoodItemIngredient> {
  final Value<int> id;
  final Value<int> foodItemId;
  final Value<int> ingredientId;
  final Value<bool> isPrimary;
  final Value<bool> mayContain;
  final Value<DateTime> createdAt;
  const FoodItemIngredientsCompanion({
    this.id = const Value.absent(),
    this.foodItemId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.mayContain = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodItemIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required int foodItemId,
    required int ingredientId,
    this.isPrimary = const Value.absent(),
    this.mayContain = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : foodItemId = Value(foodItemId),
       ingredientId = Value(ingredientId);
  static Insertable<FoodItemIngredient> custom({
    Expression<int>? id,
    Expression<int>? foodItemId,
    Expression<int>? ingredientId,
    Expression<bool>? isPrimary,
    Expression<bool>? mayContain,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodItemId != null) 'food_item_id': foodItemId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (mayContain != null) 'may_contain': mayContain,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodItemIngredientsCompanion copyWith({
    Value<int>? id,
    Value<int>? foodItemId,
    Value<int>? ingredientId,
    Value<bool>? isPrimary,
    Value<bool>? mayContain,
    Value<DateTime>? createdAt,
  }) {
    return FoodItemIngredientsCompanion(
      id: id ?? this.id,
      foodItemId: foodItemId ?? this.foodItemId,
      ingredientId: ingredientId ?? this.ingredientId,
      isPrimary: isPrimary ?? this.isPrimary,
      mayContain: mayContain ?? this.mayContain,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodItemId.present) {
      map['food_item_id'] = Variable<int>(foodItemId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (mayContain.present) {
      map['may_contain'] = Variable<bool>(mayContain.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('mayContain: $mayContain, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FoodItemAllergensTable extends FoodItemAllergens
    with TableInfo<$FoodItemAllergensTable, FoodItemAllergen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemAllergensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _foodItemIdMeta = const VerificationMeta(
    'foodItemId',
  );
  @override
  late final GeneratedColumn<int> foodItemId = GeneratedColumn<int>(
    'food_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food_items (id)',
    ),
  );
  static const VerificationMeta _allergenIdMeta = const VerificationMeta(
    'allergenId',
  );
  @override
  late final GeneratedColumn<int> allergenId = GeneratedColumn<int>(
    'allergen_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES allergens (id)',
    ),
  );
  static const VerificationMeta _relationTypeMeta = const VerificationMeta(
    'relationType',
  );
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
    'relation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('contains'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodItemId,
    allergenId,
    relationType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_item_allergens';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItemAllergen> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_item_id')) {
      context.handle(
        _foodItemIdMeta,
        foodItemId.isAcceptableOrUnknown(
          data['food_item_id']!,
          _foodItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodItemIdMeta);
    }
    if (data.containsKey('allergen_id')) {
      context.handle(
        _allergenIdMeta,
        allergenId.isAcceptableOrUnknown(data['allergen_id']!, _allergenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_allergenIdMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
        _relationTypeMeta,
        relationType.isAcceptableOrUnknown(
          data['relation_type']!,
          _relationTypeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {foodItemId, allergenId},
  ];
  @override
  FoodItemAllergen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItemAllergen(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      foodItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_item_id'],
      )!,
      allergenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allergen_id'],
      )!,
      relationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FoodItemAllergensTable createAlias(String alias) {
    return $FoodItemAllergensTable(attachedDatabase, alias);
  }
}

class FoodItemAllergen extends DataClass
    implements Insertable<FoodItemAllergen> {
  final int id;
  final int foodItemId;
  final int allergenId;
  final String relationType;
  final DateTime createdAt;
  const FoodItemAllergen({
    required this.id,
    required this.foodItemId,
    required this.allergenId,
    required this.relationType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_item_id'] = Variable<int>(foodItemId);
    map['allergen_id'] = Variable<int>(allergenId);
    map['relation_type'] = Variable<String>(relationType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodItemAllergensCompanion toCompanion(bool nullToAbsent) {
    return FoodItemAllergensCompanion(
      id: Value(id),
      foodItemId: Value(foodItemId),
      allergenId: Value(allergenId),
      relationType: Value(relationType),
      createdAt: Value(createdAt),
    );
  }

  factory FoodItemAllergen.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItemAllergen(
      id: serializer.fromJson<int>(json['id']),
      foodItemId: serializer.fromJson<int>(json['foodItemId']),
      allergenId: serializer.fromJson<int>(json['allergenId']),
      relationType: serializer.fromJson<String>(json['relationType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodItemId': serializer.toJson<int>(foodItemId),
      'allergenId': serializer.toJson<int>(allergenId),
      'relationType': serializer.toJson<String>(relationType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FoodItemAllergen copyWith({
    int? id,
    int? foodItemId,
    int? allergenId,
    String? relationType,
    DateTime? createdAt,
  }) => FoodItemAllergen(
    id: id ?? this.id,
    foodItemId: foodItemId ?? this.foodItemId,
    allergenId: allergenId ?? this.allergenId,
    relationType: relationType ?? this.relationType,
    createdAt: createdAt ?? this.createdAt,
  );
  FoodItemAllergen copyWithCompanion(FoodItemAllergensCompanion data) {
    return FoodItemAllergen(
      id: data.id.present ? data.id.value : this.id,
      foodItemId: data.foodItemId.present
          ? data.foodItemId.value
          : this.foodItemId,
      allergenId: data.allergenId.present
          ? data.allergenId.value
          : this.allergenId,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemAllergen(')
          ..write('id: $id, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('allergenId: $allergenId, ')
          ..write('relationType: $relationType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, foodItemId, allergenId, relationType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItemAllergen &&
          other.id == this.id &&
          other.foodItemId == this.foodItemId &&
          other.allergenId == this.allergenId &&
          other.relationType == this.relationType &&
          other.createdAt == this.createdAt);
}

class FoodItemAllergensCompanion extends UpdateCompanion<FoodItemAllergen> {
  final Value<int> id;
  final Value<int> foodItemId;
  final Value<int> allergenId;
  final Value<String> relationType;
  final Value<DateTime> createdAt;
  const FoodItemAllergensCompanion({
    this.id = const Value.absent(),
    this.foodItemId = const Value.absent(),
    this.allergenId = const Value.absent(),
    this.relationType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodItemAllergensCompanion.insert({
    this.id = const Value.absent(),
    required int foodItemId,
    required int allergenId,
    this.relationType = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : foodItemId = Value(foodItemId),
       allergenId = Value(allergenId);
  static Insertable<FoodItemAllergen> custom({
    Expression<int>? id,
    Expression<int>? foodItemId,
    Expression<int>? allergenId,
    Expression<String>? relationType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodItemId != null) 'food_item_id': foodItemId,
      if (allergenId != null) 'allergen_id': allergenId,
      if (relationType != null) 'relation_type': relationType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodItemAllergensCompanion copyWith({
    Value<int>? id,
    Value<int>? foodItemId,
    Value<int>? allergenId,
    Value<String>? relationType,
    Value<DateTime>? createdAt,
  }) {
    return FoodItemAllergensCompanion(
      id: id ?? this.id,
      foodItemId: foodItemId ?? this.foodItemId,
      allergenId: allergenId ?? this.allergenId,
      relationType: relationType ?? this.relationType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodItemId.present) {
      map['food_item_id'] = Variable<int>(foodItemId.value);
    }
    if (allergenId.present) {
      map['allergen_id'] = Variable<int>(allergenId.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemAllergensCompanion(')
          ..write('id: $id, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('allergenId: $allergenId, ')
          ..write('relationType: $relationType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserFoodItemPreferencesTable extends UserFoodItemPreferences
    with TableInfo<$UserFoodItemPreferencesTable, UserFoodItemPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFoodItemPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodItemIdMeta = const VerificationMeta(
    'foodItemId',
  );
  @override
  late final GeneratedColumn<int> foodItemId = GeneratedColumn<int>(
    'food_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food_items (id)',
    ),
  );
  static const VerificationMeta _preferenceStateMeta = const VerificationMeta(
    'preferenceState',
  );
  @override
  late final GeneratedColumn<String> preferenceState = GeneratedColumn<String>(
    'preference_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('explicit'),
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    foodItemId,
    preferenceState,
    source,
    confidence,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_food_item_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserFoodItemPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('food_item_id')) {
      context.handle(
        _foodItemIdMeta,
        foodItemId.isAcceptableOrUnknown(
          data['food_item_id']!,
          _foodItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodItemIdMeta);
    }
    if (data.containsKey('preference_state')) {
      context.handle(
        _preferenceStateMeta,
        preferenceState.isAcceptableOrUnknown(
          data['preference_state']!,
          _preferenceStateMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId, foodItemId},
  ];
  @override
  UserFoodItemPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFoodItemPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      foodItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_item_id'],
      )!,
      preferenceState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preference_state'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserFoodItemPreferencesTable createAlias(String alias) {
    return $UserFoodItemPreferencesTable(attachedDatabase, alias);
  }
}

class UserFoodItemPreference extends DataClass
    implements Insertable<UserFoodItemPreference> {
  final int id;
  final int localUserId;
  final int foodItemId;
  final String preferenceState;
  final String source;
  final double confidence;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserFoodItemPreference({
    required this.id,
    required this.localUserId,
    required this.foodItemId,
    required this.preferenceState,
    required this.source,
    required this.confidence,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['food_item_id'] = Variable<int>(foodItemId);
    map['preference_state'] = Variable<String>(preferenceState);
    map['source'] = Variable<String>(source);
    map['confidence'] = Variable<double>(confidence);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserFoodItemPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserFoodItemPreferencesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      foodItemId: Value(foodItemId),
      preferenceState: Value(preferenceState),
      source: Value(source),
      confidence: Value(confidence),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserFoodItemPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFoodItemPreference(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      foodItemId: serializer.fromJson<int>(json['foodItemId']),
      preferenceState: serializer.fromJson<String>(json['preferenceState']),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<double>(json['confidence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'foodItemId': serializer.toJson<int>(foodItemId),
      'preferenceState': serializer.toJson<String>(preferenceState),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<double>(confidence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserFoodItemPreference copyWith({
    int? id,
    int? localUserId,
    int? foodItemId,
    String? preferenceState,
    String? source,
    double? confidence,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserFoodItemPreference(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    foodItemId: foodItemId ?? this.foodItemId,
    preferenceState: preferenceState ?? this.preferenceState,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserFoodItemPreference copyWithCompanion(
    UserFoodItemPreferencesCompanion data,
  ) {
    return UserFoodItemPreference(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      foodItemId: data.foodItemId.present
          ? data.foodItemId.value
          : this.foodItemId,
      preferenceState: data.preferenceState.present
          ? data.preferenceState.value
          : this.preferenceState,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodItemPreference(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('preferenceState: $preferenceState, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    foodItemId,
    preferenceState,
    source,
    confidence,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFoodItemPreference &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.foodItemId == this.foodItemId &&
          other.preferenceState == this.preferenceState &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserFoodItemPreferencesCompanion
    extends UpdateCompanion<UserFoodItemPreference> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<int> foodItemId;
  final Value<String> preferenceState;
  final Value<String> source;
  final Value<double> confidence;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserFoodItemPreferencesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.foodItemId = const Value.absent(),
    this.preferenceState = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserFoodItemPreferencesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required int foodItemId,
    this.preferenceState = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       foodItemId = Value(foodItemId);
  static Insertable<UserFoodItemPreference> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<int>? foodItemId,
    Expression<String>? preferenceState,
    Expression<String>? source,
    Expression<double>? confidence,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (foodItemId != null) 'food_item_id': foodItemId,
      if (preferenceState != null) 'preference_state': preferenceState,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserFoodItemPreferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<int>? foodItemId,
    Value<String>? preferenceState,
    Value<String>? source,
    Value<double>? confidence,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserFoodItemPreferencesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      foodItemId: foodItemId ?? this.foodItemId,
      preferenceState: preferenceState ?? this.preferenceState,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (foodItemId.present) {
      map['food_item_id'] = Variable<int>(foodItemId.value);
    }
    if (preferenceState.present) {
      map['preference_state'] = Variable<String>(preferenceState.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodItemPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('foodItemId: $foodItemId, ')
          ..write('preferenceState: $preferenceState, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserFoodInteractionsTable extends UserFoodInteractions
    with TableInfo<$UserFoodInteractionsTable, UserFoodInteraction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFoodInteractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _screenNameMeta = const VerificationMeta(
    'screenName',
  );
  @override
  late final GeneratedColumn<String> screenName = GeneratedColumn<String>(
    'screen_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceSectionMeta = const VerificationMeta(
    'sourceSection',
  );
  @override
  late final GeneratedColumn<String> sourceSection = GeneratedColumn<String>(
    'source_section',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionIndexMeta = const VerificationMeta(
    'positionIndex',
  );
  @override
  late final GeneratedColumn<int> positionIndex = GeneratedColumn<int>(
    'position_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _searchQueryMeta = const VerificationMeta(
    'searchQuery',
  );
  @override
  late final GeneratedColumn<String> searchQuery = GeneratedColumn<String>(
    'search_query',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dwellTimeMsMeta = const VerificationMeta(
    'dwellTimeMs',
  );
  @override
  late final GeneratedColumn<int> dwellTimeMs = GeneratedColumn<int>(
    'dwell_time_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    sessionId,
    eventType,
    entityType,
    entityId,
    screenName,
    sourceSection,
    positionIndex,
    searchQuery,
    dwellTimeMs,
    metadataJson,
    occurredAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_food_interactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserFoodInteraction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('screen_name')) {
      context.handle(
        _screenNameMeta,
        screenName.isAcceptableOrUnknown(data['screen_name']!, _screenNameMeta),
      );
    }
    if (data.containsKey('source_section')) {
      context.handle(
        _sourceSectionMeta,
        sourceSection.isAcceptableOrUnknown(
          data['source_section']!,
          _sourceSectionMeta,
        ),
      );
    }
    if (data.containsKey('position_index')) {
      context.handle(
        _positionIndexMeta,
        positionIndex.isAcceptableOrUnknown(
          data['position_index']!,
          _positionIndexMeta,
        ),
      );
    }
    if (data.containsKey('search_query')) {
      context.handle(
        _searchQueryMeta,
        searchQuery.isAcceptableOrUnknown(
          data['search_query']!,
          _searchQueryMeta,
        ),
      );
    }
    if (data.containsKey('dwell_time_ms')) {
      context.handle(
        _dwellTimeMsMeta,
        dwellTimeMs.isAcceptableOrUnknown(
          data['dwell_time_ms']!,
          _dwellTimeMsMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserFoodInteraction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFoodInteraction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
      screenName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}screen_name'],
      ),
      sourceSection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_section'],
      ),
      positionIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position_index'],
      ),
      searchQuery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_query'],
      ),
      dwellTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dwell_time_ms'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $UserFoodInteractionsTable createAlias(String alias) {
    return $UserFoodInteractionsTable(attachedDatabase, alias);
  }
}

class UserFoodInteraction extends DataClass
    implements Insertable<UserFoodInteraction> {
  final int id;
  final int localUserId;
  final String sessionId;
  final String eventType;
  final String? entityType;
  final String? entityId;
  final String? screenName;
  final String? sourceSection;
  final int? positionIndex;
  final String? searchQuery;
  final int? dwellTimeMs;
  final String? metadataJson;
  final DateTime occurredAt;
  final DateTime? syncedAt;
  const UserFoodInteraction({
    required this.id,
    required this.localUserId,
    required this.sessionId,
    required this.eventType,
    this.entityType,
    this.entityId,
    this.screenName,
    this.sourceSection,
    this.positionIndex,
    this.searchQuery,
    this.dwellTimeMs,
    this.metadataJson,
    required this.occurredAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['session_id'] = Variable<String>(sessionId);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    if (!nullToAbsent || screenName != null) {
      map['screen_name'] = Variable<String>(screenName);
    }
    if (!nullToAbsent || sourceSection != null) {
      map['source_section'] = Variable<String>(sourceSection);
    }
    if (!nullToAbsent || positionIndex != null) {
      map['position_index'] = Variable<int>(positionIndex);
    }
    if (!nullToAbsent || searchQuery != null) {
      map['search_query'] = Variable<String>(searchQuery);
    }
    if (!nullToAbsent || dwellTimeMs != null) {
      map['dwell_time_ms'] = Variable<int>(dwellTimeMs);
    }
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  UserFoodInteractionsCompanion toCompanion(bool nullToAbsent) {
    return UserFoodInteractionsCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      sessionId: Value(sessionId),
      eventType: Value(eventType),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      screenName: screenName == null && nullToAbsent
          ? const Value.absent()
          : Value(screenName),
      sourceSection: sourceSection == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceSection),
      positionIndex: positionIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(positionIndex),
      searchQuery: searchQuery == null && nullToAbsent
          ? const Value.absent()
          : Value(searchQuery),
      dwellTimeMs: dwellTimeMs == null && nullToAbsent
          ? const Value.absent()
          : Value(dwellTimeMs),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      occurredAt: Value(occurredAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory UserFoodInteraction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFoodInteraction(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      screenName: serializer.fromJson<String?>(json['screenName']),
      sourceSection: serializer.fromJson<String?>(json['sourceSection']),
      positionIndex: serializer.fromJson<int?>(json['positionIndex']),
      searchQuery: serializer.fromJson<String?>(json['searchQuery']),
      dwellTimeMs: serializer.fromJson<int?>(json['dwellTimeMs']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'sessionId': serializer.toJson<String>(sessionId),
      'eventType': serializer.toJson<String>(eventType),
      'entityType': serializer.toJson<String?>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'screenName': serializer.toJson<String?>(screenName),
      'sourceSection': serializer.toJson<String?>(sourceSection),
      'positionIndex': serializer.toJson<int?>(positionIndex),
      'searchQuery': serializer.toJson<String?>(searchQuery),
      'dwellTimeMs': serializer.toJson<int?>(dwellTimeMs),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  UserFoodInteraction copyWith({
    int? id,
    int? localUserId,
    String? sessionId,
    String? eventType,
    Value<String?> entityType = const Value.absent(),
    Value<String?> entityId = const Value.absent(),
    Value<String?> screenName = const Value.absent(),
    Value<String?> sourceSection = const Value.absent(),
    Value<int?> positionIndex = const Value.absent(),
    Value<String?> searchQuery = const Value.absent(),
    Value<int?> dwellTimeMs = const Value.absent(),
    Value<String?> metadataJson = const Value.absent(),
    DateTime? occurredAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => UserFoodInteraction(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    sessionId: sessionId ?? this.sessionId,
    eventType: eventType ?? this.eventType,
    entityType: entityType.present ? entityType.value : this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    screenName: screenName.present ? screenName.value : this.screenName,
    sourceSection: sourceSection.present
        ? sourceSection.value
        : this.sourceSection,
    positionIndex: positionIndex.present
        ? positionIndex.value
        : this.positionIndex,
    searchQuery: searchQuery.present ? searchQuery.value : this.searchQuery,
    dwellTimeMs: dwellTimeMs.present ? dwellTimeMs.value : this.dwellTimeMs,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
    occurredAt: occurredAt ?? this.occurredAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  UserFoodInteraction copyWithCompanion(UserFoodInteractionsCompanion data) {
    return UserFoodInteraction(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      screenName: data.screenName.present
          ? data.screenName.value
          : this.screenName,
      sourceSection: data.sourceSection.present
          ? data.sourceSection.value
          : this.sourceSection,
      positionIndex: data.positionIndex.present
          ? data.positionIndex.value
          : this.positionIndex,
      searchQuery: data.searchQuery.present
          ? data.searchQuery.value
          : this.searchQuery,
      dwellTimeMs: data.dwellTimeMs.present
          ? data.dwellTimeMs.value
          : this.dwellTimeMs,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodInteraction(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('sessionId: $sessionId, ')
          ..write('eventType: $eventType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('screenName: $screenName, ')
          ..write('sourceSection: $sourceSection, ')
          ..write('positionIndex: $positionIndex, ')
          ..write('searchQuery: $searchQuery, ')
          ..write('dwellTimeMs: $dwellTimeMs, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    sessionId,
    eventType,
    entityType,
    entityId,
    screenName,
    sourceSection,
    positionIndex,
    searchQuery,
    dwellTimeMs,
    metadataJson,
    occurredAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFoodInteraction &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.sessionId == this.sessionId &&
          other.eventType == this.eventType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.screenName == this.screenName &&
          other.sourceSection == this.sourceSection &&
          other.positionIndex == this.positionIndex &&
          other.searchQuery == this.searchQuery &&
          other.dwellTimeMs == this.dwellTimeMs &&
          other.metadataJson == this.metadataJson &&
          other.occurredAt == this.occurredAt &&
          other.syncedAt == this.syncedAt);
}

class UserFoodInteractionsCompanion
    extends UpdateCompanion<UserFoodInteraction> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<String> sessionId;
  final Value<String> eventType;
  final Value<String?> entityType;
  final Value<String?> entityId;
  final Value<String?> screenName;
  final Value<String?> sourceSection;
  final Value<int?> positionIndex;
  final Value<String?> searchQuery;
  final Value<int?> dwellTimeMs;
  final Value<String?> metadataJson;
  final Value<DateTime> occurredAt;
  final Value<DateTime?> syncedAt;
  const UserFoodInteractionsCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.screenName = const Value.absent(),
    this.sourceSection = const Value.absent(),
    this.positionIndex = const Value.absent(),
    this.searchQuery = const Value.absent(),
    this.dwellTimeMs = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  UserFoodInteractionsCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required String sessionId,
    required String eventType,
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.screenName = const Value.absent(),
    this.sourceSection = const Value.absent(),
    this.positionIndex = const Value.absent(),
    this.searchQuery = const Value.absent(),
    this.dwellTimeMs = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       sessionId = Value(sessionId),
       eventType = Value(eventType);
  static Insertable<UserFoodInteraction> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<String>? sessionId,
    Expression<String>? eventType,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? screenName,
    Expression<String>? sourceSection,
    Expression<int>? positionIndex,
    Expression<String>? searchQuery,
    Expression<int>? dwellTimeMs,
    Expression<String>? metadataJson,
    Expression<DateTime>? occurredAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (sessionId != null) 'session_id': sessionId,
      if (eventType != null) 'event_type': eventType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (screenName != null) 'screen_name': screenName,
      if (sourceSection != null) 'source_section': sourceSection,
      if (positionIndex != null) 'position_index': positionIndex,
      if (searchQuery != null) 'search_query': searchQuery,
      if (dwellTimeMs != null) 'dwell_time_ms': dwellTimeMs,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  UserFoodInteractionsCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<String>? sessionId,
    Value<String>? eventType,
    Value<String?>? entityType,
    Value<String?>? entityId,
    Value<String?>? screenName,
    Value<String?>? sourceSection,
    Value<int?>? positionIndex,
    Value<String?>? searchQuery,
    Value<int?>? dwellTimeMs,
    Value<String?>? metadataJson,
    Value<DateTime>? occurredAt,
    Value<DateTime?>? syncedAt,
  }) {
    return UserFoodInteractionsCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      sessionId: sessionId ?? this.sessionId,
      eventType: eventType ?? this.eventType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      screenName: screenName ?? this.screenName,
      sourceSection: sourceSection ?? this.sourceSection,
      positionIndex: positionIndex ?? this.positionIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      dwellTimeMs: dwellTimeMs ?? this.dwellTimeMs,
      metadataJson: metadataJson ?? this.metadataJson,
      occurredAt: occurredAt ?? this.occurredAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (screenName.present) {
      map['screen_name'] = Variable<String>(screenName.value);
    }
    if (sourceSection.present) {
      map['source_section'] = Variable<String>(sourceSection.value);
    }
    if (positionIndex.present) {
      map['position_index'] = Variable<int>(positionIndex.value);
    }
    if (searchQuery.present) {
      map['search_query'] = Variable<String>(searchQuery.value);
    }
    if (dwellTimeMs.present) {
      map['dwell_time_ms'] = Variable<int>(dwellTimeMs.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodInteractionsCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('sessionId: $sessionId, ')
          ..write('eventType: $eventType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('screenName: $screenName, ')
          ..write('sourceSection: $sourceSection, ')
          ..write('positionIndex: $positionIndex, ')
          ..write('searchQuery: $searchQuery, ')
          ..write('dwellTimeMs: $dwellTimeMs, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $UserHiddenEntitiesTable extends UserHiddenEntities
    with TableInfo<$UserHiddenEntitiesTable, UserHiddenEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserHiddenEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    entityType,
    entityId,
    reason,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_hidden_entities';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserHiddenEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localUserId, entityType, entityId},
  ];
  @override
  UserHiddenEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserHiddenEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserHiddenEntitiesTable createAlias(String alias) {
    return $UserHiddenEntitiesTable(attachedDatabase, alias);
  }
}

class UserHiddenEntity extends DataClass
    implements Insertable<UserHiddenEntity> {
  final int id;
  final int localUserId;
  final String entityType;
  final String entityId;
  final String? reason;
  final DateTime createdAt;
  const UserHiddenEntity({
    required this.id,
    required this.localUserId,
    required this.entityType,
    required this.entityId,
    this.reason,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserHiddenEntitiesCompanion toCompanion(bool nullToAbsent) {
    return UserHiddenEntitiesCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
    );
  }

  factory UserHiddenEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserHiddenEntity(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserHiddenEntity copyWith({
    int? id,
    int? localUserId,
    String? entityType,
    String? entityId,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
  }) => UserHiddenEntity(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
  );
  UserHiddenEntity copyWithCompanion(UserHiddenEntitiesCompanion data) {
    return UserHiddenEntity(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserHiddenEntity(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, localUserId, entityType, entityId, reason, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserHiddenEntity &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt);
}

class UserHiddenEntitiesCompanion extends UpdateCompanion<UserHiddenEntity> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  const UserHiddenEntitiesCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserHiddenEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required String entityType,
    required String entityId,
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       entityType = Value(entityType),
       entityId = Value(entityId);
  static Insertable<UserHiddenEntity> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserHiddenEntitiesCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
  }) {
    return UserHiddenEntitiesCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserHiddenEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProfileChangeHistoryTable extends ProfileChangeHistory
    with TableInfo<$ProfileChangeHistoryTable, ProfileChangeHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileChangeHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<int> localUserId = GeneratedColumn<int>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionMeta = const VerificationMeta(
    'section',
  );
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
    'section',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldKeyMeta = const VerificationMeta(
    'fieldKey',
  );
  @override
  late final GeneratedColumn<String> fieldKey = GeneratedColumn<String>(
    'field_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldValueJsonMeta = const VerificationMeta(
    'oldValueJson',
  );
  @override
  late final GeneratedColumn<String> oldValueJson = GeneratedColumn<String>(
    'old_value_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newValueJsonMeta = const VerificationMeta(
    'newValueJson',
  );
  @override
  late final GeneratedColumn<String> newValueJson = GeneratedColumn<String>(
    'new_value_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    section,
    fieldKey,
    oldValueJson,
    newValueJson,
    source,
    changedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_change_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileChangeHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('section')) {
      context.handle(
        _sectionMeta,
        section.isAcceptableOrUnknown(data['section']!, _sectionMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('field_key')) {
      context.handle(
        _fieldKeyMeta,
        fieldKey.isAcceptableOrUnknown(data['field_key']!, _fieldKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldKeyMeta);
    }
    if (data.containsKey('old_value_json')) {
      context.handle(
        _oldValueJsonMeta,
        oldValueJson.isAcceptableOrUnknown(
          data['old_value_json']!,
          _oldValueJsonMeta,
        ),
      );
    }
    if (data.containsKey('new_value_json')) {
      context.handle(
        _newValueJsonMeta,
        newValueJson.isAcceptableOrUnknown(
          data['new_value_json']!,
          _newValueJsonMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileChangeHistoryData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileChangeHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_user_id'],
      )!,
      section: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section'],
      )!,
      fieldKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_key'],
      )!,
      oldValueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}old_value_json'],
      ),
      newValueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_value_json'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
    );
  }

  @override
  $ProfileChangeHistoryTable createAlias(String alias) {
    return $ProfileChangeHistoryTable(attachedDatabase, alias);
  }
}

class ProfileChangeHistoryData extends DataClass
    implements Insertable<ProfileChangeHistoryData> {
  final int id;
  final int localUserId;
  final String section;
  final String fieldKey;
  final String? oldValueJson;
  final String? newValueJson;
  final String source;
  final DateTime changedAt;
  const ProfileChangeHistoryData({
    required this.id,
    required this.localUserId,
    required this.section,
    required this.fieldKey,
    this.oldValueJson,
    this.newValueJson,
    required this.source,
    required this.changedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_user_id'] = Variable<int>(localUserId);
    map['section'] = Variable<String>(section);
    map['field_key'] = Variable<String>(fieldKey);
    if (!nullToAbsent || oldValueJson != null) {
      map['old_value_json'] = Variable<String>(oldValueJson);
    }
    if (!nullToAbsent || newValueJson != null) {
      map['new_value_json'] = Variable<String>(newValueJson);
    }
    map['source'] = Variable<String>(source);
    map['changed_at'] = Variable<DateTime>(changedAt);
    return map;
  }

  ProfileChangeHistoryCompanion toCompanion(bool nullToAbsent) {
    return ProfileChangeHistoryCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      section: Value(section),
      fieldKey: Value(fieldKey),
      oldValueJson: oldValueJson == null && nullToAbsent
          ? const Value.absent()
          : Value(oldValueJson),
      newValueJson: newValueJson == null && nullToAbsent
          ? const Value.absent()
          : Value(newValueJson),
      source: Value(source),
      changedAt: Value(changedAt),
    );
  }

  factory ProfileChangeHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileChangeHistoryData(
      id: serializer.fromJson<int>(json['id']),
      localUserId: serializer.fromJson<int>(json['localUserId']),
      section: serializer.fromJson<String>(json['section']),
      fieldKey: serializer.fromJson<String>(json['fieldKey']),
      oldValueJson: serializer.fromJson<String?>(json['oldValueJson']),
      newValueJson: serializer.fromJson<String?>(json['newValueJson']),
      source: serializer.fromJson<String>(json['source']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localUserId': serializer.toJson<int>(localUserId),
      'section': serializer.toJson<String>(section),
      'fieldKey': serializer.toJson<String>(fieldKey),
      'oldValueJson': serializer.toJson<String?>(oldValueJson),
      'newValueJson': serializer.toJson<String?>(newValueJson),
      'source': serializer.toJson<String>(source),
      'changedAt': serializer.toJson<DateTime>(changedAt),
    };
  }

  ProfileChangeHistoryData copyWith({
    int? id,
    int? localUserId,
    String? section,
    String? fieldKey,
    Value<String?> oldValueJson = const Value.absent(),
    Value<String?> newValueJson = const Value.absent(),
    String? source,
    DateTime? changedAt,
  }) => ProfileChangeHistoryData(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    section: section ?? this.section,
    fieldKey: fieldKey ?? this.fieldKey,
    oldValueJson: oldValueJson.present ? oldValueJson.value : this.oldValueJson,
    newValueJson: newValueJson.present ? newValueJson.value : this.newValueJson,
    source: source ?? this.source,
    changedAt: changedAt ?? this.changedAt,
  );
  ProfileChangeHistoryData copyWithCompanion(
    ProfileChangeHistoryCompanion data,
  ) {
    return ProfileChangeHistoryData(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      section: data.section.present ? data.section.value : this.section,
      fieldKey: data.fieldKey.present ? data.fieldKey.value : this.fieldKey,
      oldValueJson: data.oldValueJson.present
          ? data.oldValueJson.value
          : this.oldValueJson,
      newValueJson: data.newValueJson.present
          ? data.newValueJson.value
          : this.newValueJson,
      source: data.source.present ? data.source.value : this.source,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileChangeHistoryData(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('section: $section, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('oldValueJson: $oldValueJson, ')
          ..write('newValueJson: $newValueJson, ')
          ..write('source: $source, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    section,
    fieldKey,
    oldValueJson,
    newValueJson,
    source,
    changedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileChangeHistoryData &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.section == this.section &&
          other.fieldKey == this.fieldKey &&
          other.oldValueJson == this.oldValueJson &&
          other.newValueJson == this.newValueJson &&
          other.source == this.source &&
          other.changedAt == this.changedAt);
}

class ProfileChangeHistoryCompanion
    extends UpdateCompanion<ProfileChangeHistoryData> {
  final Value<int> id;
  final Value<int> localUserId;
  final Value<String> section;
  final Value<String> fieldKey;
  final Value<String?> oldValueJson;
  final Value<String?> newValueJson;
  final Value<String> source;
  final Value<DateTime> changedAt;
  const ProfileChangeHistoryCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.section = const Value.absent(),
    this.fieldKey = const Value.absent(),
    this.oldValueJson = const Value.absent(),
    this.newValueJson = const Value.absent(),
    this.source = const Value.absent(),
    this.changedAt = const Value.absent(),
  });
  ProfileChangeHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int localUserId,
    required String section,
    required String fieldKey,
    this.oldValueJson = const Value.absent(),
    this.newValueJson = const Value.absent(),
    required String source,
    this.changedAt = const Value.absent(),
  }) : localUserId = Value(localUserId),
       section = Value(section),
       fieldKey = Value(fieldKey),
       source = Value(source);
  static Insertable<ProfileChangeHistoryData> custom({
    Expression<int>? id,
    Expression<int>? localUserId,
    Expression<String>? section,
    Expression<String>? fieldKey,
    Expression<String>? oldValueJson,
    Expression<String>? newValueJson,
    Expression<String>? source,
    Expression<DateTime>? changedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (section != null) 'section': section,
      if (fieldKey != null) 'field_key': fieldKey,
      if (oldValueJson != null) 'old_value_json': oldValueJson,
      if (newValueJson != null) 'new_value_json': newValueJson,
      if (source != null) 'source': source,
      if (changedAt != null) 'changed_at': changedAt,
    });
  }

  ProfileChangeHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? localUserId,
    Value<String>? section,
    Value<String>? fieldKey,
    Value<String?>? oldValueJson,
    Value<String?>? newValueJson,
    Value<String>? source,
    Value<DateTime>? changedAt,
  }) {
    return ProfileChangeHistoryCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      section: section ?? this.section,
      fieldKey: fieldKey ?? this.fieldKey,
      oldValueJson: oldValueJson ?? this.oldValueJson,
      newValueJson: newValueJson ?? this.newValueJson,
      source: source ?? this.source,
      changedAt: changedAt ?? this.changedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<int>(localUserId.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (fieldKey.present) {
      map['field_key'] = Variable<String>(fieldKey.value);
    }
    if (oldValueJson.present) {
      map['old_value_json'] = Variable<String>(oldValueJson.value);
    }
    if (newValueJson.present) {
      map['new_value_json'] = Variable<String>(newValueJson.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileChangeHistoryCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('section: $section, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('oldValueJson: $oldValueJson, ')
          ..write('newValueJson: $newValueJson, ')
          ..write('source: $source, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodProfilesTable foodProfiles = $FoodProfilesTable(this);
  late final $FoodRulesTable foodRules = $FoodRulesTable(this);
  late final $UserFoodRulesTable userFoodRules = $UserFoodRulesTable(this);
  late final $AllergensTable allergens = $AllergensTable(this);
  late final $UserAllergiesTable userAllergies = $UserAllergiesTable(this);
  late final $IntolerancesTable intolerances = $IntolerancesTable(this);
  late final $UserIntolerancesTable userIntolerances = $UserIntolerancesTable(
    this,
  );
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $UserIngredientPreferencesTable userIngredientPreferences =
      $UserIngredientPreferencesTable(this);
  late final $CuisinesTable cuisines = $CuisinesTable(this);
  late final $UserCuisinePreferencesTable userCuisinePreferences =
      $UserCuisinePreferencesTable(this);
  late final $FlavorAttributesTable flavorAttributes = $FlavorAttributesTable(
    this,
  );
  late final $UserFlavorPreferencesTable userFlavorPreferences =
      $UserFlavorPreferencesTable(this);
  late final $FoodItemsTable foodItems = $FoodItemsTable(this);
  late final $FoodItemIngredientsTable foodItemIngredients =
      $FoodItemIngredientsTable(this);
  late final $FoodItemAllergensTable foodItemAllergens =
      $FoodItemAllergensTable(this);
  late final $UserFoodItemPreferencesTable userFoodItemPreferences =
      $UserFoodItemPreferencesTable(this);
  late final $UserFoodInteractionsTable userFoodInteractions =
      $UserFoodInteractionsTable(this);
  late final $UserHiddenEntitiesTable userHiddenEntities =
      $UserHiddenEntitiesTable(this);
  late final $ProfileChangeHistoryTable profileChangeHistory =
      $ProfileChangeHistoryTable(this);
  late final FoodProfileDao foodProfileDao = FoodProfileDao(
    this as AppDatabase,
  );
  late final AllergyDao allergyDao = AllergyDao(this as AppDatabase);
  late final IntoleranceDao intoleranceDao = IntoleranceDao(
    this as AppDatabase,
  );
  late final IngredientPreferenceDao ingredientPreferenceDao =
      IngredientPreferenceDao(this as AppDatabase);
  late final CuisinePreferenceDao cuisinePreferenceDao = CuisinePreferenceDao(
    this as AppDatabase,
  );
  late final FlavorPreferenceDao flavorPreferenceDao = FlavorPreferenceDao(
    this as AppDatabase,
  );
  late final FoodItemDao foodItemDao = FoodItemDao(this as AppDatabase);
  late final InteractionDao interactionDao = InteractionDao(
    this as AppDatabase,
  );
  late final ProfileHistoryDao profileHistoryDao = ProfileHistoryDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    foodProfiles,
    foodRules,
    userFoodRules,
    allergens,
    userAllergies,
    intolerances,
    userIntolerances,
    ingredients,
    userIngredientPreferences,
    cuisines,
    userCuisinePreferences,
    flavorAttributes,
    userFlavorPreferences,
    foodItems,
    foodItemIngredients,
    foodItemAllergens,
    userFoodItemPreferences,
    userFoodInteractions,
    userHiddenEntities,
    profileChangeHistory,
  ];
}

typedef $$FoodProfilesTableCreateCompanionBuilder =
    FoodProfilesCompanion Function({
      Value<int> id,
      required int localUserId,
      Value<String> dietType,
      Value<String?> adventurousnessLevel,
      Value<String?> preferredMealWeight,
      Value<String?> budgetLevel,
      Value<String?> topPriorities,
      Value<String> onboardingStatus,
      Value<int> onboardingVersion,
      Value<int> onboardingStep,
      Value<bool> personalizationEnabled,
      Value<double> profileCompleteness,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> completedAt,
      Value<DateTime?> skippedAt,
    });
typedef $$FoodProfilesTableUpdateCompanionBuilder =
    FoodProfilesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<String> dietType,
      Value<String?> adventurousnessLevel,
      Value<String?> preferredMealWeight,
      Value<String?> budgetLevel,
      Value<String?> topPriorities,
      Value<String> onboardingStatus,
      Value<int> onboardingVersion,
      Value<int> onboardingStep,
      Value<bool> personalizationEnabled,
      Value<double> profileCompleteness,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> completedAt,
      Value<DateTime?> skippedAt,
    });

class $$FoodProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodProfilesTable> {
  $$FoodProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dietType => $composableBuilder(
    column: $table.dietType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adventurousnessLevel => $composableBuilder(
    column: $table.adventurousnessLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredMealWeight => $composableBuilder(
    column: $table.preferredMealWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get budgetLevel => $composableBuilder(
    column: $table.budgetLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topPriorities => $composableBuilder(
    column: $table.topPriorities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get onboardingStatus => $composableBuilder(
    column: $table.onboardingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get onboardingVersion => $composableBuilder(
    column: $table.onboardingVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get onboardingStep => $composableBuilder(
    column: $table.onboardingStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get personalizationEnabled => $composableBuilder(
    column: $table.personalizationEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get profileCompleteness => $composableBuilder(
    column: $table.profileCompleteness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get skippedAt => $composableBuilder(
    column: $table.skippedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodProfilesTable> {
  $$FoodProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dietType => $composableBuilder(
    column: $table.dietType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adventurousnessLevel => $composableBuilder(
    column: $table.adventurousnessLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredMealWeight => $composableBuilder(
    column: $table.preferredMealWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get budgetLevel => $composableBuilder(
    column: $table.budgetLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topPriorities => $composableBuilder(
    column: $table.topPriorities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get onboardingStatus => $composableBuilder(
    column: $table.onboardingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get onboardingVersion => $composableBuilder(
    column: $table.onboardingVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get onboardingStep => $composableBuilder(
    column: $table.onboardingStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get personalizationEnabled => $composableBuilder(
    column: $table.personalizationEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get profileCompleteness => $composableBuilder(
    column: $table.profileCompleteness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get skippedAt => $composableBuilder(
    column: $table.skippedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodProfilesTable> {
  $$FoodProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dietType =>
      $composableBuilder(column: $table.dietType, builder: (column) => column);

  GeneratedColumn<String> get adventurousnessLevel => $composableBuilder(
    column: $table.adventurousnessLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredMealWeight => $composableBuilder(
    column: $table.preferredMealWeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get budgetLevel => $composableBuilder(
    column: $table.budgetLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get topPriorities => $composableBuilder(
    column: $table.topPriorities,
    builder: (column) => column,
  );

  GeneratedColumn<String> get onboardingStatus => $composableBuilder(
    column: $table.onboardingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get onboardingVersion => $composableBuilder(
    column: $table.onboardingVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get onboardingStep => $composableBuilder(
    column: $table.onboardingStep,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get personalizationEnabled => $composableBuilder(
    column: $table.personalizationEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<double> get profileCompleteness => $composableBuilder(
    column: $table.profileCompleteness,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get skippedAt =>
      $composableBuilder(column: $table.skippedAt, builder: (column) => column);
}

class $$FoodProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodProfilesTable,
          FoodProfile,
          $$FoodProfilesTableFilterComposer,
          $$FoodProfilesTableOrderingComposer,
          $$FoodProfilesTableAnnotationComposer,
          $$FoodProfilesTableCreateCompanionBuilder,
          $$FoodProfilesTableUpdateCompanionBuilder,
          (
            FoodProfile,
            BaseReferences<_$AppDatabase, $FoodProfilesTable, FoodProfile>,
          ),
          FoodProfile,
          PrefetchHooks Function()
        > {
  $$FoodProfilesTableTableManager(_$AppDatabase db, $FoodProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<String> dietType = const Value.absent(),
                Value<String?> adventurousnessLevel = const Value.absent(),
                Value<String?> preferredMealWeight = const Value.absent(),
                Value<String?> budgetLevel = const Value.absent(),
                Value<String?> topPriorities = const Value.absent(),
                Value<String> onboardingStatus = const Value.absent(),
                Value<int> onboardingVersion = const Value.absent(),
                Value<int> onboardingStep = const Value.absent(),
                Value<bool> personalizationEnabled = const Value.absent(),
                Value<double> profileCompleteness = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> skippedAt = const Value.absent(),
              }) => FoodProfilesCompanion(
                id: id,
                localUserId: localUserId,
                dietType: dietType,
                adventurousnessLevel: adventurousnessLevel,
                preferredMealWeight: preferredMealWeight,
                budgetLevel: budgetLevel,
                topPriorities: topPriorities,
                onboardingStatus: onboardingStatus,
                onboardingVersion: onboardingVersion,
                onboardingStep: onboardingStep,
                personalizationEnabled: personalizationEnabled,
                profileCompleteness: profileCompleteness,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                skippedAt: skippedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                Value<String> dietType = const Value.absent(),
                Value<String?> adventurousnessLevel = const Value.absent(),
                Value<String?> preferredMealWeight = const Value.absent(),
                Value<String?> budgetLevel = const Value.absent(),
                Value<String?> topPriorities = const Value.absent(),
                Value<String> onboardingStatus = const Value.absent(),
                Value<int> onboardingVersion = const Value.absent(),
                Value<int> onboardingStep = const Value.absent(),
                Value<bool> personalizationEnabled = const Value.absent(),
                Value<double> profileCompleteness = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> skippedAt = const Value.absent(),
              }) => FoodProfilesCompanion.insert(
                id: id,
                localUserId: localUserId,
                dietType: dietType,
                adventurousnessLevel: adventurousnessLevel,
                preferredMealWeight: preferredMealWeight,
                budgetLevel: budgetLevel,
                topPriorities: topPriorities,
                onboardingStatus: onboardingStatus,
                onboardingVersion: onboardingVersion,
                onboardingStep: onboardingStep,
                personalizationEnabled: personalizationEnabled,
                profileCompleteness: profileCompleteness,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                skippedAt: skippedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodProfilesTable,
      FoodProfile,
      $$FoodProfilesTableFilterComposer,
      $$FoodProfilesTableOrderingComposer,
      $$FoodProfilesTableAnnotationComposer,
      $$FoodProfilesTableCreateCompanionBuilder,
      $$FoodProfilesTableUpdateCompanionBuilder,
      (
        FoodProfile,
        BaseReferences<_$AppDatabase, $FoodProfilesTable, FoodProfile>,
      ),
      FoodProfile,
      PrefetchHooks Function()
    >;
typedef $$FoodRulesTableCreateCompanionBuilder =
    FoodRulesCompanion Function({
      Value<int> id,
      required String code,
      required String displayNameKey,
      required String category,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });
typedef $$FoodRulesTableUpdateCompanionBuilder =
    FoodRulesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> displayNameKey,
      Value<String> category,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });

final class $$FoodRulesTableReferences
    extends BaseReferences<_$AppDatabase, $FoodRulesTable, FoodRule> {
  $$FoodRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserFoodRulesTable, List<UserFoodRule>>
  _userFoodRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userFoodRules,
    aliasName: $_aliasNameGenerator(
      db.foodRules.id,
      db.userFoodRules.foodRuleId,
    ),
  );

  $$UserFoodRulesTableProcessedTableManager get userFoodRulesRefs {
    final manager = $$UserFoodRulesTableTableManager(
      $_db,
      $_db.userFoodRules,
    ).filter((f) => f.foodRuleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userFoodRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoodRulesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodRulesTable> {
  $$FoodRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userFoodRulesRefs(
    Expression<bool> Function($$UserFoodRulesTableFilterComposer f) f,
  ) {
    final $$UserFoodRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userFoodRules,
      getReferencedColumn: (t) => t.foodRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserFoodRulesTableFilterComposer(
            $db: $db,
            $table: $db.userFoodRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodRulesTable> {
  $$FoodRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodRulesTable> {
  $$FoodRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userFoodRulesRefs<T extends Object>(
    Expression<T> Function($$UserFoodRulesTableAnnotationComposer a) f,
  ) {
    final $$UserFoodRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userFoodRules,
      getReferencedColumn: (t) => t.foodRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserFoodRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.userFoodRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodRulesTable,
          FoodRule,
          $$FoodRulesTableFilterComposer,
          $$FoodRulesTableOrderingComposer,
          $$FoodRulesTableAnnotationComposer,
          $$FoodRulesTableCreateCompanionBuilder,
          $$FoodRulesTableUpdateCompanionBuilder,
          (FoodRule, $$FoodRulesTableReferences),
          FoodRule,
          PrefetchHooks Function({bool userFoodRulesRefs})
        > {
  $$FoodRulesTableTableManager(_$AppDatabase db, $FoodRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodRulesCompanion(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                category: category,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String displayNameKey,
                required String category,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodRulesCompanion.insert(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                category: category,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userFoodRulesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userFoodRulesRefs) db.userFoodRules,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userFoodRulesRefs)
                    await $_getPrefetchedData<
                      FoodRule,
                      $FoodRulesTable,
                      UserFoodRule
                    >(
                      currentTable: table,
                      referencedTable: $$FoodRulesTableReferences
                          ._userFoodRulesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FoodRulesTableReferences(
                            db,
                            table,
                            p0,
                          ).userFoodRulesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.foodRuleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FoodRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodRulesTable,
      FoodRule,
      $$FoodRulesTableFilterComposer,
      $$FoodRulesTableOrderingComposer,
      $$FoodRulesTableAnnotationComposer,
      $$FoodRulesTableCreateCompanionBuilder,
      $$FoodRulesTableUpdateCompanionBuilder,
      (FoodRule, $$FoodRulesTableReferences),
      FoodRule,
      PrefetchHooks Function({bool userFoodRulesRefs})
    >;
typedef $$UserFoodRulesTableCreateCompanionBuilder =
    UserFoodRulesCompanion Function({
      Value<int> id,
      required int localUserId,
      required int foodRuleId,
      required String requirementLevel,
      required String source,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserFoodRulesTableUpdateCompanionBuilder =
    UserFoodRulesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int> foodRuleId,
      Value<String> requirementLevel,
      Value<String> source,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserFoodRulesTableReferences
    extends BaseReferences<_$AppDatabase, $UserFoodRulesTable, UserFoodRule> {
  $$UserFoodRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodRulesTable _foodRuleIdTable(_$AppDatabase db) =>
      db.foodRules.createAlias(
        $_aliasNameGenerator(db.userFoodRules.foodRuleId, db.foodRules.id),
      );

  $$FoodRulesTableProcessedTableManager get foodRuleId {
    final $_column = $_itemColumn<int>('food_rule_id')!;

    final manager = $$FoodRulesTableTableManager(
      $_db,
      $_db.foodRules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodRuleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserFoodRulesTableFilterComposer
    extends Composer<_$AppDatabase, $UserFoodRulesTable> {
  $$UserFoodRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requirementLevel => $composableBuilder(
    column: $table.requirementLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodRulesTableFilterComposer get foodRuleId {
    final $$FoodRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodRuleId,
      referencedTable: $db.foodRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodRulesTableFilterComposer(
            $db: $db,
            $table: $db.foodRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFoodRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFoodRulesTable> {
  $$UserFoodRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requirementLevel => $composableBuilder(
    column: $table.requirementLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodRulesTableOrderingComposer get foodRuleId {
    final $$FoodRulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodRuleId,
      referencedTable: $db.foodRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodRulesTableOrderingComposer(
            $db: $db,
            $table: $db.foodRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFoodRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFoodRulesTable> {
  $$UserFoodRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requirementLevel => $composableBuilder(
    column: $table.requirementLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FoodRulesTableAnnotationComposer get foodRuleId {
    final $$FoodRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodRuleId,
      referencedTable: $db.foodRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.foodRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFoodRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserFoodRulesTable,
          UserFoodRule,
          $$UserFoodRulesTableFilterComposer,
          $$UserFoodRulesTableOrderingComposer,
          $$UserFoodRulesTableAnnotationComposer,
          $$UserFoodRulesTableCreateCompanionBuilder,
          $$UserFoodRulesTableUpdateCompanionBuilder,
          (UserFoodRule, $$UserFoodRulesTableReferences),
          UserFoodRule,
          PrefetchHooks Function({bool foodRuleId})
        > {
  $$UserFoodRulesTableTableManager(_$AppDatabase db, $UserFoodRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFoodRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserFoodRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserFoodRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int> foodRuleId = const Value.absent(),
                Value<String> requirementLevel = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserFoodRulesCompanion(
                id: id,
                localUserId: localUserId,
                foodRuleId: foodRuleId,
                requirementLevel: requirementLevel,
                source: source,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required int foodRuleId,
                required String requirementLevel,
                required String source,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserFoodRulesCompanion.insert(
                id: id,
                localUserId: localUserId,
                foodRuleId: foodRuleId,
                requirementLevel: requirementLevel,
                source: source,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserFoodRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodRuleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodRuleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodRuleId,
                                referencedTable: $$UserFoodRulesTableReferences
                                    ._foodRuleIdTable(db),
                                referencedColumn: $$UserFoodRulesTableReferences
                                    ._foodRuleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserFoodRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserFoodRulesTable,
      UserFoodRule,
      $$UserFoodRulesTableFilterComposer,
      $$UserFoodRulesTableOrderingComposer,
      $$UserFoodRulesTableAnnotationComposer,
      $$UserFoodRulesTableCreateCompanionBuilder,
      $$UserFoodRulesTableUpdateCompanionBuilder,
      (UserFoodRule, $$UserFoodRulesTableReferences),
      UserFoodRule,
      PrefetchHooks Function({bool foodRuleId})
    >;
typedef $$AllergensTableCreateCompanionBuilder =
    AllergensCompanion Function({
      Value<int> id,
      required String code,
      required String displayNameKey,
      Value<String> category,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });
typedef $$AllergensTableUpdateCompanionBuilder =
    AllergensCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> displayNameKey,
      Value<String> category,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });

final class $$AllergensTableReferences
    extends BaseReferences<_$AppDatabase, $AllergensTable, Allergen> {
  $$AllergensTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserAllergiesTable, List<UserAllergy>>
  _userAllergiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAllergies,
    aliasName: $_aliasNameGenerator(
      db.allergens.id,
      db.userAllergies.allergenId,
    ),
  );

  $$UserAllergiesTableProcessedTableManager get userAllergiesRefs {
    final manager = $$UserAllergiesTableTableManager(
      $_db,
      $_db.userAllergies,
    ).filter((f) => f.allergenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userAllergiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FoodItemAllergensTable, List<FoodItemAllergen>>
  _foodItemAllergensRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.foodItemAllergens,
        aliasName: $_aliasNameGenerator(
          db.allergens.id,
          db.foodItemAllergens.allergenId,
        ),
      );

  $$FoodItemAllergensTableProcessedTableManager get foodItemAllergensRefs {
    final manager = $$FoodItemAllergensTableTableManager(
      $_db,
      $_db.foodItemAllergens,
    ).filter((f) => f.allergenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _foodItemAllergensRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AllergensTableFilterComposer
    extends Composer<_$AppDatabase, $AllergensTable> {
  $$AllergensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userAllergiesRefs(
    Expression<bool> Function($$UserAllergiesTableFilterComposer f) f,
  ) {
    final $$UserAllergiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAllergies,
      getReferencedColumn: (t) => t.allergenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAllergiesTableFilterComposer(
            $db: $db,
            $table: $db.userAllergies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> foodItemAllergensRefs(
    Expression<bool> Function($$FoodItemAllergensTableFilterComposer f) f,
  ) {
    final $$FoodItemAllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItemAllergens,
      getReferencedColumn: (t) => t.allergenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemAllergensTableFilterComposer(
            $db: $db,
            $table: $db.foodItemAllergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllergensTableOrderingComposer
    extends Composer<_$AppDatabase, $AllergensTable> {
  $$AllergensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AllergensTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllergensTable> {
  $$AllergensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userAllergiesRefs<T extends Object>(
    Expression<T> Function($$UserAllergiesTableAnnotationComposer a) f,
  ) {
    final $$UserAllergiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAllergies,
      getReferencedColumn: (t) => t.allergenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAllergiesTableAnnotationComposer(
            $db: $db,
            $table: $db.userAllergies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> foodItemAllergensRefs<T extends Object>(
    Expression<T> Function($$FoodItemAllergensTableAnnotationComposer a) f,
  ) {
    final $$FoodItemAllergensTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.foodItemAllergens,
          getReferencedColumn: (t) => t.allergenId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FoodItemAllergensTableAnnotationComposer(
                $db: $db,
                $table: $db.foodItemAllergens,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AllergensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AllergensTable,
          Allergen,
          $$AllergensTableFilterComposer,
          $$AllergensTableOrderingComposer,
          $$AllergensTableAnnotationComposer,
          $$AllergensTableCreateCompanionBuilder,
          $$AllergensTableUpdateCompanionBuilder,
          (Allergen, $$AllergensTableReferences),
          Allergen,
          PrefetchHooks Function({
            bool userAllergiesRefs,
            bool foodItemAllergensRefs,
          })
        > {
  $$AllergensTableTableManager(_$AppDatabase db, $AllergensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllergensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllergensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllergensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AllergensCompanion(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                category: category,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String displayNameKey,
                Value<String> category = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AllergensCompanion.insert(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                category: category,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AllergensTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userAllergiesRefs = false, foodItemAllergensRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userAllergiesRefs) db.userAllergies,
                    if (foodItemAllergensRefs) db.foodItemAllergens,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userAllergiesRefs)
                        await $_getPrefetchedData<
                          Allergen,
                          $AllergensTable,
                          UserAllergy
                        >(
                          currentTable: table,
                          referencedTable: $$AllergensTableReferences
                              ._userAllergiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AllergensTableReferences(
                                db,
                                table,
                                p0,
                              ).userAllergiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.allergenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (foodItemAllergensRefs)
                        await $_getPrefetchedData<
                          Allergen,
                          $AllergensTable,
                          FoodItemAllergen
                        >(
                          currentTable: table,
                          referencedTable: $$AllergensTableReferences
                              ._foodItemAllergensRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AllergensTableReferences(
                                db,
                                table,
                                p0,
                              ).foodItemAllergensRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.allergenId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AllergensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AllergensTable,
      Allergen,
      $$AllergensTableFilterComposer,
      $$AllergensTableOrderingComposer,
      $$AllergensTableAnnotationComposer,
      $$AllergensTableCreateCompanionBuilder,
      $$AllergensTableUpdateCompanionBuilder,
      (Allergen, $$AllergensTableReferences),
      Allergen,
      PrefetchHooks Function({
        bool userAllergiesRefs,
        bool foodItemAllergensRefs,
      })
    >;
typedef $$UserAllergiesTableCreateCompanionBuilder =
    UserAllergiesCompanion Function({
      Value<int> id,
      required int localUserId,
      Value<int?> allergenId,
      Value<String?> customName,
      Value<String> severity,
      Value<String?> notes,
      Value<bool> isActive,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserAllergiesTableUpdateCompanionBuilder =
    UserAllergiesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int?> allergenId,
      Value<String?> customName,
      Value<String> severity,
      Value<String?> notes,
      Value<bool> isActive,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserAllergiesTableReferences
    extends BaseReferences<_$AppDatabase, $UserAllergiesTable, UserAllergy> {
  $$UserAllergiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AllergensTable _allergenIdTable(_$AppDatabase db) =>
      db.allergens.createAlias(
        $_aliasNameGenerator(db.userAllergies.allergenId, db.allergens.id),
      );

  $$AllergensTableProcessedTableManager? get allergenId {
    final $_column = $_itemColumn<int>('allergen_id');
    if ($_column == null) return null;
    final manager = $$AllergensTableTableManager(
      $_db,
      $_db.allergens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_allergenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserAllergiesTableFilterComposer
    extends Composer<_$AppDatabase, $UserAllergiesTable> {
  $$UserAllergiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AllergensTableFilterComposer get allergenId {
    final $$AllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableFilterComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAllergiesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAllergiesTable> {
  $$UserAllergiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AllergensTableOrderingComposer get allergenId {
    final $$AllergensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableOrderingComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAllergiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAllergiesTable> {
  $$UserAllergiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AllergensTableAnnotationComposer get allergenId {
    final $$AllergensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableAnnotationComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAllergiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAllergiesTable,
          UserAllergy,
          $$UserAllergiesTableFilterComposer,
          $$UserAllergiesTableOrderingComposer,
          $$UserAllergiesTableAnnotationComposer,
          $$UserAllergiesTableCreateCompanionBuilder,
          $$UserAllergiesTableUpdateCompanionBuilder,
          (UserAllergy, $$UserAllergiesTableReferences),
          UserAllergy,
          PrefetchHooks Function({bool allergenId})
        > {
  $$UserAllergiesTableTableManager(_$AppDatabase db, $UserAllergiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAllergiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAllergiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAllergiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int?> allergenId = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserAllergiesCompanion(
                id: id,
                localUserId: localUserId,
                allergenId: allergenId,
                customName: customName,
                severity: severity,
                notes: notes,
                isActive: isActive,
                source: source,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                Value<int?> allergenId = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserAllergiesCompanion.insert(
                id: id,
                localUserId: localUserId,
                allergenId: allergenId,
                customName: customName,
                severity: severity,
                notes: notes,
                isActive: isActive,
                source: source,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserAllergiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({allergenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (allergenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.allergenId,
                                referencedTable: $$UserAllergiesTableReferences
                                    ._allergenIdTable(db),
                                referencedColumn: $$UserAllergiesTableReferences
                                    ._allergenIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserAllergiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAllergiesTable,
      UserAllergy,
      $$UserAllergiesTableFilterComposer,
      $$UserAllergiesTableOrderingComposer,
      $$UserAllergiesTableAnnotationComposer,
      $$UserAllergiesTableCreateCompanionBuilder,
      $$UserAllergiesTableUpdateCompanionBuilder,
      (UserAllergy, $$UserAllergiesTableReferences),
      UserAllergy,
      PrefetchHooks Function({bool allergenId})
    >;
typedef $$IntolerancesTableCreateCompanionBuilder =
    IntolerancesCompanion Function({
      Value<int> id,
      required String code,
      required String displayNameKey,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });
typedef $$IntolerancesTableUpdateCompanionBuilder =
    IntolerancesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> displayNameKey,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });

final class $$IntolerancesTableReferences
    extends BaseReferences<_$AppDatabase, $IntolerancesTable, Intolerance> {
  $$IntolerancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserIntolerancesTable, List<UserIntolerance>>
  _userIntolerancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userIntolerances,
    aliasName: $_aliasNameGenerator(
      db.intolerances.id,
      db.userIntolerances.intoleranceId,
    ),
  );

  $$UserIntolerancesTableProcessedTableManager get userIntolerancesRefs {
    final manager = $$UserIntolerancesTableTableManager(
      $_db,
      $_db.userIntolerances,
    ).filter((f) => f.intoleranceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userIntolerancesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IntolerancesTableFilterComposer
    extends Composer<_$AppDatabase, $IntolerancesTable> {
  $$IntolerancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userIntolerancesRefs(
    Expression<bool> Function($$UserIntolerancesTableFilterComposer f) f,
  ) {
    final $$UserIntolerancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userIntolerances,
      getReferencedColumn: (t) => t.intoleranceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserIntolerancesTableFilterComposer(
            $db: $db,
            $table: $db.userIntolerances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IntolerancesTableOrderingComposer
    extends Composer<_$AppDatabase, $IntolerancesTable> {
  $$IntolerancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IntolerancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IntolerancesTable> {
  $$IntolerancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userIntolerancesRefs<T extends Object>(
    Expression<T> Function($$UserIntolerancesTableAnnotationComposer a) f,
  ) {
    final $$UserIntolerancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userIntolerances,
      getReferencedColumn: (t) => t.intoleranceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserIntolerancesTableAnnotationComposer(
            $db: $db,
            $table: $db.userIntolerances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IntolerancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IntolerancesTable,
          Intolerance,
          $$IntolerancesTableFilterComposer,
          $$IntolerancesTableOrderingComposer,
          $$IntolerancesTableAnnotationComposer,
          $$IntolerancesTableCreateCompanionBuilder,
          $$IntolerancesTableUpdateCompanionBuilder,
          (Intolerance, $$IntolerancesTableReferences),
          Intolerance,
          PrefetchHooks Function({bool userIntolerancesRefs})
        > {
  $$IntolerancesTableTableManager(_$AppDatabase db, $IntolerancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IntolerancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IntolerancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IntolerancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => IntolerancesCompanion(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String displayNameKey,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => IntolerancesCompanion.insert(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IntolerancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userIntolerancesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userIntolerancesRefs) db.userIntolerances,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userIntolerancesRefs)
                    await $_getPrefetchedData<
                      Intolerance,
                      $IntolerancesTable,
                      UserIntolerance
                    >(
                      currentTable: table,
                      referencedTable: $$IntolerancesTableReferences
                          ._userIntolerancesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$IntolerancesTableReferences(
                            db,
                            table,
                            p0,
                          ).userIntolerancesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.intoleranceId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$IntolerancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IntolerancesTable,
      Intolerance,
      $$IntolerancesTableFilterComposer,
      $$IntolerancesTableOrderingComposer,
      $$IntolerancesTableAnnotationComposer,
      $$IntolerancesTableCreateCompanionBuilder,
      $$IntolerancesTableUpdateCompanionBuilder,
      (Intolerance, $$IntolerancesTableReferences),
      Intolerance,
      PrefetchHooks Function({bool userIntolerancesRefs})
    >;
typedef $$UserIntolerancesTableCreateCompanionBuilder =
    UserIntolerancesCompanion Function({
      Value<int> id,
      required int localUserId,
      Value<int?> intoleranceId,
      Value<String?> customName,
      Value<String> severity,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserIntolerancesTableUpdateCompanionBuilder =
    UserIntolerancesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int?> intoleranceId,
      Value<String?> customName,
      Value<String> severity,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserIntolerancesTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserIntolerancesTable, UserIntolerance> {
  $$UserIntolerancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IntolerancesTable _intoleranceIdTable(_$AppDatabase db) =>
      db.intolerances.createAlias(
        $_aliasNameGenerator(
          db.userIntolerances.intoleranceId,
          db.intolerances.id,
        ),
      );

  $$IntolerancesTableProcessedTableManager? get intoleranceId {
    final $_column = $_itemColumn<int>('intolerance_id');
    if ($_column == null) return null;
    final manager = $$IntolerancesTableTableManager(
      $_db,
      $_db.intolerances,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_intoleranceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserIntolerancesTableFilterComposer
    extends Composer<_$AppDatabase, $UserIntolerancesTable> {
  $$UserIntolerancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$IntolerancesTableFilterComposer get intoleranceId {
    final $$IntolerancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.intoleranceId,
      referencedTable: $db.intolerances,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IntolerancesTableFilterComposer(
            $db: $db,
            $table: $db.intolerances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserIntolerancesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserIntolerancesTable> {
  $$UserIntolerancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$IntolerancesTableOrderingComposer get intoleranceId {
    final $$IntolerancesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.intoleranceId,
      referencedTable: $db.intolerances,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IntolerancesTableOrderingComposer(
            $db: $db,
            $table: $db.intolerances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserIntolerancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserIntolerancesTable> {
  $$UserIntolerancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$IntolerancesTableAnnotationComposer get intoleranceId {
    final $$IntolerancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.intoleranceId,
      referencedTable: $db.intolerances,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IntolerancesTableAnnotationComposer(
            $db: $db,
            $table: $db.intolerances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserIntolerancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserIntolerancesTable,
          UserIntolerance,
          $$UserIntolerancesTableFilterComposer,
          $$UserIntolerancesTableOrderingComposer,
          $$UserIntolerancesTableAnnotationComposer,
          $$UserIntolerancesTableCreateCompanionBuilder,
          $$UserIntolerancesTableUpdateCompanionBuilder,
          (UserIntolerance, $$UserIntolerancesTableReferences),
          UserIntolerance,
          PrefetchHooks Function({bool intoleranceId})
        > {
  $$UserIntolerancesTableTableManager(
    _$AppDatabase db,
    $UserIntolerancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserIntolerancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserIntolerancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserIntolerancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int?> intoleranceId = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserIntolerancesCompanion(
                id: id,
                localUserId: localUserId,
                intoleranceId: intoleranceId,
                customName: customName,
                severity: severity,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                Value<int?> intoleranceId = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserIntolerancesCompanion.insert(
                id: id,
                localUserId: localUserId,
                intoleranceId: intoleranceId,
                customName: customName,
                severity: severity,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserIntolerancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({intoleranceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (intoleranceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.intoleranceId,
                                referencedTable:
                                    $$UserIntolerancesTableReferences
                                        ._intoleranceIdTable(db),
                                referencedColumn:
                                    $$UserIntolerancesTableReferences
                                        ._intoleranceIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserIntolerancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserIntolerancesTable,
      UserIntolerance,
      $$UserIntolerancesTableFilterComposer,
      $$UserIntolerancesTableOrderingComposer,
      $$UserIntolerancesTableAnnotationComposer,
      $$UserIntolerancesTableCreateCompanionBuilder,
      $$UserIntolerancesTableUpdateCompanionBuilder,
      (UserIntolerance, $$UserIntolerancesTableReferences),
      UserIntolerance,
      PrefetchHooks Function({bool intoleranceId})
    >;
typedef $$IngredientsTableCreateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      required String code,
      required String canonicalName,
      required String displayNameKey,
      required String category,
      Value<bool> isAnimalProduct,
      Value<bool> isMeat,
      Value<bool> isSeafood,
      Value<bool> isAlcoholRelated,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });
typedef $$IngredientsTableUpdateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      Value<String> code,
      Value<String> canonicalName,
      Value<String> displayNameKey,
      Value<String> category,
      Value<bool> isAnimalProduct,
      Value<bool> isMeat,
      Value<bool> isSeafood,
      Value<bool> isAlcoholRelated,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });

final class $$IngredientsTableReferences
    extends BaseReferences<_$AppDatabase, $IngredientsTable, Ingredient> {
  $$IngredientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IngredientsTable _parentIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias(
        $_aliasNameGenerator(db.ingredients.parentId, db.ingredients.id),
      );

  $$IngredientsTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $UserIngredientPreferencesTable,
    List<UserIngredientPreference>
  >
  _userIngredientPreferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userIngredientPreferences,
        aliasName: $_aliasNameGenerator(
          db.ingredients.id,
          db.userIngredientPreferences.ingredientId,
        ),
      );

  $$UserIngredientPreferencesTableProcessedTableManager
  get userIngredientPreferencesRefs {
    final manager = $$UserIngredientPreferencesTableTableManager(
      $_db,
      $_db.userIngredientPreferences,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userIngredientPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FoodItemIngredientsTable,
    List<FoodItemIngredient>
  >
  _foodItemIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.foodItemIngredients,
        aliasName: $_aliasNameGenerator(
          db.ingredients.id,
          db.foodItemIngredients.ingredientId,
        ),
      );

  $$FoodItemIngredientsTableProcessedTableManager get foodItemIngredientsRefs {
    final manager = $$FoodItemIngredientsTableTableManager(
      $_db,
      $_db.foodItemIngredients,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _foodItemIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAnimalProduct => $composableBuilder(
    column: $table.isAnimalProduct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMeat => $composableBuilder(
    column: $table.isMeat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSeafood => $composableBuilder(
    column: $table.isSeafood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAlcoholRelated => $composableBuilder(
    column: $table.isAlcoholRelated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientsTableFilterComposer get parentId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> userIngredientPreferencesRefs(
    Expression<bool> Function($$UserIngredientPreferencesTableFilterComposer f)
    f,
  ) {
    final $$UserIngredientPreferencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userIngredientPreferences,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserIngredientPreferencesTableFilterComposer(
                $db: $db,
                $table: $db.userIngredientPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> foodItemIngredientsRefs(
    Expression<bool> Function($$FoodItemIngredientsTableFilterComposer f) f,
  ) {
    final $$FoodItemIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItemIngredients,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.foodItemIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAnimalProduct => $composableBuilder(
    column: $table.isAnimalProduct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMeat => $composableBuilder(
    column: $table.isMeat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSeafood => $composableBuilder(
    column: $table.isSeafood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAlcoholRelated => $composableBuilder(
    column: $table.isAlcoholRelated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientsTableOrderingComposer get parentId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isAnimalProduct => $composableBuilder(
    column: $table.isAnimalProduct,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMeat =>
      $composableBuilder(column: $table.isMeat, builder: (column) => column);

  GeneratedColumn<bool> get isSeafood =>
      $composableBuilder(column: $table.isSeafood, builder: (column) => column);

  GeneratedColumn<bool> get isAlcoholRelated => $composableBuilder(
    column: $table.isAlcoholRelated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$IngredientsTableAnnotationComposer get parentId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> userIngredientPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserIngredientPreferencesTableAnnotationComposer a)
    f,
  ) {
    final $$UserIngredientPreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userIngredientPreferences,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserIngredientPreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.userIngredientPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> foodItemIngredientsRefs<T extends Object>(
    Expression<T> Function($$FoodItemIngredientsTableAnnotationComposer a) f,
  ) {
    final $$FoodItemIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.foodItemIngredients,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FoodItemIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.foodItemIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$IngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientsTable,
          Ingredient,
          $$IngredientsTableFilterComposer,
          $$IngredientsTableOrderingComposer,
          $$IngredientsTableAnnotationComposer,
          $$IngredientsTableCreateCompanionBuilder,
          $$IngredientsTableUpdateCompanionBuilder,
          (Ingredient, $$IngredientsTableReferences),
          Ingredient,
          PrefetchHooks Function({
            bool parentId,
            bool userIngredientPreferencesRefs,
            bool foodItemIngredientsRefs,
          })
        > {
  $$IngredientsTableTableManager(_$AppDatabase db, $IngredientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> canonicalName = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isAnimalProduct = const Value.absent(),
                Value<bool> isMeat = const Value.absent(),
                Value<bool> isSeafood = const Value.absent(),
                Value<bool> isAlcoholRelated = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => IngredientsCompanion(
                id: id,
                parentId: parentId,
                code: code,
                canonicalName: canonicalName,
                displayNameKey: displayNameKey,
                category: category,
                isAnimalProduct: isAnimalProduct,
                isMeat: isMeat,
                isSeafood: isSeafood,
                isAlcoholRelated: isAlcoholRelated,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                required String code,
                required String canonicalName,
                required String displayNameKey,
                required String category,
                Value<bool> isAnimalProduct = const Value.absent(),
                Value<bool> isMeat = const Value.absent(),
                Value<bool> isSeafood = const Value.absent(),
                Value<bool> isAlcoholRelated = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => IngredientsCompanion.insert(
                id: id,
                parentId: parentId,
                code: code,
                canonicalName: canonicalName,
                displayNameKey: displayNameKey,
                category: category,
                isAnimalProduct: isAnimalProduct,
                isMeat: isMeat,
                isSeafood: isSeafood,
                isAlcoholRelated: isAlcoholRelated,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                parentId = false,
                userIngredientPreferencesRefs = false,
                foodItemIngredientsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userIngredientPreferencesRefs)
                      db.userIngredientPreferences,
                    if (foodItemIngredientsRefs) db.foodItemIngredients,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentId,
                                    referencedTable:
                                        $$IngredientsTableReferences
                                            ._parentIdTable(db),
                                    referencedColumn:
                                        $$IngredientsTableReferences
                                            ._parentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userIngredientPreferencesRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          UserIngredientPreference
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._userIngredientPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).userIngredientPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (foodItemIngredientsRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          FoodItemIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._foodItemIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).foodItemIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientsTable,
      Ingredient,
      $$IngredientsTableFilterComposer,
      $$IngredientsTableOrderingComposer,
      $$IngredientsTableAnnotationComposer,
      $$IngredientsTableCreateCompanionBuilder,
      $$IngredientsTableUpdateCompanionBuilder,
      (Ingredient, $$IngredientsTableReferences),
      Ingredient,
      PrefetchHooks Function({
        bool parentId,
        bool userIngredientPreferencesRefs,
        bool foodItemIngredientsRefs,
      })
    >;
typedef $$UserIngredientPreferencesTableCreateCompanionBuilder =
    UserIngredientPreferencesCompanion Function({
      Value<int> id,
      required int localUserId,
      required int ingredientId,
      Value<String> preferenceState,
      Value<String> restrictionType,
      Value<String> source,
      Value<double> confidence,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserIngredientPreferencesTableUpdateCompanionBuilder =
    UserIngredientPreferencesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int> ingredientId,
      Value<String> preferenceState,
      Value<String> restrictionType,
      Value<String> source,
      Value<double> confidence,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserIngredientPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserIngredientPreferencesTable,
          UserIngredientPreference
        > {
  $$UserIngredientPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias(
        $_aliasNameGenerator(
          db.userIngredientPreferences.ingredientId,
          db.ingredients.id,
        ),
      );

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserIngredientPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserIngredientPreferencesTable> {
  $$UserIngredientPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restrictionType => $composableBuilder(
    column: $table.restrictionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserIngredientPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserIngredientPreferencesTable> {
  $$UserIngredientPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restrictionType => $composableBuilder(
    column: $table.restrictionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserIngredientPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserIngredientPreferencesTable> {
  $$UserIngredientPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restrictionType => $composableBuilder(
    column: $table.restrictionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserIngredientPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserIngredientPreferencesTable,
          UserIngredientPreference,
          $$UserIngredientPreferencesTableFilterComposer,
          $$UserIngredientPreferencesTableOrderingComposer,
          $$UserIngredientPreferencesTableAnnotationComposer,
          $$UserIngredientPreferencesTableCreateCompanionBuilder,
          $$UserIngredientPreferencesTableUpdateCompanionBuilder,
          (
            UserIngredientPreference,
            $$UserIngredientPreferencesTableReferences,
          ),
          UserIngredientPreference,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$UserIngredientPreferencesTableTableManager(
    _$AppDatabase db,
    $UserIngredientPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserIngredientPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserIngredientPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserIngredientPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> preferenceState = const Value.absent(),
                Value<String> restrictionType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserIngredientPreferencesCompanion(
                id: id,
                localUserId: localUserId,
                ingredientId: ingredientId,
                preferenceState: preferenceState,
                restrictionType: restrictionType,
                source: source,
                confidence: confidence,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required int ingredientId,
                Value<String> preferenceState = const Value.absent(),
                Value<String> restrictionType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserIngredientPreferencesCompanion.insert(
                id: id,
                localUserId: localUserId,
                ingredientId: ingredientId,
                preferenceState: preferenceState,
                restrictionType: restrictionType,
                source: source,
                confidence: confidence,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserIngredientPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable:
                                    $$UserIngredientPreferencesTableReferences
                                        ._ingredientIdTable(db),
                                referencedColumn:
                                    $$UserIngredientPreferencesTableReferences
                                        ._ingredientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserIngredientPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserIngredientPreferencesTable,
      UserIngredientPreference,
      $$UserIngredientPreferencesTableFilterComposer,
      $$UserIngredientPreferencesTableOrderingComposer,
      $$UserIngredientPreferencesTableAnnotationComposer,
      $$UserIngredientPreferencesTableCreateCompanionBuilder,
      $$UserIngredientPreferencesTableUpdateCompanionBuilder,
      (UserIngredientPreference, $$UserIngredientPreferencesTableReferences),
      UserIngredientPreference,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$CuisinesTableCreateCompanionBuilder =
    CuisinesCompanion Function({
      Value<int> id,
      required String code,
      required String displayNameKey,
      Value<String?> region,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });
typedef $$CuisinesTableUpdateCompanionBuilder =
    CuisinesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> displayNameKey,
      Value<String?> region,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
    });

final class $$CuisinesTableReferences
    extends BaseReferences<_$AppDatabase, $CuisinesTable, Cuisine> {
  $$CuisinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $UserCuisinePreferencesTable,
    List<UserCuisinePreference>
  >
  _userCuisinePreferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userCuisinePreferences,
        aliasName: $_aliasNameGenerator(
          db.cuisines.id,
          db.userCuisinePreferences.cuisineId,
        ),
      );

  $$UserCuisinePreferencesTableProcessedTableManager
  get userCuisinePreferencesRefs {
    final manager = $$UserCuisinePreferencesTableTableManager(
      $_db,
      $_db.userCuisinePreferences,
    ).filter((f) => f.cuisineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userCuisinePreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FoodItemsTable, List<FoodItem>>
  _foodItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.foodItems,
    aliasName: $_aliasNameGenerator(db.cuisines.id, db.foodItems.cuisineId),
  );

  $$FoodItemsTableProcessedTableManager get foodItemsRefs {
    final manager = $$FoodItemsTableTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.cuisineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_foodItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CuisinesTableFilterComposer
    extends Composer<_$AppDatabase, $CuisinesTable> {
  $$CuisinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userCuisinePreferencesRefs(
    Expression<bool> Function($$UserCuisinePreferencesTableFilterComposer f) f,
  ) {
    final $$UserCuisinePreferencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userCuisinePreferences,
          getReferencedColumn: (t) => t.cuisineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserCuisinePreferencesTableFilterComposer(
                $db: $db,
                $table: $db.userCuisinePreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> foodItemsRefs(
    Expression<bool> Function($$FoodItemsTableFilterComposer f) f,
  ) {
    final $$FoodItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.cuisineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CuisinesTableOrderingComposer
    extends Composer<_$AppDatabase, $CuisinesTable> {
  $$CuisinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CuisinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CuisinesTable> {
  $$CuisinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userCuisinePreferencesRefs<T extends Object>(
    Expression<T> Function($$UserCuisinePreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserCuisinePreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userCuisinePreferences,
          getReferencedColumn: (t) => t.cuisineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserCuisinePreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.userCuisinePreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> foodItemsRefs<T extends Object>(
    Expression<T> Function($$FoodItemsTableAnnotationComposer a) f,
  ) {
    final $$FoodItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.cuisineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CuisinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CuisinesTable,
          Cuisine,
          $$CuisinesTableFilterComposer,
          $$CuisinesTableOrderingComposer,
          $$CuisinesTableAnnotationComposer,
          $$CuisinesTableCreateCompanionBuilder,
          $$CuisinesTableUpdateCompanionBuilder,
          (Cuisine, $$CuisinesTableReferences),
          Cuisine,
          PrefetchHooks Function({
            bool userCuisinePreferencesRefs,
            bool foodItemsRefs,
          })
        > {
  $$CuisinesTableTableManager(_$AppDatabase db, $CuisinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CuisinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CuisinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CuisinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CuisinesCompanion(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                region: region,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String displayNameKey,
                Value<String?> region = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CuisinesCompanion.insert(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                region: region,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CuisinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userCuisinePreferencesRefs = false, foodItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userCuisinePreferencesRefs) db.userCuisinePreferences,
                    if (foodItemsRefs) db.foodItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userCuisinePreferencesRefs)
                        await $_getPrefetchedData<
                          Cuisine,
                          $CuisinesTable,
                          UserCuisinePreference
                        >(
                          currentTable: table,
                          referencedTable: $$CuisinesTableReferences
                              ._userCuisinePreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CuisinesTableReferences(
                                db,
                                table,
                                p0,
                              ).userCuisinePreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cuisineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (foodItemsRefs)
                        await $_getPrefetchedData<
                          Cuisine,
                          $CuisinesTable,
                          FoodItem
                        >(
                          currentTable: table,
                          referencedTable: $$CuisinesTableReferences
                              ._foodItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CuisinesTableReferences(
                                db,
                                table,
                                p0,
                              ).foodItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cuisineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CuisinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CuisinesTable,
      Cuisine,
      $$CuisinesTableFilterComposer,
      $$CuisinesTableOrderingComposer,
      $$CuisinesTableAnnotationComposer,
      $$CuisinesTableCreateCompanionBuilder,
      $$CuisinesTableUpdateCompanionBuilder,
      (Cuisine, $$CuisinesTableReferences),
      Cuisine,
      PrefetchHooks Function({
        bool userCuisinePreferencesRefs,
        bool foodItemsRefs,
      })
    >;
typedef $$UserCuisinePreferencesTableCreateCompanionBuilder =
    UserCuisinePreferencesCompanion Function({
      Value<int> id,
      required int localUserId,
      required int cuisineId,
      Value<String> preferenceState,
      Value<double?> curiosityScore,
      Value<String> source,
      Value<double> confidence,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserCuisinePreferencesTableUpdateCompanionBuilder =
    UserCuisinePreferencesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int> cuisineId,
      Value<String> preferenceState,
      Value<double?> curiosityScore,
      Value<String> source,
      Value<double> confidence,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserCuisinePreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserCuisinePreferencesTable,
          UserCuisinePreference
        > {
  $$UserCuisinePreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CuisinesTable _cuisineIdTable(_$AppDatabase db) =>
      db.cuisines.createAlias(
        $_aliasNameGenerator(
          db.userCuisinePreferences.cuisineId,
          db.cuisines.id,
        ),
      );

  $$CuisinesTableProcessedTableManager get cuisineId {
    final $_column = $_itemColumn<int>('cuisine_id')!;

    final manager = $$CuisinesTableTableManager(
      $_db,
      $_db.cuisines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cuisineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserCuisinePreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserCuisinePreferencesTable> {
  $$UserCuisinePreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get curiosityScore => $composableBuilder(
    column: $table.curiosityScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CuisinesTableFilterComposer get cuisineId {
    final $$CuisinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuisineId,
      referencedTable: $db.cuisines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuisinesTableFilterComposer(
            $db: $db,
            $table: $db.cuisines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserCuisinePreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserCuisinePreferencesTable> {
  $$UserCuisinePreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get curiosityScore => $composableBuilder(
    column: $table.curiosityScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CuisinesTableOrderingComposer get cuisineId {
    final $$CuisinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuisineId,
      referencedTable: $db.cuisines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuisinesTableOrderingComposer(
            $db: $db,
            $table: $db.cuisines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserCuisinePreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserCuisinePreferencesTable> {
  $$UserCuisinePreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => column,
  );

  GeneratedColumn<double> get curiosityScore => $composableBuilder(
    column: $table.curiosityScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CuisinesTableAnnotationComposer get cuisineId {
    final $$CuisinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuisineId,
      referencedTable: $db.cuisines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuisinesTableAnnotationComposer(
            $db: $db,
            $table: $db.cuisines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserCuisinePreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserCuisinePreferencesTable,
          UserCuisinePreference,
          $$UserCuisinePreferencesTableFilterComposer,
          $$UserCuisinePreferencesTableOrderingComposer,
          $$UserCuisinePreferencesTableAnnotationComposer,
          $$UserCuisinePreferencesTableCreateCompanionBuilder,
          $$UserCuisinePreferencesTableUpdateCompanionBuilder,
          (UserCuisinePreference, $$UserCuisinePreferencesTableReferences),
          UserCuisinePreference,
          PrefetchHooks Function({bool cuisineId})
        > {
  $$UserCuisinePreferencesTableTableManager(
    _$AppDatabase db,
    $UserCuisinePreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCuisinePreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserCuisinePreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserCuisinePreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int> cuisineId = const Value.absent(),
                Value<String> preferenceState = const Value.absent(),
                Value<double?> curiosityScore = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserCuisinePreferencesCompanion(
                id: id,
                localUserId: localUserId,
                cuisineId: cuisineId,
                preferenceState: preferenceState,
                curiosityScore: curiosityScore,
                source: source,
                confidence: confidence,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required int cuisineId,
                Value<String> preferenceState = const Value.absent(),
                Value<double?> curiosityScore = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserCuisinePreferencesCompanion.insert(
                id: id,
                localUserId: localUserId,
                cuisineId: cuisineId,
                preferenceState: preferenceState,
                curiosityScore: curiosityScore,
                source: source,
                confidence: confidence,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserCuisinePreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cuisineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cuisineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cuisineId,
                                referencedTable:
                                    $$UserCuisinePreferencesTableReferences
                                        ._cuisineIdTable(db),
                                referencedColumn:
                                    $$UserCuisinePreferencesTableReferences
                                        ._cuisineIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserCuisinePreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserCuisinePreferencesTable,
      UserCuisinePreference,
      $$UserCuisinePreferencesTableFilterComposer,
      $$UserCuisinePreferencesTableOrderingComposer,
      $$UserCuisinePreferencesTableAnnotationComposer,
      $$UserCuisinePreferencesTableCreateCompanionBuilder,
      $$UserCuisinePreferencesTableUpdateCompanionBuilder,
      (UserCuisinePreference, $$UserCuisinePreferencesTableReferences),
      UserCuisinePreference,
      PrefetchHooks Function({bool cuisineId})
    >;
typedef $$FlavorAttributesTableCreateCompanionBuilder =
    FlavorAttributesCompanion Function({
      Value<int> id,
      required String code,
      required String displayNameKey,
      Value<bool> isBuiltIn,
    });
typedef $$FlavorAttributesTableUpdateCompanionBuilder =
    FlavorAttributesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> displayNameKey,
      Value<bool> isBuiltIn,
    });

final class $$FlavorAttributesTableReferences
    extends
        BaseReferences<_$AppDatabase, $FlavorAttributesTable, FlavorAttribute> {
  $$FlavorAttributesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $UserFlavorPreferencesTable,
    List<UserFlavorPreference>
  >
  _userFlavorPreferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userFlavorPreferences,
        aliasName: $_aliasNameGenerator(
          db.flavorAttributes.id,
          db.userFlavorPreferences.flavorAttributeId,
        ),
      );

  $$UserFlavorPreferencesTableProcessedTableManager
  get userFlavorPreferencesRefs {
    final manager = $$UserFlavorPreferencesTableTableManager(
      $_db,
      $_db.userFlavorPreferences,
    ).filter((f) => f.flavorAttributeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userFlavorPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FlavorAttributesTableFilterComposer
    extends Composer<_$AppDatabase, $FlavorAttributesTable> {
  $$FlavorAttributesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userFlavorPreferencesRefs(
    Expression<bool> Function($$UserFlavorPreferencesTableFilterComposer f) f,
  ) {
    final $$UserFlavorPreferencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userFlavorPreferences,
          getReferencedColumn: (t) => t.flavorAttributeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserFlavorPreferencesTableFilterComposer(
                $db: $db,
                $table: $db.userFlavorPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FlavorAttributesTableOrderingComposer
    extends Composer<_$AppDatabase, $FlavorAttributesTable> {
  $$FlavorAttributesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FlavorAttributesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlavorAttributesTable> {
  $$FlavorAttributesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  Expression<T> userFlavorPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserFlavorPreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserFlavorPreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userFlavorPreferences,
          getReferencedColumn: (t) => t.flavorAttributeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserFlavorPreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.userFlavorPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FlavorAttributesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlavorAttributesTable,
          FlavorAttribute,
          $$FlavorAttributesTableFilterComposer,
          $$FlavorAttributesTableOrderingComposer,
          $$FlavorAttributesTableAnnotationComposer,
          $$FlavorAttributesTableCreateCompanionBuilder,
          $$FlavorAttributesTableUpdateCompanionBuilder,
          (FlavorAttribute, $$FlavorAttributesTableReferences),
          FlavorAttribute,
          PrefetchHooks Function({bool userFlavorPreferencesRefs})
        > {
  $$FlavorAttributesTableTableManager(
    _$AppDatabase db,
    $FlavorAttributesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlavorAttributesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlavorAttributesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlavorAttributesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
              }) => FlavorAttributesCompanion(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                isBuiltIn: isBuiltIn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String displayNameKey,
                Value<bool> isBuiltIn = const Value.absent(),
              }) => FlavorAttributesCompanion.insert(
                id: id,
                code: code,
                displayNameKey: displayNameKey,
                isBuiltIn: isBuiltIn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FlavorAttributesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userFlavorPreferencesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userFlavorPreferencesRefs) db.userFlavorPreferences,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userFlavorPreferencesRefs)
                    await $_getPrefetchedData<
                      FlavorAttribute,
                      $FlavorAttributesTable,
                      UserFlavorPreference
                    >(
                      currentTable: table,
                      referencedTable: $$FlavorAttributesTableReferences
                          ._userFlavorPreferencesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FlavorAttributesTableReferences(
                            db,
                            table,
                            p0,
                          ).userFlavorPreferencesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.flavorAttributeId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FlavorAttributesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlavorAttributesTable,
      FlavorAttribute,
      $$FlavorAttributesTableFilterComposer,
      $$FlavorAttributesTableOrderingComposer,
      $$FlavorAttributesTableAnnotationComposer,
      $$FlavorAttributesTableCreateCompanionBuilder,
      $$FlavorAttributesTableUpdateCompanionBuilder,
      (FlavorAttribute, $$FlavorAttributesTableReferences),
      FlavorAttribute,
      PrefetchHooks Function({bool userFlavorPreferencesRefs})
    >;
typedef $$UserFlavorPreferencesTableCreateCompanionBuilder =
    UserFlavorPreferencesCompanion Function({
      Value<int> id,
      required int localUserId,
      required int flavorAttributeId,
      Value<int> preferenceLevel,
      Value<String> source,
      Value<DateTime> updatedAt,
    });
typedef $$UserFlavorPreferencesTableUpdateCompanionBuilder =
    UserFlavorPreferencesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int> flavorAttributeId,
      Value<int> preferenceLevel,
      Value<String> source,
      Value<DateTime> updatedAt,
    });

final class $$UserFlavorPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserFlavorPreferencesTable,
          UserFlavorPreference
        > {
  $$UserFlavorPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FlavorAttributesTable _flavorAttributeIdTable(_$AppDatabase db) =>
      db.flavorAttributes.createAlias(
        $_aliasNameGenerator(
          db.userFlavorPreferences.flavorAttributeId,
          db.flavorAttributes.id,
        ),
      );

  $$FlavorAttributesTableProcessedTableManager get flavorAttributeId {
    final $_column = $_itemColumn<int>('flavor_attribute_id')!;

    final manager = $$FlavorAttributesTableTableManager(
      $_db,
      $_db.flavorAttributes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_flavorAttributeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserFlavorPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserFlavorPreferencesTable> {
  $$UserFlavorPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferenceLevel => $composableBuilder(
    column: $table.preferenceLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FlavorAttributesTableFilterComposer get flavorAttributeId {
    final $$FlavorAttributesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.flavorAttributeId,
      referencedTable: $db.flavorAttributes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlavorAttributesTableFilterComposer(
            $db: $db,
            $table: $db.flavorAttributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFlavorPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFlavorPreferencesTable> {
  $$UserFlavorPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferenceLevel => $composableBuilder(
    column: $table.preferenceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FlavorAttributesTableOrderingComposer get flavorAttributeId {
    final $$FlavorAttributesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.flavorAttributeId,
      referencedTable: $db.flavorAttributes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlavorAttributesTableOrderingComposer(
            $db: $db,
            $table: $db.flavorAttributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFlavorPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFlavorPreferencesTable> {
  $$UserFlavorPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preferenceLevel => $composableBuilder(
    column: $table.preferenceLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FlavorAttributesTableAnnotationComposer get flavorAttributeId {
    final $$FlavorAttributesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.flavorAttributeId,
      referencedTable: $db.flavorAttributes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlavorAttributesTableAnnotationComposer(
            $db: $db,
            $table: $db.flavorAttributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFlavorPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserFlavorPreferencesTable,
          UserFlavorPreference,
          $$UserFlavorPreferencesTableFilterComposer,
          $$UserFlavorPreferencesTableOrderingComposer,
          $$UserFlavorPreferencesTableAnnotationComposer,
          $$UserFlavorPreferencesTableCreateCompanionBuilder,
          $$UserFlavorPreferencesTableUpdateCompanionBuilder,
          (UserFlavorPreference, $$UserFlavorPreferencesTableReferences),
          UserFlavorPreference,
          PrefetchHooks Function({bool flavorAttributeId})
        > {
  $$UserFlavorPreferencesTableTableManager(
    _$AppDatabase db,
    $UserFlavorPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFlavorPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserFlavorPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserFlavorPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int> flavorAttributeId = const Value.absent(),
                Value<int> preferenceLevel = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserFlavorPreferencesCompanion(
                id: id,
                localUserId: localUserId,
                flavorAttributeId: flavorAttributeId,
                preferenceLevel: preferenceLevel,
                source: source,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required int flavorAttributeId,
                Value<int> preferenceLevel = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserFlavorPreferencesCompanion.insert(
                id: id,
                localUserId: localUserId,
                flavorAttributeId: flavorAttributeId,
                preferenceLevel: preferenceLevel,
                source: source,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserFlavorPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({flavorAttributeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (flavorAttributeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.flavorAttributeId,
                                referencedTable:
                                    $$UserFlavorPreferencesTableReferences
                                        ._flavorAttributeIdTable(db),
                                referencedColumn:
                                    $$UserFlavorPreferencesTableReferences
                                        ._flavorAttributeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserFlavorPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserFlavorPreferencesTable,
      UserFlavorPreference,
      $$UserFlavorPreferencesTableFilterComposer,
      $$UserFlavorPreferencesTableOrderingComposer,
      $$UserFlavorPreferencesTableAnnotationComposer,
      $$UserFlavorPreferencesTableCreateCompanionBuilder,
      $$UserFlavorPreferencesTableUpdateCompanionBuilder,
      (UserFlavorPreference, $$UserFlavorPreferencesTableReferences),
      UserFlavorPreference,
      PrefetchHooks Function({bool flavorAttributeId})
    >;
typedef $$FoodItemsTableCreateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      required String canonicalName,
      required String displayNameKey,
      Value<int?> cuisineId,
      Value<String?> localImageAsset,
      Value<String?> descriptionKey,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$FoodItemsTableUpdateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      Value<String> canonicalName,
      Value<String> displayNameKey,
      Value<int?> cuisineId,
      Value<String?> localImageAsset,
      Value<String?> descriptionKey,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$FoodItemsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem> {
  $$FoodItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CuisinesTable _cuisineIdTable(_$AppDatabase db) =>
      db.cuisines.createAlias(
        $_aliasNameGenerator(db.foodItems.cuisineId, db.cuisines.id),
      );

  $$CuisinesTableProcessedTableManager? get cuisineId {
    final $_column = $_itemColumn<int>('cuisine_id');
    if ($_column == null) return null;
    final manager = $$CuisinesTableTableManager(
      $_db,
      $_db.cuisines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cuisineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $FoodItemIngredientsTable,
    List<FoodItemIngredient>
  >
  _foodItemIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.foodItemIngredients,
        aliasName: $_aliasNameGenerator(
          db.foodItems.id,
          db.foodItemIngredients.foodItemId,
        ),
      );

  $$FoodItemIngredientsTableProcessedTableManager get foodItemIngredientsRefs {
    final manager = $$FoodItemIngredientsTableTableManager(
      $_db,
      $_db.foodItemIngredients,
    ).filter((f) => f.foodItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _foodItemIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FoodItemAllergensTable, List<FoodItemAllergen>>
  _foodItemAllergensRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.foodItemAllergens,
        aliasName: $_aliasNameGenerator(
          db.foodItems.id,
          db.foodItemAllergens.foodItemId,
        ),
      );

  $$FoodItemAllergensTableProcessedTableManager get foodItemAllergensRefs {
    final manager = $$FoodItemAllergensTableTableManager(
      $_db,
      $_db.foodItemAllergens,
    ).filter((f) => f.foodItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _foodItemAllergensRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UserFoodItemPreferencesTable,
    List<UserFoodItemPreference>
  >
  _userFoodItemPreferencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userFoodItemPreferences,
        aliasName: $_aliasNameGenerator(
          db.foodItems.id,
          db.userFoodItemPreferences.foodItemId,
        ),
      );

  $$UserFoodItemPreferencesTableProcessedTableManager
  get userFoodItemPreferencesRefs {
    final manager = $$UserFoodItemPreferencesTableTableManager(
      $_db,
      $_db.userFoodItemPreferences,
    ).filter((f) => f.foodItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userFoodItemPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoodItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImageAsset => $composableBuilder(
    column: $table.localImageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionKey => $composableBuilder(
    column: $table.descriptionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CuisinesTableFilterComposer get cuisineId {
    final $$CuisinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuisineId,
      referencedTable: $db.cuisines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuisinesTableFilterComposer(
            $db: $db,
            $table: $db.cuisines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> foodItemIngredientsRefs(
    Expression<bool> Function($$FoodItemIngredientsTableFilterComposer f) f,
  ) {
    final $$FoodItemIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItemIngredients,
      getReferencedColumn: (t) => t.foodItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.foodItemIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> foodItemAllergensRefs(
    Expression<bool> Function($$FoodItemAllergensTableFilterComposer f) f,
  ) {
    final $$FoodItemAllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItemAllergens,
      getReferencedColumn: (t) => t.foodItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemAllergensTableFilterComposer(
            $db: $db,
            $table: $db.foodItemAllergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userFoodItemPreferencesRefs(
    Expression<bool> Function($$UserFoodItemPreferencesTableFilterComposer f) f,
  ) {
    final $$UserFoodItemPreferencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userFoodItemPreferences,
          getReferencedColumn: (t) => t.foodItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserFoodItemPreferencesTableFilterComposer(
                $db: $db,
                $table: $db.userFoodItemPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FoodItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImageAsset => $composableBuilder(
    column: $table.localImageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionKey => $composableBuilder(
    column: $table.descriptionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CuisinesTableOrderingComposer get cuisineId {
    final $$CuisinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuisineId,
      referencedTable: $db.cuisines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuisinesTableOrderingComposer(
            $db: $db,
            $table: $db.cuisines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayNameKey => $composableBuilder(
    column: $table.displayNameKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localImageAsset => $composableBuilder(
    column: $table.localImageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionKey => $composableBuilder(
    column: $table.descriptionKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CuisinesTableAnnotationComposer get cuisineId {
    final $$CuisinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuisineId,
      referencedTable: $db.cuisines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuisinesTableAnnotationComposer(
            $db: $db,
            $table: $db.cuisines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> foodItemIngredientsRefs<T extends Object>(
    Expression<T> Function($$FoodItemIngredientsTableAnnotationComposer a) f,
  ) {
    final $$FoodItemIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.foodItemIngredients,
          getReferencedColumn: (t) => t.foodItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FoodItemIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.foodItemIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> foodItemAllergensRefs<T extends Object>(
    Expression<T> Function($$FoodItemAllergensTableAnnotationComposer a) f,
  ) {
    final $$FoodItemAllergensTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.foodItemAllergens,
          getReferencedColumn: (t) => t.foodItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FoodItemAllergensTableAnnotationComposer(
                $db: $db,
                $table: $db.foodItemAllergens,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> userFoodItemPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserFoodItemPreferencesTableAnnotationComposer a)
    f,
  ) {
    final $$UserFoodItemPreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userFoodItemPreferences,
          getReferencedColumn: (t) => t.foodItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserFoodItemPreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.userFoodItemPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FoodItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsTable,
          FoodItem,
          $$FoodItemsTableFilterComposer,
          $$FoodItemsTableOrderingComposer,
          $$FoodItemsTableAnnotationComposer,
          $$FoodItemsTableCreateCompanionBuilder,
          $$FoodItemsTableUpdateCompanionBuilder,
          (FoodItem, $$FoodItemsTableReferences),
          FoodItem,
          PrefetchHooks Function({
            bool cuisineId,
            bool foodItemIngredientsRefs,
            bool foodItemAllergensRefs,
            bool userFoodItemPreferencesRefs,
          })
        > {
  $$FoodItemsTableTableManager(_$AppDatabase db, $FoodItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> canonicalName = const Value.absent(),
                Value<String> displayNameKey = const Value.absent(),
                Value<int?> cuisineId = const Value.absent(),
                Value<String?> localImageAsset = const Value.absent(),
                Value<String?> descriptionKey = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                canonicalName: canonicalName,
                displayNameKey: displayNameKey,
                cuisineId: cuisineId,
                localImageAsset: localImageAsset,
                descriptionKey: descriptionKey,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String canonicalName,
                required String displayNameKey,
                Value<int?> cuisineId = const Value.absent(),
                Value<String?> localImageAsset = const Value.absent(),
                Value<String?> descriptionKey = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FoodItemsCompanion.insert(
                id: id,
                canonicalName: canonicalName,
                displayNameKey: displayNameKey,
                cuisineId: cuisineId,
                localImageAsset: localImageAsset,
                descriptionKey: descriptionKey,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                cuisineId = false,
                foodItemIngredientsRefs = false,
                foodItemAllergensRefs = false,
                userFoodItemPreferencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (foodItemIngredientsRefs) db.foodItemIngredients,
                    if (foodItemAllergensRefs) db.foodItemAllergens,
                    if (userFoodItemPreferencesRefs) db.userFoodItemPreferences,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (cuisineId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.cuisineId,
                                    referencedTable: $$FoodItemsTableReferences
                                        ._cuisineIdTable(db),
                                    referencedColumn: $$FoodItemsTableReferences
                                        ._cuisineIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (foodItemIngredientsRefs)
                        await $_getPrefetchedData<
                          FoodItem,
                          $FoodItemsTable,
                          FoodItemIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$FoodItemsTableReferences
                              ._foodItemIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).foodItemIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (foodItemAllergensRefs)
                        await $_getPrefetchedData<
                          FoodItem,
                          $FoodItemsTable,
                          FoodItemAllergen
                        >(
                          currentTable: table,
                          referencedTable: $$FoodItemsTableReferences
                              ._foodItemAllergensRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).foodItemAllergensRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userFoodItemPreferencesRefs)
                        await $_getPrefetchedData<
                          FoodItem,
                          $FoodItemsTable,
                          UserFoodItemPreference
                        >(
                          currentTable: table,
                          referencedTable: $$FoodItemsTableReferences
                              ._userFoodItemPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).userFoodItemPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FoodItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsTable,
      FoodItem,
      $$FoodItemsTableFilterComposer,
      $$FoodItemsTableOrderingComposer,
      $$FoodItemsTableAnnotationComposer,
      $$FoodItemsTableCreateCompanionBuilder,
      $$FoodItemsTableUpdateCompanionBuilder,
      (FoodItem, $$FoodItemsTableReferences),
      FoodItem,
      PrefetchHooks Function({
        bool cuisineId,
        bool foodItemIngredientsRefs,
        bool foodItemAllergensRefs,
        bool userFoodItemPreferencesRefs,
      })
    >;
typedef $$FoodItemIngredientsTableCreateCompanionBuilder =
    FoodItemIngredientsCompanion Function({
      Value<int> id,
      required int foodItemId,
      required int ingredientId,
      Value<bool> isPrimary,
      Value<bool> mayContain,
      Value<DateTime> createdAt,
    });
typedef $$FoodItemIngredientsTableUpdateCompanionBuilder =
    FoodItemIngredientsCompanion Function({
      Value<int> id,
      Value<int> foodItemId,
      Value<int> ingredientId,
      Value<bool> isPrimary,
      Value<bool> mayContain,
      Value<DateTime> createdAt,
    });

final class $$FoodItemIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FoodItemIngredientsTable,
          FoodItemIngredient
        > {
  $$FoodItemIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodItemsTable _foodItemIdTable(_$AppDatabase db) =>
      db.foodItems.createAlias(
        $_aliasNameGenerator(
          db.foodItemIngredients.foodItemId,
          db.foodItems.id,
        ),
      );

  $$FoodItemsTableProcessedTableManager get foodItemId {
    final $_column = $_itemColumn<int>('food_item_id')!;

    final manager = $$FoodItemsTableTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias(
        $_aliasNameGenerator(
          db.foodItemIngredients.ingredientId,
          db.ingredients.id,
        ),
      );

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FoodItemIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemIngredientsTable> {
  $$FoodItemIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mayContain => $composableBuilder(
    column: $table.mayContain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodItemsTableFilterComposer get foodItemId {
    final $$FoodItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemIngredientsTable> {
  $$FoodItemIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mayContain => $composableBuilder(
    column: $table.mayContain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodItemsTableOrderingComposer get foodItemId {
    final $$FoodItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableOrderingComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemIngredientsTable> {
  $$FoodItemIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<bool> get mayContain => $composableBuilder(
    column: $table.mayContain,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FoodItemsTableAnnotationComposer get foodItemId {
    final $$FoodItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemIngredientsTable,
          FoodItemIngredient,
          $$FoodItemIngredientsTableFilterComposer,
          $$FoodItemIngredientsTableOrderingComposer,
          $$FoodItemIngredientsTableAnnotationComposer,
          $$FoodItemIngredientsTableCreateCompanionBuilder,
          $$FoodItemIngredientsTableUpdateCompanionBuilder,
          (FoodItemIngredient, $$FoodItemIngredientsTableReferences),
          FoodItemIngredient,
          PrefetchHooks Function({bool foodItemId, bool ingredientId})
        > {
  $$FoodItemIngredientsTableTableManager(
    _$AppDatabase db,
    $FoodItemIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemIngredientsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FoodItemIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> foodItemId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<bool> mayContain = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodItemIngredientsCompanion(
                id: id,
                foodItemId: foodItemId,
                ingredientId: ingredientId,
                isPrimary: isPrimary,
                mayContain: mayContain,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int foodItemId,
                required int ingredientId,
                Value<bool> isPrimary = const Value.absent(),
                Value<bool> mayContain = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodItemIngredientsCompanion.insert(
                id: id,
                foodItemId: foodItemId,
                ingredientId: ingredientId,
                isPrimary: isPrimary,
                mayContain: mayContain,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodItemIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodItemId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodItemId,
                                referencedTable:
                                    $$FoodItemIngredientsTableReferences
                                        ._foodItemIdTable(db),
                                referencedColumn:
                                    $$FoodItemIngredientsTableReferences
                                        ._foodItemIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable:
                                    $$FoodItemIngredientsTableReferences
                                        ._ingredientIdTable(db),
                                referencedColumn:
                                    $$FoodItemIngredientsTableReferences
                                        ._ingredientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FoodItemIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemIngredientsTable,
      FoodItemIngredient,
      $$FoodItemIngredientsTableFilterComposer,
      $$FoodItemIngredientsTableOrderingComposer,
      $$FoodItemIngredientsTableAnnotationComposer,
      $$FoodItemIngredientsTableCreateCompanionBuilder,
      $$FoodItemIngredientsTableUpdateCompanionBuilder,
      (FoodItemIngredient, $$FoodItemIngredientsTableReferences),
      FoodItemIngredient,
      PrefetchHooks Function({bool foodItemId, bool ingredientId})
    >;
typedef $$FoodItemAllergensTableCreateCompanionBuilder =
    FoodItemAllergensCompanion Function({
      Value<int> id,
      required int foodItemId,
      required int allergenId,
      Value<String> relationType,
      Value<DateTime> createdAt,
    });
typedef $$FoodItemAllergensTableUpdateCompanionBuilder =
    FoodItemAllergensCompanion Function({
      Value<int> id,
      Value<int> foodItemId,
      Value<int> allergenId,
      Value<String> relationType,
      Value<DateTime> createdAt,
    });

final class $$FoodItemAllergensTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FoodItemAllergensTable,
          FoodItemAllergen
        > {
  $$FoodItemAllergensTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodItemsTable _foodItemIdTable(_$AppDatabase db) =>
      db.foodItems.createAlias(
        $_aliasNameGenerator(db.foodItemAllergens.foodItemId, db.foodItems.id),
      );

  $$FoodItemsTableProcessedTableManager get foodItemId {
    final $_column = $_itemColumn<int>('food_item_id')!;

    final manager = $$FoodItemsTableTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AllergensTable _allergenIdTable(_$AppDatabase db) =>
      db.allergens.createAlias(
        $_aliasNameGenerator(db.foodItemAllergens.allergenId, db.allergens.id),
      );

  $$AllergensTableProcessedTableManager get allergenId {
    final $_column = $_itemColumn<int>('allergen_id')!;

    final manager = $$AllergensTableTableManager(
      $_db,
      $_db.allergens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_allergenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FoodItemAllergensTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemAllergensTable> {
  $$FoodItemAllergensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodItemsTableFilterComposer get foodItemId {
    final $$FoodItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergensTableFilterComposer get allergenId {
    final $$AllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableFilterComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemAllergensTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemAllergensTable> {
  $$FoodItemAllergensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodItemsTableOrderingComposer get foodItemId {
    final $$FoodItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableOrderingComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergensTableOrderingComposer get allergenId {
    final $$AllergensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableOrderingComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemAllergensTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemAllergensTable> {
  $$FoodItemAllergensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FoodItemsTableAnnotationComposer get foodItemId {
    final $$FoodItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergensTableAnnotationComposer get allergenId {
    final $$AllergensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableAnnotationComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemAllergensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemAllergensTable,
          FoodItemAllergen,
          $$FoodItemAllergensTableFilterComposer,
          $$FoodItemAllergensTableOrderingComposer,
          $$FoodItemAllergensTableAnnotationComposer,
          $$FoodItemAllergensTableCreateCompanionBuilder,
          $$FoodItemAllergensTableUpdateCompanionBuilder,
          (FoodItemAllergen, $$FoodItemAllergensTableReferences),
          FoodItemAllergen,
          PrefetchHooks Function({bool foodItemId, bool allergenId})
        > {
  $$FoodItemAllergensTableTableManager(
    _$AppDatabase db,
    $FoodItemAllergensTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemAllergensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemAllergensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemAllergensTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> foodItemId = const Value.absent(),
                Value<int> allergenId = const Value.absent(),
                Value<String> relationType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodItemAllergensCompanion(
                id: id,
                foodItemId: foodItemId,
                allergenId: allergenId,
                relationType: relationType,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int foodItemId,
                required int allergenId,
                Value<String> relationType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodItemAllergensCompanion.insert(
                id: id,
                foodItemId: foodItemId,
                allergenId: allergenId,
                relationType: relationType,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodItemAllergensTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodItemId = false, allergenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodItemId,
                                referencedTable:
                                    $$FoodItemAllergensTableReferences
                                        ._foodItemIdTable(db),
                                referencedColumn:
                                    $$FoodItemAllergensTableReferences
                                        ._foodItemIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (allergenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.allergenId,
                                referencedTable:
                                    $$FoodItemAllergensTableReferences
                                        ._allergenIdTable(db),
                                referencedColumn:
                                    $$FoodItemAllergensTableReferences
                                        ._allergenIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FoodItemAllergensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemAllergensTable,
      FoodItemAllergen,
      $$FoodItemAllergensTableFilterComposer,
      $$FoodItemAllergensTableOrderingComposer,
      $$FoodItemAllergensTableAnnotationComposer,
      $$FoodItemAllergensTableCreateCompanionBuilder,
      $$FoodItemAllergensTableUpdateCompanionBuilder,
      (FoodItemAllergen, $$FoodItemAllergensTableReferences),
      FoodItemAllergen,
      PrefetchHooks Function({bool foodItemId, bool allergenId})
    >;
typedef $$UserFoodItemPreferencesTableCreateCompanionBuilder =
    UserFoodItemPreferencesCompanion Function({
      Value<int> id,
      required int localUserId,
      required int foodItemId,
      Value<String> preferenceState,
      Value<String> source,
      Value<double> confidence,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserFoodItemPreferencesTableUpdateCompanionBuilder =
    UserFoodItemPreferencesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<int> foodItemId,
      Value<String> preferenceState,
      Value<String> source,
      Value<double> confidence,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserFoodItemPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserFoodItemPreferencesTable,
          UserFoodItemPreference
        > {
  $$UserFoodItemPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodItemsTable _foodItemIdTable(_$AppDatabase db) =>
      db.foodItems.createAlias(
        $_aliasNameGenerator(
          db.userFoodItemPreferences.foodItemId,
          db.foodItems.id,
        ),
      );

  $$FoodItemsTableProcessedTableManager get foodItemId {
    final $_column = $_itemColumn<int>('food_item_id')!;

    final manager = $$FoodItemsTableTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserFoodItemPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserFoodItemPreferencesTable> {
  $$UserFoodItemPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodItemsTableFilterComposer get foodItemId {
    final $$FoodItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFoodItemPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFoodItemPreferencesTable> {
  $$UserFoodItemPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodItemsTableOrderingComposer get foodItemId {
    final $$FoodItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableOrderingComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFoodItemPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFoodItemPreferencesTable> {
  $$UserFoodItemPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferenceState => $composableBuilder(
    column: $table.preferenceState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FoodItemsTableAnnotationComposer get foodItemId {
    final $$FoodItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodItemId,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserFoodItemPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserFoodItemPreferencesTable,
          UserFoodItemPreference,
          $$UserFoodItemPreferencesTableFilterComposer,
          $$UserFoodItemPreferencesTableOrderingComposer,
          $$UserFoodItemPreferencesTableAnnotationComposer,
          $$UserFoodItemPreferencesTableCreateCompanionBuilder,
          $$UserFoodItemPreferencesTableUpdateCompanionBuilder,
          (UserFoodItemPreference, $$UserFoodItemPreferencesTableReferences),
          UserFoodItemPreference,
          PrefetchHooks Function({bool foodItemId})
        > {
  $$UserFoodItemPreferencesTableTableManager(
    _$AppDatabase db,
    $UserFoodItemPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFoodItemPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserFoodItemPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserFoodItemPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<int> foodItemId = const Value.absent(),
                Value<String> preferenceState = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserFoodItemPreferencesCompanion(
                id: id,
                localUserId: localUserId,
                foodItemId: foodItemId,
                preferenceState: preferenceState,
                source: source,
                confidence: confidence,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required int foodItemId,
                Value<String> preferenceState = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserFoodItemPreferencesCompanion.insert(
                id: id,
                localUserId: localUserId,
                foodItemId: foodItemId,
                preferenceState: preferenceState,
                source: source,
                confidence: confidence,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserFoodItemPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodItemId,
                                referencedTable:
                                    $$UserFoodItemPreferencesTableReferences
                                        ._foodItemIdTable(db),
                                referencedColumn:
                                    $$UserFoodItemPreferencesTableReferences
                                        ._foodItemIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserFoodItemPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserFoodItemPreferencesTable,
      UserFoodItemPreference,
      $$UserFoodItemPreferencesTableFilterComposer,
      $$UserFoodItemPreferencesTableOrderingComposer,
      $$UserFoodItemPreferencesTableAnnotationComposer,
      $$UserFoodItemPreferencesTableCreateCompanionBuilder,
      $$UserFoodItemPreferencesTableUpdateCompanionBuilder,
      (UserFoodItemPreference, $$UserFoodItemPreferencesTableReferences),
      UserFoodItemPreference,
      PrefetchHooks Function({bool foodItemId})
    >;
typedef $$UserFoodInteractionsTableCreateCompanionBuilder =
    UserFoodInteractionsCompanion Function({
      Value<int> id,
      required int localUserId,
      required String sessionId,
      required String eventType,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<String?> screenName,
      Value<String?> sourceSection,
      Value<int?> positionIndex,
      Value<String?> searchQuery,
      Value<int?> dwellTimeMs,
      Value<String?> metadataJson,
      Value<DateTime> occurredAt,
      Value<DateTime?> syncedAt,
    });
typedef $$UserFoodInteractionsTableUpdateCompanionBuilder =
    UserFoodInteractionsCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<String> sessionId,
      Value<String> eventType,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<String?> screenName,
      Value<String?> sourceSection,
      Value<int?> positionIndex,
      Value<String?> searchQuery,
      Value<int?> dwellTimeMs,
      Value<String?> metadataJson,
      Value<DateTime> occurredAt,
      Value<DateTime?> syncedAt,
    });

class $$UserFoodInteractionsTableFilterComposer
    extends Composer<_$AppDatabase, $UserFoodInteractionsTable> {
  $$UserFoodInteractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get screenName => $composableBuilder(
    column: $table.screenName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceSection => $composableBuilder(
    column: $table.sourceSection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get positionIndex => $composableBuilder(
    column: $table.positionIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchQuery => $composableBuilder(
    column: $table.searchQuery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dwellTimeMs => $composableBuilder(
    column: $table.dwellTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserFoodInteractionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFoodInteractionsTable> {
  $$UserFoodInteractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get screenName => $composableBuilder(
    column: $table.screenName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceSection => $composableBuilder(
    column: $table.sourceSection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get positionIndex => $composableBuilder(
    column: $table.positionIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchQuery => $composableBuilder(
    column: $table.searchQuery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dwellTimeMs => $composableBuilder(
    column: $table.dwellTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserFoodInteractionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFoodInteractionsTable> {
  $$UserFoodInteractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get screenName => $composableBuilder(
    column: $table.screenName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceSection => $composableBuilder(
    column: $table.sourceSection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get positionIndex => $composableBuilder(
    column: $table.positionIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchQuery => $composableBuilder(
    column: $table.searchQuery,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dwellTimeMs => $composableBuilder(
    column: $table.dwellTimeMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$UserFoodInteractionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserFoodInteractionsTable,
          UserFoodInteraction,
          $$UserFoodInteractionsTableFilterComposer,
          $$UserFoodInteractionsTableOrderingComposer,
          $$UserFoodInteractionsTableAnnotationComposer,
          $$UserFoodInteractionsTableCreateCompanionBuilder,
          $$UserFoodInteractionsTableUpdateCompanionBuilder,
          (
            UserFoodInteraction,
            BaseReferences<
              _$AppDatabase,
              $UserFoodInteractionsTable,
              UserFoodInteraction
            >,
          ),
          UserFoodInteraction,
          PrefetchHooks Function()
        > {
  $$UserFoodInteractionsTableTableManager(
    _$AppDatabase db,
    $UserFoodInteractionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFoodInteractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserFoodInteractionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserFoodInteractionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<String?> screenName = const Value.absent(),
                Value<String?> sourceSection = const Value.absent(),
                Value<int?> positionIndex = const Value.absent(),
                Value<String?> searchQuery = const Value.absent(),
                Value<int?> dwellTimeMs = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => UserFoodInteractionsCompanion(
                id: id,
                localUserId: localUserId,
                sessionId: sessionId,
                eventType: eventType,
                entityType: entityType,
                entityId: entityId,
                screenName: screenName,
                sourceSection: sourceSection,
                positionIndex: positionIndex,
                searchQuery: searchQuery,
                dwellTimeMs: dwellTimeMs,
                metadataJson: metadataJson,
                occurredAt: occurredAt,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required String sessionId,
                required String eventType,
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<String?> screenName = const Value.absent(),
                Value<String?> sourceSection = const Value.absent(),
                Value<int?> positionIndex = const Value.absent(),
                Value<String?> searchQuery = const Value.absent(),
                Value<int?> dwellTimeMs = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => UserFoodInteractionsCompanion.insert(
                id: id,
                localUserId: localUserId,
                sessionId: sessionId,
                eventType: eventType,
                entityType: entityType,
                entityId: entityId,
                screenName: screenName,
                sourceSection: sourceSection,
                positionIndex: positionIndex,
                searchQuery: searchQuery,
                dwellTimeMs: dwellTimeMs,
                metadataJson: metadataJson,
                occurredAt: occurredAt,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserFoodInteractionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserFoodInteractionsTable,
      UserFoodInteraction,
      $$UserFoodInteractionsTableFilterComposer,
      $$UserFoodInteractionsTableOrderingComposer,
      $$UserFoodInteractionsTableAnnotationComposer,
      $$UserFoodInteractionsTableCreateCompanionBuilder,
      $$UserFoodInteractionsTableUpdateCompanionBuilder,
      (
        UserFoodInteraction,
        BaseReferences<
          _$AppDatabase,
          $UserFoodInteractionsTable,
          UserFoodInteraction
        >,
      ),
      UserFoodInteraction,
      PrefetchHooks Function()
    >;
typedef $$UserHiddenEntitiesTableCreateCompanionBuilder =
    UserHiddenEntitiesCompanion Function({
      Value<int> id,
      required int localUserId,
      required String entityType,
      required String entityId,
      Value<String?> reason,
      Value<DateTime> createdAt,
    });
typedef $$UserHiddenEntitiesTableUpdateCompanionBuilder =
    UserHiddenEntitiesCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String?> reason,
      Value<DateTime> createdAt,
    });

class $$UserHiddenEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $UserHiddenEntitiesTable> {
  $$UserHiddenEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserHiddenEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserHiddenEntitiesTable> {
  $$UserHiddenEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserHiddenEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserHiddenEntitiesTable> {
  $$UserHiddenEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserHiddenEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserHiddenEntitiesTable,
          UserHiddenEntity,
          $$UserHiddenEntitiesTableFilterComposer,
          $$UserHiddenEntitiesTableOrderingComposer,
          $$UserHiddenEntitiesTableAnnotationComposer,
          $$UserHiddenEntitiesTableCreateCompanionBuilder,
          $$UserHiddenEntitiesTableUpdateCompanionBuilder,
          (
            UserHiddenEntity,
            BaseReferences<
              _$AppDatabase,
              $UserHiddenEntitiesTable,
              UserHiddenEntity
            >,
          ),
          UserHiddenEntity,
          PrefetchHooks Function()
        > {
  $$UserHiddenEntitiesTableTableManager(
    _$AppDatabase db,
    $UserHiddenEntitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserHiddenEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserHiddenEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserHiddenEntitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserHiddenEntitiesCompanion(
                id: id,
                localUserId: localUserId,
                entityType: entityType,
                entityId: entityId,
                reason: reason,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required String entityType,
                required String entityId,
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserHiddenEntitiesCompanion.insert(
                id: id,
                localUserId: localUserId,
                entityType: entityType,
                entityId: entityId,
                reason: reason,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserHiddenEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserHiddenEntitiesTable,
      UserHiddenEntity,
      $$UserHiddenEntitiesTableFilterComposer,
      $$UserHiddenEntitiesTableOrderingComposer,
      $$UserHiddenEntitiesTableAnnotationComposer,
      $$UserHiddenEntitiesTableCreateCompanionBuilder,
      $$UserHiddenEntitiesTableUpdateCompanionBuilder,
      (
        UserHiddenEntity,
        BaseReferences<
          _$AppDatabase,
          $UserHiddenEntitiesTable,
          UserHiddenEntity
        >,
      ),
      UserHiddenEntity,
      PrefetchHooks Function()
    >;
typedef $$ProfileChangeHistoryTableCreateCompanionBuilder =
    ProfileChangeHistoryCompanion Function({
      Value<int> id,
      required int localUserId,
      required String section,
      required String fieldKey,
      Value<String?> oldValueJson,
      Value<String?> newValueJson,
      required String source,
      Value<DateTime> changedAt,
    });
typedef $$ProfileChangeHistoryTableUpdateCompanionBuilder =
    ProfileChangeHistoryCompanion Function({
      Value<int> id,
      Value<int> localUserId,
      Value<String> section,
      Value<String> fieldKey,
      Value<String?> oldValueJson,
      Value<String?> newValueJson,
      Value<String> source,
      Value<DateTime> changedAt,
    });

class $$ProfileChangeHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileChangeHistoryTable> {
  $$ProfileChangeHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldValueJson => $composableBuilder(
    column: $table.oldValueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newValueJson => $composableBuilder(
    column: $table.newValueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileChangeHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileChangeHistoryTable> {
  $$ProfileChangeHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldValueJson => $composableBuilder(
    column: $table.oldValueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newValueJson => $composableBuilder(
    column: $table.newValueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileChangeHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileChangeHistoryTable> {
  $$ProfileChangeHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get localUserId => $composableBuilder(
    column: $table.localUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get fieldKey =>
      $composableBuilder(column: $table.fieldKey, builder: (column) => column);

  GeneratedColumn<String> get oldValueJson => $composableBuilder(
    column: $table.oldValueJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get newValueJson => $composableBuilder(
    column: $table.newValueJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $$ProfileChangeHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileChangeHistoryTable,
          ProfileChangeHistoryData,
          $$ProfileChangeHistoryTableFilterComposer,
          $$ProfileChangeHistoryTableOrderingComposer,
          $$ProfileChangeHistoryTableAnnotationComposer,
          $$ProfileChangeHistoryTableCreateCompanionBuilder,
          $$ProfileChangeHistoryTableUpdateCompanionBuilder,
          (
            ProfileChangeHistoryData,
            BaseReferences<
              _$AppDatabase,
              $ProfileChangeHistoryTable,
              ProfileChangeHistoryData
            >,
          ),
          ProfileChangeHistoryData,
          PrefetchHooks Function()
        > {
  $$ProfileChangeHistoryTableTableManager(
    _$AppDatabase db,
    $ProfileChangeHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileChangeHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileChangeHistoryTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProfileChangeHistoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> localUserId = const Value.absent(),
                Value<String> section = const Value.absent(),
                Value<String> fieldKey = const Value.absent(),
                Value<String?> oldValueJson = const Value.absent(),
                Value<String?> newValueJson = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
              }) => ProfileChangeHistoryCompanion(
                id: id,
                localUserId: localUserId,
                section: section,
                fieldKey: fieldKey,
                oldValueJson: oldValueJson,
                newValueJson: newValueJson,
                source: source,
                changedAt: changedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int localUserId,
                required String section,
                required String fieldKey,
                Value<String?> oldValueJson = const Value.absent(),
                Value<String?> newValueJson = const Value.absent(),
                required String source,
                Value<DateTime> changedAt = const Value.absent(),
              }) => ProfileChangeHistoryCompanion.insert(
                id: id,
                localUserId: localUserId,
                section: section,
                fieldKey: fieldKey,
                oldValueJson: oldValueJson,
                newValueJson: newValueJson,
                source: source,
                changedAt: changedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileChangeHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileChangeHistoryTable,
      ProfileChangeHistoryData,
      $$ProfileChangeHistoryTableFilterComposer,
      $$ProfileChangeHistoryTableOrderingComposer,
      $$ProfileChangeHistoryTableAnnotationComposer,
      $$ProfileChangeHistoryTableCreateCompanionBuilder,
      $$ProfileChangeHistoryTableUpdateCompanionBuilder,
      (
        ProfileChangeHistoryData,
        BaseReferences<
          _$AppDatabase,
          $ProfileChangeHistoryTable,
          ProfileChangeHistoryData
        >,
      ),
      ProfileChangeHistoryData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodProfilesTableTableManager get foodProfiles =>
      $$FoodProfilesTableTableManager(_db, _db.foodProfiles);
  $$FoodRulesTableTableManager get foodRules =>
      $$FoodRulesTableTableManager(_db, _db.foodRules);
  $$UserFoodRulesTableTableManager get userFoodRules =>
      $$UserFoodRulesTableTableManager(_db, _db.userFoodRules);
  $$AllergensTableTableManager get allergens =>
      $$AllergensTableTableManager(_db, _db.allergens);
  $$UserAllergiesTableTableManager get userAllergies =>
      $$UserAllergiesTableTableManager(_db, _db.userAllergies);
  $$IntolerancesTableTableManager get intolerances =>
      $$IntolerancesTableTableManager(_db, _db.intolerances);
  $$UserIntolerancesTableTableManager get userIntolerances =>
      $$UserIntolerancesTableTableManager(_db, _db.userIntolerances);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db, _db.ingredients);
  $$UserIngredientPreferencesTableTableManager get userIngredientPreferences =>
      $$UserIngredientPreferencesTableTableManager(
        _db,
        _db.userIngredientPreferences,
      );
  $$CuisinesTableTableManager get cuisines =>
      $$CuisinesTableTableManager(_db, _db.cuisines);
  $$UserCuisinePreferencesTableTableManager get userCuisinePreferences =>
      $$UserCuisinePreferencesTableTableManager(
        _db,
        _db.userCuisinePreferences,
      );
  $$FlavorAttributesTableTableManager get flavorAttributes =>
      $$FlavorAttributesTableTableManager(_db, _db.flavorAttributes);
  $$UserFlavorPreferencesTableTableManager get userFlavorPreferences =>
      $$UserFlavorPreferencesTableTableManager(_db, _db.userFlavorPreferences);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db, _db.foodItems);
  $$FoodItemIngredientsTableTableManager get foodItemIngredients =>
      $$FoodItemIngredientsTableTableManager(_db, _db.foodItemIngredients);
  $$FoodItemAllergensTableTableManager get foodItemAllergens =>
      $$FoodItemAllergensTableTableManager(_db, _db.foodItemAllergens);
  $$UserFoodItemPreferencesTableTableManager get userFoodItemPreferences =>
      $$UserFoodItemPreferencesTableTableManager(
        _db,
        _db.userFoodItemPreferences,
      );
  $$UserFoodInteractionsTableTableManager get userFoodInteractions =>
      $$UserFoodInteractionsTableTableManager(_db, _db.userFoodInteractions);
  $$UserHiddenEntitiesTableTableManager get userHiddenEntities =>
      $$UserHiddenEntitiesTableTableManager(_db, _db.userHiddenEntities);
  $$ProfileChangeHistoryTableTableManager get profileChangeHistory =>
      $$ProfileChangeHistoryTableTableManager(_db, _db.profileChangeHistory);
}
