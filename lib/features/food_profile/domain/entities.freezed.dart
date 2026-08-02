// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodProfile {

 int get id; int get localUserId; DietType get dietType; AdventurousnessLevel? get adventurousnessLevel; MealWeightPreference? get preferredMealWeight; BudgetLevel? get budgetLevel; List<EatingPriority> get topPriorities; OnboardingStatus get onboardingStatus; int get onboardingVersion; int get onboardingStep; bool get personalizationEnabled; double get profileCompleteness; DateTime get createdAt; DateTime get updatedAt; DateTime? get completedAt; DateTime? get skippedAt;
/// Create a copy of FoodProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodProfileCopyWith<FoodProfile> get copyWith => _$FoodProfileCopyWithImpl<FoodProfile>(this as FoodProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.localUserId, localUserId) || other.localUserId == localUserId)&&(identical(other.dietType, dietType) || other.dietType == dietType)&&(identical(other.adventurousnessLevel, adventurousnessLevel) || other.adventurousnessLevel == adventurousnessLevel)&&(identical(other.preferredMealWeight, preferredMealWeight) || other.preferredMealWeight == preferredMealWeight)&&(identical(other.budgetLevel, budgetLevel) || other.budgetLevel == budgetLevel)&&const DeepCollectionEquality().equals(other.topPriorities, topPriorities)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus)&&(identical(other.onboardingVersion, onboardingVersion) || other.onboardingVersion == onboardingVersion)&&(identical(other.onboardingStep, onboardingStep) || other.onboardingStep == onboardingStep)&&(identical(other.personalizationEnabled, personalizationEnabled) || other.personalizationEnabled == personalizationEnabled)&&(identical(other.profileCompleteness, profileCompleteness) || other.profileCompleteness == profileCompleteness)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.skippedAt, skippedAt) || other.skippedAt == skippedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,localUserId,dietType,adventurousnessLevel,preferredMealWeight,budgetLevel,const DeepCollectionEquality().hash(topPriorities),onboardingStatus,onboardingVersion,onboardingStep,personalizationEnabled,profileCompleteness,createdAt,updatedAt,completedAt,skippedAt);

@override
String toString() {
  return 'FoodProfile(id: $id, localUserId: $localUserId, dietType: $dietType, adventurousnessLevel: $adventurousnessLevel, preferredMealWeight: $preferredMealWeight, budgetLevel: $budgetLevel, topPriorities: $topPriorities, onboardingStatus: $onboardingStatus, onboardingVersion: $onboardingVersion, onboardingStep: $onboardingStep, personalizationEnabled: $personalizationEnabled, profileCompleteness: $profileCompleteness, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, skippedAt: $skippedAt)';
}


}

