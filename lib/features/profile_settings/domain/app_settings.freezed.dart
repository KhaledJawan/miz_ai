// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 String get userName; String get languageCode; bool get darkMode; bool get notificationsEnabled; bool get locationPermissionGranted; bool get rememberPreferences;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.darkMode, darkMode) || other.darkMode == darkMode)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.locationPermissionGranted, locationPermissionGranted) || other.locationPermissionGranted == locationPermissionGranted)&&(identical(other.rememberPreferences, rememberPreferences) || other.rememberPreferences == rememberPreferences));
}


@override
int get hashCode => Object.hash(runtimeType,userName,languageCode,darkMode,notificationsEnabled,locationPermissionGranted,rememberPreferences);

@override
String toString() {
  return 'AppSettings(userName: $userName, languageCode: $languageCode, darkMode: $darkMode, notificationsEnabled: $notificationsEnabled, locationPermissionGranted: $locationPermissionGranted, rememberPreferences: $rememberPreferences)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String userName, String languageCode, bool darkMode, bool notificationsEnabled, bool locationPermissionGranted, bool rememberPreferences
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = null,Object? languageCode = null,Object? darkMode = null,Object? notificationsEnabled = null,Object? locationPermissionGranted = null,Object? rememberPreferences = null,}) {
  return _then(_self.copyWith(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,darkMode: null == darkMode ? _self.darkMode : darkMode // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,locationPermissionGranted: null == locationPermissionGranted ? _self.locationPermissionGranted : locationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,rememberPreferences: null == rememberPreferences ? _self.rememberPreferences : rememberPreferences // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userName,  String languageCode,  bool darkMode,  bool notificationsEnabled,  bool locationPermissionGranted,  bool rememberPreferences)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.userName,_that.languageCode,_that.darkMode,_that.notificationsEnabled,_that.locationPermissionGranted,_that.rememberPreferences);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userName,  String languageCode,  bool darkMode,  bool notificationsEnabled,  bool locationPermissionGranted,  bool rememberPreferences)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.userName,_that.languageCode,_that.darkMode,_that.notificationsEnabled,_that.locationPermissionGranted,_that.rememberPreferences);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userName,  String languageCode,  bool darkMode,  bool notificationsEnabled,  bool locationPermissionGranted,  bool rememberPreferences)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.userName,_that.languageCode,_that.darkMode,_that.notificationsEnabled,_that.locationPermissionGranted,_that.rememberPreferences);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.userName = 'Alex', this.languageCode = 'en', this.darkMode = false, this.notificationsEnabled = true, this.locationPermissionGranted = true, this.rememberPreferences = true});
  

@override@JsonKey() final  String userName;
@override@JsonKey() final  String languageCode;
@override@JsonKey() final  bool darkMode;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool locationPermissionGranted;
@override@JsonKey() final  bool rememberPreferences;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.darkMode, darkMode) || other.darkMode == darkMode)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.locationPermissionGranted, locationPermissionGranted) || other.locationPermissionGranted == locationPermissionGranted)&&(identical(other.rememberPreferences, rememberPreferences) || other.rememberPreferences == rememberPreferences));
}


@override
int get hashCode => Object.hash(runtimeType,userName,languageCode,darkMode,notificationsEnabled,locationPermissionGranted,rememberPreferences);

@override
String toString() {
  return 'AppSettings(userName: $userName, languageCode: $languageCode, darkMode: $darkMode, notificationsEnabled: $notificationsEnabled, locationPermissionGranted: $locationPermissionGranted, rememberPreferences: $rememberPreferences)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String userName, String languageCode, bool darkMode, bool notificationsEnabled, bool locationPermissionGranted, bool rememberPreferences
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = null,Object? languageCode = null,Object? darkMode = null,Object? notificationsEnabled = null,Object? locationPermissionGranted = null,Object? rememberPreferences = null,}) {
  return _then(_AppSettings(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,darkMode: null == darkMode ? _self.darkMode : darkMode // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,locationPermissionGranted: null == locationPermissionGranted ? _self.locationPermissionGranted : locationPermissionGranted // ignore: cast_nullable_to_non_nullable
as bool,rememberPreferences: null == rememberPreferences ? _self.rememberPreferences : rememberPreferences // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