/// @nodoc
abstract mixin class $FoodProfileCopyWith<$Res>  {
  factory $FoodProfileCopyWith(FoodProfile value, $Res Function(FoodProfile) _then) = _$FoodProfileCopyWithImpl;
@useResult
$Res call({
 int id, int localUserId, DietType dietType, AdventurousnessLevel? adventurousnessLevel, MealWeightPreference? preferredMealWeight, BudgetLevel? budgetLevel, List<EatingPriority> topPriorities, OnboardingStatus onboardingStatus, int onboardingVersion, int onboardingStep, bool personalizationEnabled, double profileCompleteness, DateTime createdAt, DateTime updatedAt, DateTime? completedAt, DateTime? skippedAt
});




}
/// @nodoc
class _$FoodProfileCopyWithImpl<$Res>
    implements $FoodProfileCopyWith<$Res> {
  _$FoodProfileCopyWithImpl(this._self, this._then);

  final FoodProfile _self;
  final $Res Function(FoodProfile) _then;

/// Create a copy of FoodProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? localUserId = null,Object? dietType = null,Object? adventurousnessLevel = freezed,Object? preferredMealWeight = freezed,Object? budgetLevel = freezed,Object? topPriorities = null,Object? onboardingStatus = null,Object? onboardingVersion = null,Object? onboardingStep = null,Object? personalizationEnabled = null,Object? profileCompleteness = null,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? skippedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,localUserId: null == localUserId ? _self.localUserId : localUserId // ignore: cast_nullable_to_non_nullable
as int,dietType: null == dietType ? _self.dietType : dietType // ignore: cast_nullable_to_non_nullable
as DietType,adventurousnessLevel: freezed == adventurousnessLevel ? _self.adventurousnessLevel : adventurousnessLevel // ignore: cast_nullable_to_non_nullable
as AdventurousnessLevel?,preferredMealWeight: freezed == preferredMealWeight ? _self.preferredMealWeight : preferredMealWeight // ignore: cast_nullable_to_non_nullable
as MealWeightPreference?,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as BudgetLevel?,topPriorities: null == topPriorities ? _self.topPriorities : topPriorities // ignore: cast_nullable_to_non_nullable
as List<EatingPriority>,onboardingStatus: null == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,onboardingVersion: null == onboardingVersion ? _self.onboardingVersion : onboardingVersion // ignore: cast_nullable_to_non_nullable
as int,onboardingStep: null == onboardingStep ? _self.onboardingStep : onboardingStep // ignore: cast_nullable_to_non_nullable
as int,personalizationEnabled: null == personalizationEnabled ? _self.personalizationEnabled : personalizationEnabled // ignore: cast_nullable_to_non_nullable
as bool,profileCompleteness: null == profileCompleteness ? _self.profileCompleteness : profileCompleteness // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,skippedAt: freezed == skippedAt ? _self.skippedAt : skippedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodProfile].
extension FoodProfilePatterns on FoodProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodProfile value)  $default,){
final _that = this;
switch (_that) {
case _FoodProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodProfile value)?  $default,){
final _that = this;
switch (_that) {
case _FoodProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int localUserId,  DietType dietType,  AdventurousnessLevel? adventurousnessLevel,  MealWeightPreference? preferredMealWeight,  BudgetLevel? budgetLevel,  List<EatingPriority> topPriorities,  OnboardingStatus onboardingStatus,  int onboardingVersion,  int onboardingStep,  bool personalizationEnabled,  double profileCompleteness,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt,  DateTime? skippedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodProfile() when $default != null:
return $default(_that.id,_that.localUserId,_that.dietType,_that.adventurousnessLevel,_that.preferredMealWeight,_that.budgetLevel,_that.topPriorities,_that.onboardingStatus,_that.onboardingVersion,_that.onboardingStep,_that.personalizationEnabled,_that.profileCompleteness,_that.createdAt,_that.updatedAt,_that.completedAt,_that.skippedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int localUserId,  DietType dietType,  AdventurousnessLevel? adventurousnessLevel,  MealWeightPreference? preferredMealWeight,  BudgetLevel? budgetLevel,  List<EatingPriority> topPriorities,  OnboardingStatus onboardingStatus,  int onboardingVersion,  int onboardingStep,  bool personalizationEnabled,  double profileCompleteness,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt,  DateTime? skippedAt)  $default,) {final _that = this;
switch (_that) {
case _FoodProfile():
return $default(_that.id,_that.localUserId,_that.dietType,_that.adventurousnessLevel,_that.preferredMealWeight,_that.budgetLevel,_that.topPriorities,_that.onboardingStatus,_that.onboardingVersion,_that.onboardingStep,_that.personalizationEnabled,_that.profileCompleteness,_that.createdAt,_that.updatedAt,_that.completedAt,_that.skippedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int localUserId,  DietType dietType,  AdventurousnessLevel? adventurousnessLevel,  MealWeightPreference? preferredMealWeight,  BudgetLevel? budgetLevel,  List<EatingPriority> topPriorities,  OnboardingStatus onboardingStatus,  int onboardingVersion,  int onboardingStep,  bool personalizationEnabled,  double profileCompleteness,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt,  DateTime? skippedAt)?  $default,) {final _that = this;
switch (_that) {
case _FoodProfile() when $default != null:
return $default(_that.id,_that.localUserId,_that.dietType,_that.adventurousnessLevel,_that.preferredMealWeight,_that.budgetLevel,_that.topPriorities,_that.onboardingStatus,_that.onboardingVersion,_that.onboardingStep,_that.personalizationEnabled,_that.profileCompleteness,_that.createdAt,_that.updatedAt,_that.completedAt,_that.skippedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FoodProfile extends FoodProfile {
  const _FoodProfile({required this.id, required this.localUserId, required this.dietType, this.adventurousnessLevel, this.preferredMealWeight, this.budgetLevel, final  List<EatingPriority> topPriorities = const [], required this.onboardingStatus, required this.onboardingVersion, required this.onboardingStep, required this.personalizationEnabled, required this.profileCompleteness, required this.createdAt, required this.updatedAt, this.completedAt, this.skippedAt}): _topPriorities = topPriorities,super._();
  

@override final  int id;
@override final  int localUserId;
@override final  DietType dietType;
@override final  AdventurousnessLevel? adventurousnessLevel;
@override final  MealWeightPreference? preferredMealWeight;
@override final  BudgetLevel? budgetLevel;
 final  List<EatingPriority> _topPriorities;
@override@JsonKey() List<EatingPriority> get topPriorities {
  if (_topPriorities is EqualUnmodifiableListView) return _topPriorities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topPriorities);
}

@override final  OnboardingStatus onboardingStatus;
@override final  int onboardingVersion;
@override final  int onboardingStep;
@override final  bool personalizationEnabled;
@override final  double profileCompleteness;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? completedAt;
@override final  DateTime? skippedAt;

/// Create a copy of FoodProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodProfileCopyWith<_FoodProfile> get copyWith => __$FoodProfileCopyWithImpl<_FoodProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.localUserId, localUserId) || other.localUserId == localUserId)&&(identical(other.dietType, dietType) || other.dietType == dietType)&&(identical(other.adventurousnessLevel, adventurousnessLevel) || other.adventurousnessLevel == adventurousnessLevel)&&(identical(other.preferredMealWeight, preferredMealWeight) || other.preferredMealWeight == preferredMealWeight)&&(identical(other.budgetLevel, budgetLevel) || other.budgetLevel == budgetLevel)&&const DeepCollectionEquality().equals(other._topPriorities, _topPriorities)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus)&&(identical(other.onboardingVersion, onboardingVersion) || other.onboardingVersion == onboardingVersion)&&(identical(other.onboardingStep, onboardingStep) || other.onboardingStep == onboardingStep)&&(identical(other.personalizationEnabled, personalizationEnabled) || other.personalizationEnabled == personalizationEnabled)&&(identical(other.profileCompleteness, profileCompleteness) || other.profileCompleteness == profileCompleteness)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.skippedAt, skippedAt) || other.skippedAt == skippedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,localUserId,dietType,adventurousnessLevel,preferredMealWeight,budgetLevel,const DeepCollectionEquality().hash(_topPriorities),onboardingStatus,onboardingVersion,onboardingStep,personalizationEnabled,profileCompleteness,createdAt,updatedAt,completedAt,skippedAt);

@override
String toString() {
  return 'FoodProfile(id: $id, localUserId: $localUserId, dietType: $dietType, adventurousnessLevel: $adventurousnessLevel, preferredMealWeight: $preferredMealWeight, budgetLevel: $budgetLevel, topPriorities: $topPriorities, onboardingStatus: $onboardingStatus, onboardingVersion: $onboardingVersion, onboardingStep: $onboardingStep, personalizationEnabled: $personalizationEnabled, profileCompleteness: $profileCompleteness, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, skippedAt: $skippedAt)';
}


}

/// @nodoc
abstract mixin class _$FoodProfileCopyWith<$Res> implements $FoodProfileCopyWith<$Res> {
  factory _$FoodProfileCopyWith(_FoodProfile value, $Res Function(_FoodProfile) _then) = __$FoodProfileCopyWithImpl;
@override @useResult
$Res call({
 int id, int localUserId, DietType dietType, AdventurousnessLevel? adventurousnessLevel, MealWeightPreference? preferredMealWeight, BudgetLevel? budgetLevel, List<EatingPriority> topPriorities, OnboardingStatus onboardingStatus, int onboardingVersion, int onboardingStep, bool personalizationEnabled, double profileCompleteness, DateTime createdAt, DateTime updatedAt, DateTime? completedAt, DateTime? skippedAt
});




}
/// @nodoc
class __$FoodProfileCopyWithImpl<$Res>
    implements _$FoodProfileCopyWith<$Res> {
  __$FoodProfileCopyWithImpl(this._self, this._then);

  final _FoodProfile _self;
  final $Res Function(_FoodProfile) _then;

/// Create a copy of FoodProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? localUserId = null,Object? dietType = null,Object? adventurousnessLevel = freezed,Object? preferredMealWeight = freezed,Object? budgetLevel = freezed,Object? topPriorities = null,Object? onboardingStatus = null,Object? onboardingVersion = null,Object? onboardingStep = null,Object? personalizationEnabled = null,Object? profileCompleteness = null,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? skippedAt = freezed,}) {
  return _then(_FoodProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,localUserId: null == localUserId ? _self.localUserId : localUserId // ignore: cast_nullable_to_non_nullable
as int,dietType: null == dietType ? _self.dietType : dietType // ignore: cast_nullable_to_non_nullable
as DietType,adventurousnessLevel: freezed == adventurousnessLevel ? _self.adventurousnessLevel : adventurousnessLevel // ignore: cast_nullable_to_non_nullable
as AdventurousnessLevel?,preferredMealWeight: freezed == preferredMealWeight ? _self.preferredMealWeight : preferredMealWeight // ignore: cast_nullable_to_non_nullable
as MealWeightPreference?,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as BudgetLevel?,topPriorities: null == topPriorities ? _self._topPriorities : topPriorities // ignore: cast_nullable_to_non_nullable
as List<EatingPriority>,onboardingStatus: null == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,onboardingVersion: null == onboardingVersion ? _self.onboardingVersion : onboardingVersion // ignore: cast_nullable_to_non_nullable
as int,onboardingStep: null == onboardingStep ? _self.onboardingStep : onboardingStep // ignore: cast_nullable_to_non_nullable
as int,personalizationEnabled: null == personalizationEnabled ? _self.personalizationEnabled : personalizationEnabled // ignore: cast_nullable_to_non_nullable
as bool,profileCompleteness: null == profileCompleteness ? _self.profileCompleteness : profileCompleteness // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,skippedAt: freezed == skippedAt ? _self.skippedAt : skippedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$CatalogEntry {

 int get id; String get code; String? get category;
/// Create a copy of CatalogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogEntryCopyWith<CatalogEntry> get copyWith => _$CatalogEntryCopyWithImpl<CatalogEntry>(this as CatalogEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,category);

@override
String toString() {
  return 'CatalogEntry(id: $id, code: $code, category: $category)';
}


}

/// @nodoc
abstract mixin class $CatalogEntryCopyWith<$Res>  {
  factory $CatalogEntryCopyWith(CatalogEntry value, $Res Function(CatalogEntry) _then) = _$CatalogEntryCopyWithImpl;
@useResult
$Res call({
 int id, String code, String? category
});




}
/// @nodoc
class _$CatalogEntryCopyWithImpl<$Res>
    implements $CatalogEntryCopyWith<$Res> {
  _$CatalogEntryCopyWithImpl(this._self, this._then);

  final CatalogEntry _self;
  final $Res Function(CatalogEntry) _then;

/// Create a copy of CatalogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogEntry].
extension CatalogEntryPatterns on CatalogEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogEntry value)  $default,){
final _that = this;
switch (_that) {
case _CatalogEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogEntry() when $default != null:
return $default(_that.id,_that.code,_that.category);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String? category)  $default,) {final _that = this;
switch (_that) {
case _CatalogEntry():
return $default(_that.id,_that.code,_that.category);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String? category)?  $default,) {final _that = this;
switch (_that) {
case _CatalogEntry() when $default != null:
return $default(_that.id,_that.code,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _CatalogEntry implements CatalogEntry {
  const _CatalogEntry({required this.id, required this.code, this.category});
  

@override final  int id;
@override final  String code;
@override final  String? category;

/// Create a copy of CatalogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogEntryCopyWith<_CatalogEntry> get copyWith => __$CatalogEntryCopyWithImpl<_CatalogEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,category);

@override
String toString() {
  return 'CatalogEntry(id: $id, code: $code, category: $category)';
}


}

/// @nodoc
abstract mixin class _$CatalogEntryCopyWith<$Res> implements $CatalogEntryCopyWith<$Res> {
  factory _$CatalogEntryCopyWith(_CatalogEntry value, $Res Function(_CatalogEntry) _then) = __$CatalogEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String? category
});




}
/// @nodoc
class __$CatalogEntryCopyWithImpl<$Res>
    implements _$CatalogEntryCopyWith<$Res> {
  __$CatalogEntryCopyWithImpl(this._self, this._then);

  final _CatalogEntry _self;
  final $Res Function(_CatalogEntry) _then;

/// Create a copy of CatalogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? category = freezed,}) {
  return _then(_CatalogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$IngredientEntry {

 int get id; String get code; int? get parentId; String get category; bool get isAnimalProduct; bool get isMeat; bool get isSeafood; bool get isAlcoholRelated;
/// Create a copy of IngredientEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IngredientEntryCopyWith<IngredientEntry> get copyWith => _$IngredientEntryCopyWithImpl<IngredientEntry>(this as IngredientEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IngredientEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.category, category) || other.category == category)&&(identical(other.isAnimalProduct, isAnimalProduct) || other.isAnimalProduct == isAnimalProduct)&&(identical(other.isMeat, isMeat) || other.isMeat == isMeat)&&(identical(other.isSeafood, isSeafood) || other.isSeafood == isSeafood)&&(identical(other.isAlcoholRelated, isAlcoholRelated) || other.isAlcoholRelated == isAlcoholRelated));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,parentId,category,isAnimalProduct,isMeat,isSeafood,isAlcoholRelated);

@override
String toString() {
  return 'IngredientEntry(id: $id, code: $code, parentId: $parentId, category: $category, isAnimalProduct: $isAnimalProduct, isMeat: $isMeat, isSeafood: $isSeafood, isAlcoholRelated: $isAlcoholRelated)';
}


}

/// @nodoc
abstract mixin class $IngredientEntryCopyWith<$Res>  {
  factory $IngredientEntryCopyWith(IngredientEntry value, $Res Function(IngredientEntry) _then) = _$IngredientEntryCopyWithImpl;
@useResult
$Res call({
 int id, String code, int? parentId, String category, bool isAnimalProduct, bool isMeat, bool isSeafood, bool isAlcoholRelated
});




}
/// @nodoc
class _$IngredientEntryCopyWithImpl<$Res>
    implements $IngredientEntryCopyWith<$Res> {
  _$IngredientEntryCopyWithImpl(this._self, this._then);

  final IngredientEntry _self;
  final $Res Function(IngredientEntry) _then;

/// Create a copy of IngredientEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? parentId = freezed,Object? category = null,Object? isAnimalProduct = null,Object? isMeat = null,Object? isSeafood = null,Object? isAlcoholRelated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isAnimalProduct: null == isAnimalProduct ? _self.isAnimalProduct : isAnimalProduct // ignore: cast_nullable_to_non_nullable
as bool,isMeat: null == isMeat ? _self.isMeat : isMeat // ignore: cast_nullable_to_non_nullable
as bool,isSeafood: null == isSeafood ? _self.isSeafood : isSeafood // ignore: cast_nullable_to_non_nullable
as bool,isAlcoholRelated: null == isAlcoholRelated ? _self.isAlcoholRelated : isAlcoholRelated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IngredientEntry].
extension IngredientEntryPatterns on IngredientEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IngredientEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IngredientEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IngredientEntry value)  $default,){
final _that = this;
switch (_that) {
case _IngredientEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IngredientEntry value)?  $default,){
final _that = this;
switch (_that) {
case _IngredientEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  int? parentId,  String category,  bool isAnimalProduct,  bool isMeat,  bool isSeafood,  bool isAlcoholRelated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IngredientEntry() when $default != null:
return $default(_that.id,_that.code,_that.parentId,_that.category,_that.isAnimalProduct,_that.isMeat,_that.isSeafood,_that.isAlcoholRelated);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  int? parentId,  String category,  bool isAnimalProduct,  bool isMeat,  bool isSeafood,  bool isAlcoholRelated)  $default,) {final _that = this;
switch (_that) {
case _IngredientEntry():
return $default(_that.id,_that.code,_that.parentId,_that.category,_that.isAnimalProduct,_that.isMeat,_that.isSeafood,_that.isAlcoholRelated);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  int? parentId,  String category,  bool isAnimalProduct,  bool isMeat,  bool isSeafood,  bool isAlcoholRelated)?  $default,) {final _that = this;
switch (_that) {
case _IngredientEntry() when $default != null:
return $default(_that.id,_that.code,_that.parentId,_that.category,_that.isAnimalProduct,_that.isMeat,_that.isSeafood,_that.isAlcoholRelated);case _:
  return null;

}
}

}

/// @nodoc


class _IngredientEntry implements IngredientEntry {
  const _IngredientEntry({required this.id, required this.code, this.parentId, required this.category, required this.isAnimalProduct, required this.isMeat, required this.isSeafood, required this.isAlcoholRelated});
  

@override final  int id;
@override final  String code;
@override final  int? parentId;
@override final  String category;
@override final  bool isAnimalProduct;
@override final  bool isMeat;
@override final  bool isSeafood;
@override final  bool isAlcoholRelated;

/// Create a copy of IngredientEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IngredientEntryCopyWith<_IngredientEntry> get copyWith => __$IngredientEntryCopyWithImpl<_IngredientEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IngredientEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.category, category) || other.category == category)&&(identical(other.isAnimalProduct, isAnimalProduct) || other.isAnimalProduct == isAnimalProduct)&&(identical(other.isMeat, isMeat) || other.isMeat == isMeat)&&(identical(other.isSeafood, isSeafood) || other.isSeafood == isSeafood)&&(identical(other.isAlcoholRelated, isAlcoholRelated) || other.isAlcoholRelated == isAlcoholRelated));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,parentId,category,isAnimalProduct,isMeat,isSeafood,isAlcoholRelated);

@override
String toString() {
  return 'IngredientEntry(id: $id, code: $code, parentId: $parentId, category: $category, isAnimalProduct: $isAnimalProduct, isMeat: $isMeat, isSeafood: $isSeafood, isAlcoholRelated: $isAlcoholRelated)';
}


}

/// @nodoc
abstract mixin class _$IngredientEntryCopyWith<$Res> implements $IngredientEntryCopyWith<$Res> {
  factory _$IngredientEntryCopyWith(_IngredientEntry value, $Res Function(_IngredientEntry) _then) = __$IngredientEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, int? parentId, String category, bool isAnimalProduct, bool isMeat, bool isSeafood, bool isAlcoholRelated
});




}
/// @nodoc
class __$IngredientEntryCopyWithImpl<$Res>
    implements _$IngredientEntryCopyWith<$Res> {
  __$IngredientEntryCopyWithImpl(this._self, this._then);

  final _IngredientEntry _self;
  final $Res Function(_IngredientEntry) _then;

/// Create a copy of IngredientEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? parentId = freezed,Object? category = null,Object? isAnimalProduct = null,Object? isMeat = null,Object? isSeafood = null,Object? isAlcoholRelated = null,}) {
  return _then(_IngredientEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isAnimalProduct: null == isAnimalProduct ? _self.isAnimalProduct : isAnimalProduct // ignore: cast_nullable_to_non_nullable
as bool,isMeat: null == isMeat ? _self.isMeat : isMeat // ignore: cast_nullable_to_non_nullable
as bool,isSeafood: null == isSeafood ? _self.isSeafood : isSeafood // ignore: cast_nullable_to_non_nullable
as bool,isAlcoholRelated: null == isAlcoholRelated ? _self.isAlcoholRelated : isAlcoholRelated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$UserAllergy {

 int get id; int? get allergenId; String? get allergenCode; String? get customName; AllergySeverity get severity; String? get notes; bool get isActive; PreferenceSource get source;
/// Create a copy of UserAllergy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAllergyCopyWith<UserAllergy> get copyWith => _$UserAllergyCopyWithImpl<UserAllergy>(this as UserAllergy, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAllergy&&(identical(other.id, id) || other.id == id)&&(identical(other.allergenId, allergenId) || other.allergenId == allergenId)&&(identical(other.allergenCode, allergenCode) || other.allergenCode == allergenCode)&&(identical(other.customName, customName) || other.customName == customName)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,allergenId,allergenCode,customName,severity,notes,isActive,source);

@override
String toString() {
  return 'UserAllergy(id: $id, allergenId: $allergenId, allergenCode: $allergenCode, customName: $customName, severity: $severity, notes: $notes, isActive: $isActive, source: $source)';
}


}

/// @nodoc
abstract mixin class $UserAllergyCopyWith<$Res>  {
  factory $UserAllergyCopyWith(UserAllergy value, $Res Function(UserAllergy) _then) = _$UserAllergyCopyWithImpl;
@useResult
$Res call({
 int id, int? allergenId, String? allergenCode, String? customName, AllergySeverity severity, String? notes, bool isActive, PreferenceSource source
});




}
/// @nodoc
class _$UserAllergyCopyWithImpl<$Res>
    implements $UserAllergyCopyWith<$Res> {
  _$UserAllergyCopyWithImpl(this._self, this._then);

  final UserAllergy _self;
  final $Res Function(UserAllergy) _then;

/// Create a copy of UserAllergy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? allergenId = freezed,Object? allergenCode = freezed,Object? customName = freezed,Object? severity = null,Object? notes = freezed,Object? isActive = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,allergenId: freezed == allergenId ? _self.allergenId : allergenId // ignore: cast_nullable_to_non_nullable
as int?,allergenCode: freezed == allergenCode ? _self.allergenCode : allergenCode // ignore: cast_nullable_to_non_nullable
as String?,customName: freezed == customName ? _self.customName : customName // ignore: cast_nullable_to_non_nullable
as String?,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as AllergySeverity,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAllergy].
extension UserAllergyPatterns on UserAllergy {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAllergy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAllergy() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAllergy value)  $default,){
final _that = this;
switch (_that) {
case _UserAllergy():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAllergy value)?  $default,){
final _that = this;
switch (_that) {
case _UserAllergy() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? allergenId,  String? allergenCode,  String? customName,  AllergySeverity severity,  String? notes,  bool isActive,  PreferenceSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAllergy() when $default != null:
return $default(_that.id,_that.allergenId,_that.allergenCode,_that.customName,_that.severity,_that.notes,_that.isActive,_that.source);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? allergenId,  String? allergenCode,  String? customName,  AllergySeverity severity,  String? notes,  bool isActive,  PreferenceSource source)  $default,) {final _that = this;
switch (_that) {
case _UserAllergy():
return $default(_that.id,_that.allergenId,_that.allergenCode,_that.customName,_that.severity,_that.notes,_that.isActive,_that.source);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? allergenId,  String? allergenCode,  String? customName,  AllergySeverity severity,  String? notes,  bool isActive,  PreferenceSource source)?  $default,) {final _that = this;
switch (_that) {
case _UserAllergy() when $default != null:
return $default(_that.id,_that.allergenId,_that.allergenCode,_that.customName,_that.severity,_that.notes,_that.isActive,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _UserAllergy extends UserAllergy {
  const _UserAllergy({required this.id, this.allergenId, this.allergenCode, this.customName, required this.severity, this.notes, required this.isActive, required this.source}): super._();
  

@override final  int id;
@override final  int? allergenId;
@override final  String? allergenCode;
@override final  String? customName;
@override final  AllergySeverity severity;
@override final  String? notes;
@override final  bool isActive;
@override final  PreferenceSource source;

/// Create a copy of UserAllergy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAllergyCopyWith<_UserAllergy> get copyWith => __$UserAllergyCopyWithImpl<_UserAllergy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAllergy&&(identical(other.id, id) || other.id == id)&&(identical(other.allergenId, allergenId) || other.allergenId == allergenId)&&(identical(other.allergenCode, allergenCode) || other.allergenCode == allergenCode)&&(identical(other.customName, customName) || other.customName == customName)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,allergenId,allergenCode,customName,severity,notes,isActive,source);

@override
String toString() {
  return 'UserAllergy(id: $id, allergenId: $allergenId, allergenCode: $allergenCode, customName: $customName, severity: $severity, notes: $notes, isActive: $isActive, source: $source)';
}


}

/// @nodoc
abstract mixin class _$UserAllergyCopyWith<$Res> implements $UserAllergyCopyWith<$Res> {
  factory _$UserAllergyCopyWith(_UserAllergy value, $Res Function(_UserAllergy) _then) = __$UserAllergyCopyWithImpl;
@override @useResult
$Res call({
 int id, int? allergenId, String? allergenCode, String? customName, AllergySeverity severity, String? notes, bool isActive, PreferenceSource source
});




}
/// @nodoc
class __$UserAllergyCopyWithImpl<$Res>
    implements _$UserAllergyCopyWith<$Res> {
  __$UserAllergyCopyWithImpl(this._self, this._then);

  final _UserAllergy _self;
  final $Res Function(_UserAllergy) _then;

/// Create a copy of UserAllergy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? allergenId = freezed,Object? allergenCode = freezed,Object? customName = freezed,Object? severity = null,Object? notes = freezed,Object? isActive = null,Object? source = null,}) {
  return _then(_UserAllergy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,allergenId: freezed == allergenId ? _self.allergenId : allergenId // ignore: cast_nullable_to_non_nullable
as int?,allergenCode: freezed == allergenCode ? _self.allergenCode : allergenCode // ignore: cast_nullable_to_non_nullable
as String?,customName: freezed == customName ? _self.customName : customName // ignore: cast_nullable_to_non_nullable
as String?,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as AllergySeverity,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,
  ));
}


}

/// @nodoc
mixin _$UserIntolerance {

 int get id; int? get intoleranceId; String? get intoleranceCode; String? get customName; AllergySeverity get severity; String? get notes; bool get isActive;
/// Create a copy of UserIntolerance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserIntoleranceCopyWith<UserIntolerance> get copyWith => _$UserIntoleranceCopyWithImpl<UserIntolerance>(this as UserIntolerance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserIntolerance&&(identical(other.id, id) || other.id == id)&&(identical(other.intoleranceId, intoleranceId) || other.intoleranceId == intoleranceId)&&(identical(other.intoleranceCode, intoleranceCode) || other.intoleranceCode == intoleranceCode)&&(identical(other.customName, customName) || other.customName == customName)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,intoleranceId,intoleranceCode,customName,severity,notes,isActive);

@override
String toString() {
  return 'UserIntolerance(id: $id, intoleranceId: $intoleranceId, intoleranceCode: $intoleranceCode, customName: $customName, severity: $severity, notes: $notes, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $UserIntoleranceCopyWith<$Res>  {
  factory $UserIntoleranceCopyWith(UserIntolerance value, $Res Function(UserIntolerance) _then) = _$UserIntoleranceCopyWithImpl;
@useResult
$Res call({
 int id, int? intoleranceId, String? intoleranceCode, String? customName, AllergySeverity severity, String? notes, bool isActive
});




}
/// @nodoc
class _$UserIntoleranceCopyWithImpl<$Res>
    implements $UserIntoleranceCopyWith<$Res> {
  _$UserIntoleranceCopyWithImpl(this._self, this._then);

  final UserIntolerance _self;
  final $Res Function(UserIntolerance) _then;

/// Create a copy of UserIntolerance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? intoleranceId = freezed,Object? intoleranceCode = freezed,Object? customName = freezed,Object? severity = null,Object? notes = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,intoleranceId: freezed == intoleranceId ? _self.intoleranceId : intoleranceId // ignore: cast_nullable_to_non_nullable
as int?,intoleranceCode: freezed == intoleranceCode ? _self.intoleranceCode : intoleranceCode // ignore: cast_nullable_to_non_nullable
as String?,customName: freezed == customName ? _self.customName : customName // ignore: cast_nullable_to_non_nullable
as String?,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as AllergySeverity,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserIntolerance].
extension UserIntolerancePatterns on UserIntolerance {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserIntolerance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserIntolerance() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserIntolerance value)  $default,){
final _that = this;
switch (_that) {
case _UserIntolerance():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserIntolerance value)?  $default,){
final _that = this;
switch (_that) {
case _UserIntolerance() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? intoleranceId,  String? intoleranceCode,  String? customName,  AllergySeverity severity,  String? notes,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserIntolerance() when $default != null:
return $default(_that.id,_that.intoleranceId,_that.intoleranceCode,_that.customName,_that.severity,_that.notes,_that.isActive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? intoleranceId,  String? intoleranceCode,  String? customName,  AllergySeverity severity,  String? notes,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _UserIntolerance():
return $default(_that.id,_that.intoleranceId,_that.intoleranceCode,_that.customName,_that.severity,_that.notes,_that.isActive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? intoleranceId,  String? intoleranceCode,  String? customName,  AllergySeverity severity,  String? notes,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _UserIntolerance() when $default != null:
return $default(_that.id,_that.intoleranceId,_that.intoleranceCode,_that.customName,_that.severity,_that.notes,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _UserIntolerance extends UserIntolerance {
  const _UserIntolerance({required this.id, this.intoleranceId, this.intoleranceCode, this.customName, required this.severity, this.notes, required this.isActive}): super._();
  

@override final  int id;
@override final  int? intoleranceId;
@override final  String? intoleranceCode;
@override final  String? customName;
@override final  AllergySeverity severity;
@override final  String? notes;
@override final  bool isActive;

/// Create a copy of UserIntolerance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserIntoleranceCopyWith<_UserIntolerance> get copyWith => __$UserIntoleranceCopyWithImpl<_UserIntolerance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserIntolerance&&(identical(other.id, id) || other.id == id)&&(identical(other.intoleranceId, intoleranceId) || other.intoleranceId == intoleranceId)&&(identical(other.intoleranceCode, intoleranceCode) || other.intoleranceCode == intoleranceCode)&&(identical(other.customName, customName) || other.customName == customName)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,intoleranceId,intoleranceCode,customName,severity,notes,isActive);

@override
String toString() {
  return 'UserIntolerance(id: $id, intoleranceId: $intoleranceId, intoleranceCode: $intoleranceCode, customName: $customName, severity: $severity, notes: $notes, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$UserIntoleranceCopyWith<$Res> implements $UserIntoleranceCopyWith<$Res> {
  factory _$UserIntoleranceCopyWith(_UserIntolerance value, $Res Function(_UserIntolerance) _then) = __$UserIntoleranceCopyWithImpl;
@override @useResult
$Res call({
 int id, int? intoleranceId, String? intoleranceCode, String? customName, AllergySeverity severity, String? notes, bool isActive
});




}
/// @nodoc
class __$UserIntoleranceCopyWithImpl<$Res>
    implements _$UserIntoleranceCopyWith<$Res> {
  __$UserIntoleranceCopyWithImpl(this._self, this._then);

  final _UserIntolerance _self;
  final $Res Function(_UserIntolerance) _then;

/// Create a copy of UserIntolerance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? intoleranceId = freezed,Object? intoleranceCode = freezed,Object? customName = freezed,Object? severity = null,Object? notes = freezed,Object? isActive = null,}) {
  return _then(_UserIntolerance(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,intoleranceId: freezed == intoleranceId ? _self.intoleranceId : intoleranceId // ignore: cast_nullable_to_non_nullable
as int?,intoleranceCode: freezed == intoleranceCode ? _self.intoleranceCode : intoleranceCode // ignore: cast_nullable_to_non_nullable
as String?,customName: freezed == customName ? _self.customName : customName // ignore: cast_nullable_to_non_nullable
as String?,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as AllergySeverity,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$UserFoodRuleSelection {

 int get id; int get foodRuleId; String get foodRuleCode; RequirementLevel get requirementLevel; PreferenceSource get source; String? get notes;
/// Create a copy of UserFoodRuleSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFoodRuleSelectionCopyWith<UserFoodRuleSelection> get copyWith => _$UserFoodRuleSelectionCopyWithImpl<UserFoodRuleSelection>(this as UserFoodRuleSelection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFoodRuleSelection&&(identical(other.id, id) || other.id == id)&&(identical(other.foodRuleId, foodRuleId) || other.foodRuleId == foodRuleId)&&(identical(other.foodRuleCode, foodRuleCode) || other.foodRuleCode == foodRuleCode)&&(identical(other.requirementLevel, requirementLevel) || other.requirementLevel == requirementLevel)&&(identical(other.source, source) || other.source == source)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodRuleId,foodRuleCode,requirementLevel,source,notes);

@override
String toString() {
  return 'UserFoodRuleSelection(id: $id, foodRuleId: $foodRuleId, foodRuleCode: $foodRuleCode, requirementLevel: $requirementLevel, source: $source, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $UserFoodRuleSelectionCopyWith<$Res>  {
  factory $UserFoodRuleSelectionCopyWith(UserFoodRuleSelection value, $Res Function(UserFoodRuleSelection) _then) = _$UserFoodRuleSelectionCopyWithImpl;
@useResult
$Res call({
 int id, int foodRuleId, String foodRuleCode, RequirementLevel requirementLevel, PreferenceSource source, String? notes
});




}
/// @nodoc
class _$UserFoodRuleSelectionCopyWithImpl<$Res>
    implements $UserFoodRuleSelectionCopyWith<$Res> {
  _$UserFoodRuleSelectionCopyWithImpl(this._self, this._then);

  final UserFoodRuleSelection _self;
  final $Res Function(UserFoodRuleSelection) _then;

/// Create a copy of UserFoodRuleSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? foodRuleId = null,Object? foodRuleCode = null,Object? requirementLevel = null,Object? source = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,foodRuleId: null == foodRuleId ? _self.foodRuleId : foodRuleId // ignore: cast_nullable_to_non_nullable
as int,foodRuleCode: null == foodRuleCode ? _self.foodRuleCode : foodRuleCode // ignore: cast_nullable_to_non_nullable
as String,requirementLevel: null == requirementLevel ? _self.requirementLevel : requirementLevel // ignore: cast_nullable_to_non_nullable
as RequirementLevel,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFoodRuleSelection].
extension UserFoodRuleSelectionPatterns on UserFoodRuleSelection {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFoodRuleSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFoodRuleSelection() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFoodRuleSelection value)  $default,){
final _that = this;
switch (_that) {
case _UserFoodRuleSelection():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFoodRuleSelection value)?  $default,){
final _that = this;
switch (_that) {
case _UserFoodRuleSelection() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int foodRuleId,  String foodRuleCode,  RequirementLevel requirementLevel,  PreferenceSource source,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFoodRuleSelection() when $default != null:
return $default(_that.id,_that.foodRuleId,_that.foodRuleCode,_that.requirementLevel,_that.source,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int foodRuleId,  String foodRuleCode,  RequirementLevel requirementLevel,  PreferenceSource source,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _UserFoodRuleSelection():
return $default(_that.id,_that.foodRuleId,_that.foodRuleCode,_that.requirementLevel,_that.source,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int foodRuleId,  String foodRuleCode,  RequirementLevel requirementLevel,  PreferenceSource source,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _UserFoodRuleSelection() when $default != null:
return $default(_that.id,_that.foodRuleId,_that.foodRuleCode,_that.requirementLevel,_that.source,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _UserFoodRuleSelection implements UserFoodRuleSelection {
  const _UserFoodRuleSelection({required this.id, required this.foodRuleId, required this.foodRuleCode, required this.requirementLevel, required this.source, this.notes});
  

@override final  int id;
@override final  int foodRuleId;
@override final  String foodRuleCode;
@override final  RequirementLevel requirementLevel;
@override final  PreferenceSource source;
@override final  String? notes;

/// Create a copy of UserFoodRuleSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFoodRuleSelectionCopyWith<_UserFoodRuleSelection> get copyWith => __$UserFoodRuleSelectionCopyWithImpl<_UserFoodRuleSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFoodRuleSelection&&(identical(other.id, id) || other.id == id)&&(identical(other.foodRuleId, foodRuleId) || other.foodRuleId == foodRuleId)&&(identical(other.foodRuleCode, foodRuleCode) || other.foodRuleCode == foodRuleCode)&&(identical(other.requirementLevel, requirementLevel) || other.requirementLevel == requirementLevel)&&(identical(other.source, source) || other.source == source)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodRuleId,foodRuleCode,requirementLevel,source,notes);

@override
String toString() {
  return 'UserFoodRuleSelection(id: $id, foodRuleId: $foodRuleId, foodRuleCode: $foodRuleCode, requirementLevel: $requirementLevel, source: $source, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$UserFoodRuleSelectionCopyWith<$Res> implements $UserFoodRuleSelectionCopyWith<$Res> {
  factory _$UserFoodRuleSelectionCopyWith(_UserFoodRuleSelection value, $Res Function(_UserFoodRuleSelection) _then) = __$UserFoodRuleSelectionCopyWithImpl;
@override @useResult
$Res call({
 int id, int foodRuleId, String foodRuleCode, RequirementLevel requirementLevel, PreferenceSource source, String? notes
});




}
/// @nodoc
class __$UserFoodRuleSelectionCopyWithImpl<$Res>
    implements _$UserFoodRuleSelectionCopyWith<$Res> {
  __$UserFoodRuleSelectionCopyWithImpl(this._self, this._then);

  final _UserFoodRuleSelection _self;
  final $Res Function(_UserFoodRuleSelection) _then;

/// Create a copy of UserFoodRuleSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? foodRuleId = null,Object? foodRuleCode = null,Object? requirementLevel = null,Object? source = null,Object? notes = freezed,}) {
  return _then(_UserFoodRuleSelection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,foodRuleId: null == foodRuleId ? _self.foodRuleId : foodRuleId // ignore: cast_nullable_to_non_nullable
as int,foodRuleCode: null == foodRuleCode ? _self.foodRuleCode : foodRuleCode // ignore: cast_nullable_to_non_nullable
as String,requirementLevel: null == requirementLevel ? _self.requirementLevel : requirementLevel // ignore: cast_nullable_to_non_nullable
as RequirementLevel,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$UserIngredientPreferenceEntry {

 int get id; int get ingredientId; String get ingredientCode; PreferenceState get preferenceState; RestrictionType get restrictionType; PreferenceSource get source; double get confidence; String? get notes;
/// Create a copy of UserIngredientPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserIngredientPreferenceEntryCopyWith<UserIngredientPreferenceEntry> get copyWith => _$UserIngredientPreferenceEntryCopyWithImpl<UserIngredientPreferenceEntry>(this as UserIngredientPreferenceEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserIngredientPreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.ingredientId, ingredientId) || other.ingredientId == ingredientId)&&(identical(other.ingredientCode, ingredientCode) || other.ingredientCode == ingredientCode)&&(identical(other.preferenceState, preferenceState) || other.preferenceState == preferenceState)&&(identical(other.restrictionType, restrictionType) || other.restrictionType == restrictionType)&&(identical(other.source, source) || other.source == source)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,ingredientId,ingredientCode,preferenceState,restrictionType,source,confidence,notes);

@override
String toString() {
  return 'UserIngredientPreferenceEntry(id: $id, ingredientId: $ingredientId, ingredientCode: $ingredientCode, preferenceState: $preferenceState, restrictionType: $restrictionType, source: $source, confidence: $confidence, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $UserIngredientPreferenceEntryCopyWith<$Res>  {
  factory $UserIngredientPreferenceEntryCopyWith(UserIngredientPreferenceEntry value, $Res Function(UserIngredientPreferenceEntry) _then) = _$UserIngredientPreferenceEntryCopyWithImpl;
@useResult
$Res call({
 int id, int ingredientId, String ingredientCode, PreferenceState preferenceState, RestrictionType restrictionType, PreferenceSource source, double confidence, String? notes
});




}
/// @nodoc
class _$UserIngredientPreferenceEntryCopyWithImpl<$Res>
    implements $UserIngredientPreferenceEntryCopyWith<$Res> {
  _$UserIngredientPreferenceEntryCopyWithImpl(this._self, this._then);

  final UserIngredientPreferenceEntry _self;
  final $Res Function(UserIngredientPreferenceEntry) _then;

/// Create a copy of UserIngredientPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ingredientId = null,Object? ingredientCode = null,Object? preferenceState = null,Object? restrictionType = null,Object? source = null,Object? confidence = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ingredientId: null == ingredientId ? _self.ingredientId : ingredientId // ignore: cast_nullable_to_non_nullable
as int,ingredientCode: null == ingredientCode ? _self.ingredientCode : ingredientCode // ignore: cast_nullable_to_non_nullable
as String,preferenceState: null == preferenceState ? _self.preferenceState : preferenceState // ignore: cast_nullable_to_non_nullable
as PreferenceState,restrictionType: null == restrictionType ? _self.restrictionType : restrictionType // ignore: cast_nullable_to_non_nullable
as RestrictionType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserIngredientPreferenceEntry].
extension UserIngredientPreferenceEntryPatterns on UserIngredientPreferenceEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserIngredientPreferenceEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserIngredientPreferenceEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserIngredientPreferenceEntry value)  $default,){
final _that = this;
switch (_that) {
case _UserIngredientPreferenceEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserIngredientPreferenceEntry value)?  $default,){
final _that = this;
switch (_that) {
case _UserIngredientPreferenceEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int ingredientId,  String ingredientCode,  PreferenceState preferenceState,  RestrictionType restrictionType,  PreferenceSource source,  double confidence,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserIngredientPreferenceEntry() when $default != null:
return $default(_that.id,_that.ingredientId,_that.ingredientCode,_that.preferenceState,_that.restrictionType,_that.source,_that.confidence,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int ingredientId,  String ingredientCode,  PreferenceState preferenceState,  RestrictionType restrictionType,  PreferenceSource source,  double confidence,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _UserIngredientPreferenceEntry():
return $default(_that.id,_that.ingredientId,_that.ingredientCode,_that.preferenceState,_that.restrictionType,_that.source,_that.confidence,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int ingredientId,  String ingredientCode,  PreferenceState preferenceState,  RestrictionType restrictionType,  PreferenceSource source,  double confidence,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _UserIngredientPreferenceEntry() when $default != null:
return $default(_that.id,_that.ingredientId,_that.ingredientCode,_that.preferenceState,_that.restrictionType,_that.source,_that.confidence,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _UserIngredientPreferenceEntry implements UserIngredientPreferenceEntry {
  const _UserIngredientPreferenceEntry({required this.id, required this.ingredientId, required this.ingredientCode, required this.preferenceState, required this.restrictionType, required this.source, required this.confidence, this.notes});
  

@override final  int id;
@override final  int ingredientId;
@override final  String ingredientCode;
@override final  PreferenceState preferenceState;
@override final  RestrictionType restrictionType;
@override final  PreferenceSource source;
@override final  double confidence;
@override final  String? notes;

/// Create a copy of UserIngredientPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserIngredientPreferenceEntryCopyWith<_UserIngredientPreferenceEntry> get copyWith => __$UserIngredientPreferenceEntryCopyWithImpl<_UserIngredientPreferenceEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserIngredientPreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.ingredientId, ingredientId) || other.ingredientId == ingredientId)&&(identical(other.ingredientCode, ingredientCode) || other.ingredientCode == ingredientCode)&&(identical(other.preferenceState, preferenceState) || other.preferenceState == preferenceState)&&(identical(other.restrictionType, restrictionType) || other.restrictionType == restrictionType)&&(identical(other.source, source) || other.source == source)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,ingredientId,ingredientCode,preferenceState,restrictionType,source,confidence,notes);

@override
String toString() {
  return 'UserIngredientPreferenceEntry(id: $id, ingredientId: $ingredientId, ingredientCode: $ingredientCode, preferenceState: $preferenceState, restrictionType: $restrictionType, source: $source, confidence: $confidence, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$UserIngredientPreferenceEntryCopyWith<$Res> implements $UserIngredientPreferenceEntryCopyWith<$Res> {
  factory _$UserIngredientPreferenceEntryCopyWith(_UserIngredientPreferenceEntry value, $Res Function(_UserIngredientPreferenceEntry) _then) = __$UserIngredientPreferenceEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, int ingredientId, String ingredientCode, PreferenceState preferenceState, RestrictionType restrictionType, PreferenceSource source, double confidence, String? notes
});




}
/// @nodoc
class __$UserIngredientPreferenceEntryCopyWithImpl<$Res>
    implements _$UserIngredientPreferenceEntryCopyWith<$Res> {
  __$UserIngredientPreferenceEntryCopyWithImpl(this._self, this._then);

  final _UserIngredientPreferenceEntry _self;
  final $Res Function(_UserIngredientPreferenceEntry) _then;

/// Create a copy of UserIngredientPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ingredientId = null,Object? ingredientCode = null,Object? preferenceState = null,Object? restrictionType = null,Object? source = null,Object? confidence = null,Object? notes = freezed,}) {
  return _then(_UserIngredientPreferenceEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ingredientId: null == ingredientId ? _self.ingredientId : ingredientId // ignore: cast_nullable_to_non_nullable
as int,ingredientCode: null == ingredientCode ? _self.ingredientCode : ingredientCode // ignore: cast_nullable_to_non_nullable
as String,preferenceState: null == preferenceState ? _self.preferenceState : preferenceState // ignore: cast_nullable_to_non_nullable
as PreferenceState,restrictionType: null == restrictionType ? _self.restrictionType : restrictionType // ignore: cast_nullable_to_non_nullable
as RestrictionType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$UserCuisinePreferenceEntry {

 int get id; int get cuisineId; String get cuisineCode; PreferenceState get preferenceState; double? get curiosityScore; PreferenceSource get source; double get confidence;
/// Create a copy of UserCuisinePreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCuisinePreferenceEntryCopyWith<UserCuisinePreferenceEntry> get copyWith => _$UserCuisinePreferenceEntryCopyWithImpl<UserCuisinePreferenceEntry>(this as UserCuisinePreferenceEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCuisinePreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.cuisineId, cuisineId) || other.cuisineId == cuisineId)&&(identical(other.cuisineCode, cuisineCode) || other.cuisineCode == cuisineCode)&&(identical(other.preferenceState, preferenceState) || other.preferenceState == preferenceState)&&(identical(other.curiosityScore, curiosityScore) || other.curiosityScore == curiosityScore)&&(identical(other.source, source) || other.source == source)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}


@override
int get hashCode => Object.hash(runtimeType,id,cuisineId,cuisineCode,preferenceState,curiosityScore,source,confidence);

@override
String toString() {
  return 'UserCuisinePreferenceEntry(id: $id, cuisineId: $cuisineId, cuisineCode: $cuisineCode, preferenceState: $preferenceState, curiosityScore: $curiosityScore, source: $source, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $UserCuisinePreferenceEntryCopyWith<$Res>  {
  factory $UserCuisinePreferenceEntryCopyWith(UserCuisinePreferenceEntry value, $Res Function(UserCuisinePreferenceEntry) _then) = _$UserCuisinePreferenceEntryCopyWithImpl;
@useResult
$Res call({
 int id, int cuisineId, String cuisineCode, PreferenceState preferenceState, double? curiosityScore, PreferenceSource source, double confidence
});




}
/// @nodoc
class _$UserCuisinePreferenceEntryCopyWithImpl<$Res>
    implements $UserCuisinePreferenceEntryCopyWith<$Res> {
  _$UserCuisinePreferenceEntryCopyWithImpl(this._self, this._then);

  final UserCuisinePreferenceEntry _self;
  final $Res Function(UserCuisinePreferenceEntry) _then;

/// Create a copy of UserCuisinePreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cuisineId = null,Object? cuisineCode = null,Object? preferenceState = null,Object? curiosityScore = freezed,Object? source = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cuisineId: null == cuisineId ? _self.cuisineId : cuisineId // ignore: cast_nullable_to_non_nullable
as int,cuisineCode: null == cuisineCode ? _self.cuisineCode : cuisineCode // ignore: cast_nullable_to_non_nullable
as String,preferenceState: null == preferenceState ? _self.preferenceState : preferenceState // ignore: cast_nullable_to_non_nullable
as PreferenceState,curiosityScore: freezed == curiosityScore ? _self.curiosityScore : curiosityScore // ignore: cast_nullable_to_non_nullable
as double?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCuisinePreferenceEntry].
extension UserCuisinePreferenceEntryPatterns on UserCuisinePreferenceEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCuisinePreferenceEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCuisinePreferenceEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCuisinePreferenceEntry value)  $default,){
final _that = this;
switch (_that) {
case _UserCuisinePreferenceEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCuisinePreferenceEntry value)?  $default,){
final _that = this;
switch (_that) {
case _UserCuisinePreferenceEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int cuisineId,  String cuisineCode,  PreferenceState preferenceState,  double? curiosityScore,  PreferenceSource source,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCuisinePreferenceEntry() when $default != null:
return $default(_that.id,_that.cuisineId,_that.cuisineCode,_that.preferenceState,_that.curiosityScore,_that.source,_that.confidence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int cuisineId,  String cuisineCode,  PreferenceState preferenceState,  double? curiosityScore,  PreferenceSource source,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _UserCuisinePreferenceEntry():
return $default(_that.id,_that.cuisineId,_that.cuisineCode,_that.preferenceState,_that.curiosityScore,_that.source,_that.confidence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int cuisineId,  String cuisineCode,  PreferenceState preferenceState,  double? curiosityScore,  PreferenceSource source,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _UserCuisinePreferenceEntry() when $default != null:
return $default(_that.id,_that.cuisineId,_that.cuisineCode,_that.preferenceState,_that.curiosityScore,_that.source,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc


class _UserCuisinePreferenceEntry implements UserCuisinePreferenceEntry {
  const _UserCuisinePreferenceEntry({required this.id, required this.cuisineId, required this.cuisineCode, required this.preferenceState, this.curiosityScore, required this.source, required this.confidence});
  

@override final  int id;
@override final  int cuisineId;
@override final  String cuisineCode;
@override final  PreferenceState preferenceState;
@override final  double? curiosityScore;
@override final  PreferenceSource source;
@override final  double confidence;

/// Create a copy of UserCuisinePreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCuisinePreferenceEntryCopyWith<_UserCuisinePreferenceEntry> get copyWith => __$UserCuisinePreferenceEntryCopyWithImpl<_UserCuisinePreferenceEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCuisinePreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.cuisineId, cuisineId) || other.cuisineId == cuisineId)&&(identical(other.cuisineCode, cuisineCode) || other.cuisineCode == cuisineCode)&&(identical(other.preferenceState, preferenceState) || other.preferenceState == preferenceState)&&(identical(other.curiosityScore, curiosityScore) || other.curiosityScore == curiosityScore)&&(identical(other.source, source) || other.source == source)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}


@override
int get hashCode => Object.hash(runtimeType,id,cuisineId,cuisineCode,preferenceState,curiosityScore,source,confidence);

@override
String toString() {
  return 'UserCuisinePreferenceEntry(id: $id, cuisineId: $cuisineId, cuisineCode: $cuisineCode, preferenceState: $preferenceState, curiosityScore: $curiosityScore, source: $source, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$UserCuisinePreferenceEntryCopyWith<$Res> implements $UserCuisinePreferenceEntryCopyWith<$Res> {
  factory _$UserCuisinePreferenceEntryCopyWith(_UserCuisinePreferenceEntry value, $Res Function(_UserCuisinePreferenceEntry) _then) = __$UserCuisinePreferenceEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, int cuisineId, String cuisineCode, PreferenceState preferenceState, double? curiosityScore, PreferenceSource source, double confidence
});




}
/// @nodoc
class __$UserCuisinePreferenceEntryCopyWithImpl<$Res>
    implements _$UserCuisinePreferenceEntryCopyWith<$Res> {
  __$UserCuisinePreferenceEntryCopyWithImpl(this._self, this._then);

  final _UserCuisinePreferenceEntry _self;
  final $Res Function(_UserCuisinePreferenceEntry) _then;

/// Create a copy of UserCuisinePreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cuisineId = null,Object? cuisineCode = null,Object? preferenceState = null,Object? curiosityScore = freezed,Object? source = null,Object? confidence = null,}) {
  return _then(_UserCuisinePreferenceEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cuisineId: null == cuisineId ? _self.cuisineId : cuisineId // ignore: cast_nullable_to_non_nullable
as int,cuisineCode: null == cuisineCode ? _self.cuisineCode : cuisineCode // ignore: cast_nullable_to_non_nullable
as String,preferenceState: null == preferenceState ? _self.preferenceState : preferenceState // ignore: cast_nullable_to_non_nullable
as PreferenceState,curiosityScore: freezed == curiosityScore ? _self.curiosityScore : curiosityScore // ignore: cast_nullable_to_non_nullable
as double?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$UserFlavorPreferenceEntry {

 int get id; int get flavorAttributeId; String get flavorAttributeCode; int get preferenceLevel; PreferenceSource get source;
/// Create a copy of UserFlavorPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFlavorPreferenceEntryCopyWith<UserFlavorPreferenceEntry> get copyWith => _$UserFlavorPreferenceEntryCopyWithImpl<UserFlavorPreferenceEntry>(this as UserFlavorPreferenceEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFlavorPreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.flavorAttributeId, flavorAttributeId) || other.flavorAttributeId == flavorAttributeId)&&(identical(other.flavorAttributeCode, flavorAttributeCode) || other.flavorAttributeCode == flavorAttributeCode)&&(identical(other.preferenceLevel, preferenceLevel) || other.preferenceLevel == preferenceLevel)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,flavorAttributeId,flavorAttributeCode,preferenceLevel,source);

@override
String toString() {
  return 'UserFlavorPreferenceEntry(id: $id, flavorAttributeId: $flavorAttributeId, flavorAttributeCode: $flavorAttributeCode, preferenceLevel: $preferenceLevel, source: $source)';
}


}

/// @nodoc
abstract mixin class $UserFlavorPreferenceEntryCopyWith<$Res>  {
  factory $UserFlavorPreferenceEntryCopyWith(UserFlavorPreferenceEntry value, $Res Function(UserFlavorPreferenceEntry) _then) = _$UserFlavorPreferenceEntryCopyWithImpl;
@useResult
$Res call({
 int id, int flavorAttributeId, String flavorAttributeCode, int preferenceLevel, PreferenceSource source
});




}
/// @nodoc
class _$UserFlavorPreferenceEntryCopyWithImpl<$Res>
    implements $UserFlavorPreferenceEntryCopyWith<$Res> {
  _$UserFlavorPreferenceEntryCopyWithImpl(this._self, this._then);

  final UserFlavorPreferenceEntry _self;
  final $Res Function(UserFlavorPreferenceEntry) _then;

/// Create a copy of UserFlavorPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? flavorAttributeId = null,Object? flavorAttributeCode = null,Object? preferenceLevel = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,flavorAttributeId: null == flavorAttributeId ? _self.flavorAttributeId : flavorAttributeId // ignore: cast_nullable_to_non_nullable
as int,flavorAttributeCode: null == flavorAttributeCode ? _self.flavorAttributeCode : flavorAttributeCode // ignore: cast_nullable_to_non_nullable
as String,preferenceLevel: null == preferenceLevel ? _self.preferenceLevel : preferenceLevel // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFlavorPreferenceEntry].
extension UserFlavorPreferenceEntryPatterns on UserFlavorPreferenceEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFlavorPreferenceEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFlavorPreferenceEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFlavorPreferenceEntry value)  $default,){
final _that = this;
switch (_that) {
case _UserFlavorPreferenceEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFlavorPreferenceEntry value)?  $default,){
final _that = this;
switch (_that) {
case _UserFlavorPreferenceEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int flavorAttributeId,  String flavorAttributeCode,  int preferenceLevel,  PreferenceSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFlavorPreferenceEntry() when $default != null:
return $default(_that.id,_that.flavorAttributeId,_that.flavorAttributeCode,_that.preferenceLevel,_that.source);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int flavorAttributeId,  String flavorAttributeCode,  int preferenceLevel,  PreferenceSource source)  $default,) {final _that = this;
switch (_that) {
case _UserFlavorPreferenceEntry():
return $default(_that.id,_that.flavorAttributeId,_that.flavorAttributeCode,_that.preferenceLevel,_that.source);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int flavorAttributeId,  String flavorAttributeCode,  int preferenceLevel,  PreferenceSource source)?  $default,) {final _that = this;
switch (_that) {
case _UserFlavorPreferenceEntry() when $default != null:
return $default(_that.id,_that.flavorAttributeId,_that.flavorAttributeCode,_that.preferenceLevel,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _UserFlavorPreferenceEntry implements UserFlavorPreferenceEntry {
  const _UserFlavorPreferenceEntry({required this.id, required this.flavorAttributeId, required this.flavorAttributeCode, required this.preferenceLevel, required this.source});
  

@override final  int id;
@override final  int flavorAttributeId;
@override final  String flavorAttributeCode;
@override final  int preferenceLevel;
@override final  PreferenceSource source;

/// Create a copy of UserFlavorPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFlavorPreferenceEntryCopyWith<_UserFlavorPreferenceEntry> get copyWith => __$UserFlavorPreferenceEntryCopyWithImpl<_UserFlavorPreferenceEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFlavorPreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.flavorAttributeId, flavorAttributeId) || other.flavorAttributeId == flavorAttributeId)&&(identical(other.flavorAttributeCode, flavorAttributeCode) || other.flavorAttributeCode == flavorAttributeCode)&&(identical(other.preferenceLevel, preferenceLevel) || other.preferenceLevel == preferenceLevel)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,flavorAttributeId,flavorAttributeCode,preferenceLevel,source);

@override
String toString() {
  return 'UserFlavorPreferenceEntry(id: $id, flavorAttributeId: $flavorAttributeId, flavorAttributeCode: $flavorAttributeCode, preferenceLevel: $preferenceLevel, source: $source)';
}


}

/// @nodoc
abstract mixin class _$UserFlavorPreferenceEntryCopyWith<$Res> implements $UserFlavorPreferenceEntryCopyWith<$Res> {
  factory _$UserFlavorPreferenceEntryCopyWith(_UserFlavorPreferenceEntry value, $Res Function(_UserFlavorPreferenceEntry) _then) = __$UserFlavorPreferenceEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, int flavorAttributeId, String flavorAttributeCode, int preferenceLevel, PreferenceSource source
});




}
/// @nodoc
class __$UserFlavorPreferenceEntryCopyWithImpl<$Res>
    implements _$UserFlavorPreferenceEntryCopyWith<$Res> {
  __$UserFlavorPreferenceEntryCopyWithImpl(this._self, this._then);

  final _UserFlavorPreferenceEntry _self;
  final $Res Function(_UserFlavorPreferenceEntry) _then;

/// Create a copy of UserFlavorPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? flavorAttributeId = null,Object? flavorAttributeCode = null,Object? preferenceLevel = null,Object? source = null,}) {
  return _then(_UserFlavorPreferenceEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,flavorAttributeId: null == flavorAttributeId ? _self.flavorAttributeId : flavorAttributeId // ignore: cast_nullable_to_non_nullable
as int,flavorAttributeCode: null == flavorAttributeCode ? _self.flavorAttributeCode : flavorAttributeCode // ignore: cast_nullable_to_non_nullable
as String,preferenceLevel: null == preferenceLevel ? _self.preferenceLevel : preferenceLevel // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,
  ));
}


}

/// @nodoc
mixin _$FoodItemEntry {

 int get id; String get code; int? get cuisineId; String? get imageAsset; List<int> get primaryIngredientIds; List<int> get mayContainIngredientIds; List<int> get allergenIds; List<int> get mayContainAllergenIds;
/// Create a copy of FoodItemEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodItemEntryCopyWith<FoodItemEntry> get copyWith => _$FoodItemEntryCopyWithImpl<FoodItemEntry>(this as FoodItemEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodItemEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.cuisineId, cuisineId) || other.cuisineId == cuisineId)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&const DeepCollectionEquality().equals(other.primaryIngredientIds, primaryIngredientIds)&&const DeepCollectionEquality().equals(other.mayContainIngredientIds, mayContainIngredientIds)&&const DeepCollectionEquality().equals(other.allergenIds, allergenIds)&&const DeepCollectionEquality().equals(other.mayContainAllergenIds, mayContainAllergenIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,cuisineId,imageAsset,const DeepCollectionEquality().hash(primaryIngredientIds),const DeepCollectionEquality().hash(mayContainIngredientIds),const DeepCollectionEquality().hash(allergenIds),const DeepCollectionEquality().hash(mayContainAllergenIds));

@override
String toString() {
  return 'FoodItemEntry(id: $id, code: $code, cuisineId: $cuisineId, imageAsset: $imageAsset, primaryIngredientIds: $primaryIngredientIds, mayContainIngredientIds: $mayContainIngredientIds, allergenIds: $allergenIds, mayContainAllergenIds: $mayContainAllergenIds)';
}


}

/// @nodoc
abstract mixin class $FoodItemEntryCopyWith<$Res>  {
  factory $FoodItemEntryCopyWith(FoodItemEntry value, $Res Function(FoodItemEntry) _then) = _$FoodItemEntryCopyWithImpl;
@useResult
$Res call({
 int id, String code, int? cuisineId, String? imageAsset, List<int> primaryIngredientIds, List<int> mayContainIngredientIds, List<int> allergenIds, List<int> mayContainAllergenIds
});




}
/// @nodoc
class _$FoodItemEntryCopyWithImpl<$Res>
    implements $FoodItemEntryCopyWith<$Res> {
  _$FoodItemEntryCopyWithImpl(this._self, this._then);

  final FoodItemEntry _self;
  final $Res Function(FoodItemEntry) _then;

/// Create a copy of FoodItemEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? cuisineId = freezed,Object? imageAsset = freezed,Object? primaryIngredientIds = null,Object? mayContainIngredientIds = null,Object? allergenIds = null,Object? mayContainAllergenIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,cuisineId: freezed == cuisineId ? _self.cuisineId : cuisineId // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,primaryIngredientIds: null == primaryIngredientIds ? _self.primaryIngredientIds : primaryIngredientIds // ignore: cast_nullable_to_non_nullable
as List<int>,mayContainIngredientIds: null == mayContainIngredientIds ? _self.mayContainIngredientIds : mayContainIngredientIds // ignore: cast_nullable_to_non_nullable
as List<int>,allergenIds: null == allergenIds ? _self.allergenIds : allergenIds // ignore: cast_nullable_to_non_nullable
as List<int>,mayContainAllergenIds: null == mayContainAllergenIds ? _self.mayContainAllergenIds : mayContainAllergenIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodItemEntry].
extension FoodItemEntryPatterns on FoodItemEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodItemEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodItemEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodItemEntry value)  $default,){
final _that = this;
switch (_that) {
case _FoodItemEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodItemEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FoodItemEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  int? cuisineId,  String? imageAsset,  List<int> primaryIngredientIds,  List<int> mayContainIngredientIds,  List<int> allergenIds,  List<int> mayContainAllergenIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodItemEntry() when $default != null:
return $default(_that.id,_that.code,_that.cuisineId,_that.imageAsset,_that.primaryIngredientIds,_that.mayContainIngredientIds,_that.allergenIds,_that.mayContainAllergenIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  int? cuisineId,  String? imageAsset,  List<int> primaryIngredientIds,  List<int> mayContainIngredientIds,  List<int> allergenIds,  List<int> mayContainAllergenIds)  $default,) {final _that = this;
switch (_that) {
case _FoodItemEntry():
return $default(_that.id,_that.code,_that.cuisineId,_that.imageAsset,_that.primaryIngredientIds,_that.mayContainIngredientIds,_that.allergenIds,_that.mayContainAllergenIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  int? cuisineId,  String? imageAsset,  List<int> primaryIngredientIds,  List<int> mayContainIngredientIds,  List<int> allergenIds,  List<int> mayContainAllergenIds)?  $default,) {final _that = this;
switch (_that) {
case _FoodItemEntry() when $default != null:
return $default(_that.id,_that.code,_that.cuisineId,_that.imageAsset,_that.primaryIngredientIds,_that.mayContainIngredientIds,_that.allergenIds,_that.mayContainAllergenIds);case _:
  return null;

}
}

}

/// @nodoc


class _FoodItemEntry implements FoodItemEntry {
  const _FoodItemEntry({required this.id, required this.code, this.cuisineId, this.imageAsset, final  List<int> primaryIngredientIds = const [], final  List<int> mayContainIngredientIds = const [], final  List<int> allergenIds = const [], final  List<int> mayContainAllergenIds = const []}): _primaryIngredientIds = primaryIngredientIds,_mayContainIngredientIds = mayContainIngredientIds,_allergenIds = allergenIds,_mayContainAllergenIds = mayContainAllergenIds;
  

@override final  int id;
@override final  String code;
@override final  int? cuisineId;
@override final  String? imageAsset;
 final  List<int> _primaryIngredientIds;
@override@JsonKey() List<int> get primaryIngredientIds {
  if (_primaryIngredientIds is EqualUnmodifiableListView) return _primaryIngredientIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryIngredientIds);
}

 final  List<int> _mayContainIngredientIds;
@override@JsonKey() List<int> get mayContainIngredientIds {
  if (_mayContainIngredientIds is EqualUnmodifiableListView) return _mayContainIngredientIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mayContainIngredientIds);
}

 final  List<int> _allergenIds;
@override@JsonKey() List<int> get allergenIds {
  if (_allergenIds is EqualUnmodifiableListView) return _allergenIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allergenIds);
}

 final  List<int> _mayContainAllergenIds;
@override@JsonKey() List<int> get mayContainAllergenIds {
  if (_mayContainAllergenIds is EqualUnmodifiableListView) return _mayContainAllergenIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mayContainAllergenIds);
}


/// Create a copy of FoodItemEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodItemEntryCopyWith<_FoodItemEntry> get copyWith => __$FoodItemEntryCopyWithImpl<_FoodItemEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodItemEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.cuisineId, cuisineId) || other.cuisineId == cuisineId)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&const DeepCollectionEquality().equals(other._primaryIngredientIds, _primaryIngredientIds)&&const DeepCollectionEquality().equals(other._mayContainIngredientIds, _mayContainIngredientIds)&&const DeepCollectionEquality().equals(other._allergenIds, _allergenIds)&&const DeepCollectionEquality().equals(other._mayContainAllergenIds, _mayContainAllergenIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,cuisineId,imageAsset,const DeepCollectionEquality().hash(_primaryIngredientIds),const DeepCollectionEquality().hash(_mayContainIngredientIds),const DeepCollectionEquality().hash(_allergenIds),const DeepCollectionEquality().hash(_mayContainAllergenIds));

@override
String toString() {
  return 'FoodItemEntry(id: $id, code: $code, cuisineId: $cuisineId, imageAsset: $imageAsset, primaryIngredientIds: $primaryIngredientIds, mayContainIngredientIds: $mayContainIngredientIds, allergenIds: $allergenIds, mayContainAllergenIds: $mayContainAllergenIds)';
}


}

/// @nodoc
abstract mixin class _$FoodItemEntryCopyWith<$Res> implements $FoodItemEntryCopyWith<$Res> {
  factory _$FoodItemEntryCopyWith(_FoodItemEntry value, $Res Function(_FoodItemEntry) _then) = __$FoodItemEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, int? cuisineId, String? imageAsset, List<int> primaryIngredientIds, List<int> mayContainIngredientIds, List<int> allergenIds, List<int> mayContainAllergenIds
});




}
/// @nodoc
class __$FoodItemEntryCopyWithImpl<$Res>
    implements _$FoodItemEntryCopyWith<$Res> {
  __$FoodItemEntryCopyWithImpl(this._self, this._then);

  final _FoodItemEntry _self;
  final $Res Function(_FoodItemEntry) _then;

/// Create a copy of FoodItemEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? cuisineId = freezed,Object? imageAsset = freezed,Object? primaryIngredientIds = null,Object? mayContainIngredientIds = null,Object? allergenIds = null,Object? mayContainAllergenIds = null,}) {
  return _then(_FoodItemEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,cuisineId: freezed == cuisineId ? _self.cuisineId : cuisineId // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,primaryIngredientIds: null == primaryIngredientIds ? _self._primaryIngredientIds : primaryIngredientIds // ignore: cast_nullable_to_non_nullable
as List<int>,mayContainIngredientIds: null == mayContainIngredientIds ? _self._mayContainIngredientIds : mayContainIngredientIds // ignore: cast_nullable_to_non_nullable
as List<int>,allergenIds: null == allergenIds ? _self._allergenIds : allergenIds // ignore: cast_nullable_to_non_nullable
as List<int>,mayContainAllergenIds: null == mayContainAllergenIds ? _self._mayContainAllergenIds : mayContainAllergenIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
mixin _$UserFoodItemPreferenceEntry {

 int get id; int get foodItemId; PreferenceState get preferenceState; PreferenceSource get source;
/// Create a copy of UserFoodItemPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFoodItemPreferenceEntryCopyWith<UserFoodItemPreferenceEntry> get copyWith => _$UserFoodItemPreferenceEntryCopyWithImpl<UserFoodItemPreferenceEntry>(this as UserFoodItemPreferenceEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFoodItemPreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.preferenceState, preferenceState) || other.preferenceState == preferenceState)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,preferenceState,source);

@override
String toString() {
  return 'UserFoodItemPreferenceEntry(id: $id, foodItemId: $foodItemId, preferenceState: $preferenceState, source: $source)';
}


}

/// @nodoc
abstract mixin class $UserFoodItemPreferenceEntryCopyWith<$Res>  {
  factory $UserFoodItemPreferenceEntryCopyWith(UserFoodItemPreferenceEntry value, $Res Function(UserFoodItemPreferenceEntry) _then) = _$UserFoodItemPreferenceEntryCopyWithImpl;
@useResult
$Res call({
 int id, int foodItemId, PreferenceState preferenceState, PreferenceSource source
});




}
/// @nodoc
class _$UserFoodItemPreferenceEntryCopyWithImpl<$Res>
    implements $UserFoodItemPreferenceEntryCopyWith<$Res> {
  _$UserFoodItemPreferenceEntryCopyWithImpl(this._self, this._then);

  final UserFoodItemPreferenceEntry _self;
  final $Res Function(UserFoodItemPreferenceEntry) _then;

/// Create a copy of UserFoodItemPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? foodItemId = null,Object? preferenceState = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,foodItemId: null == foodItemId ? _self.foodItemId : foodItemId // ignore: cast_nullable_to_non_nullable
as int,preferenceState: null == preferenceState ? _self.preferenceState : preferenceState // ignore: cast_nullable_to_non_nullable
as PreferenceState,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFoodItemPreferenceEntry].
extension UserFoodItemPreferenceEntryPatterns on UserFoodItemPreferenceEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFoodItemPreferenceEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFoodItemPreferenceEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFoodItemPreferenceEntry value)  $default,){
final _that = this;
switch (_that) {
case _UserFoodItemPreferenceEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFoodItemPreferenceEntry value)?  $default,){
final _that = this;
switch (_that) {
case _UserFoodItemPreferenceEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int foodItemId,  PreferenceState preferenceState,  PreferenceSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFoodItemPreferenceEntry() when $default != null:
return $default(_that.id,_that.foodItemId,_that.preferenceState,_that.source);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int foodItemId,  PreferenceState preferenceState,  PreferenceSource source)  $default,) {final _that = this;
switch (_that) {
case _UserFoodItemPreferenceEntry():
return $default(_that.id,_that.foodItemId,_that.preferenceState,_that.source);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int foodItemId,  PreferenceState preferenceState,  PreferenceSource source)?  $default,) {final _that = this;
switch (_that) {
case _UserFoodItemPreferenceEntry() when $default != null:
return $default(_that.id,_that.foodItemId,_that.preferenceState,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _UserFoodItemPreferenceEntry implements UserFoodItemPreferenceEntry {
  const _UserFoodItemPreferenceEntry({required this.id, required this.foodItemId, required this.preferenceState, required this.source});
  

@override final  int id;
@override final  int foodItemId;
@override final  PreferenceState preferenceState;
@override final  PreferenceSource source;

/// Create a copy of UserFoodItemPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFoodItemPreferenceEntryCopyWith<_UserFoodItemPreferenceEntry> get copyWith => __$UserFoodItemPreferenceEntryCopyWithImpl<_UserFoodItemPreferenceEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFoodItemPreferenceEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.preferenceState, preferenceState) || other.preferenceState == preferenceState)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,preferenceState,source);

@override
String toString() {
  return 'UserFoodItemPreferenceEntry(id: $id, foodItemId: $foodItemId, preferenceState: $preferenceState, source: $source)';
}


}

/// @nodoc
abstract mixin class _$UserFoodItemPreferenceEntryCopyWith<$Res> implements $UserFoodItemPreferenceEntryCopyWith<$Res> {
  factory _$UserFoodItemPreferenceEntryCopyWith(_UserFoodItemPreferenceEntry value, $Res Function(_UserFoodItemPreferenceEntry) _then) = __$UserFoodItemPreferenceEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, int foodItemId, PreferenceState preferenceState, PreferenceSource source
});




}
/// @nodoc
class __$UserFoodItemPreferenceEntryCopyWithImpl<$Res>
    implements _$UserFoodItemPreferenceEntryCopyWith<$Res> {
  __$UserFoodItemPreferenceEntryCopyWithImpl(this._self, this._then);

  final _UserFoodItemPreferenceEntry _self;
  final $Res Function(_UserFoodItemPreferenceEntry) _then;

/// Create a copy of UserFoodItemPreferenceEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? foodItemId = null,Object? preferenceState = null,Object? source = null,}) {
  return _then(_UserFoodItemPreferenceEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,foodItemId: null == foodItemId ? _self.foodItemId : foodItemId // ignore: cast_nullable_to_non_nullable
as int,preferenceState: null == preferenceState ? _self.preferenceState : preferenceState // ignore: cast_nullable_to_non_nullable
as PreferenceState,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PreferenceSource,
  ));
}


}

// dart format on
