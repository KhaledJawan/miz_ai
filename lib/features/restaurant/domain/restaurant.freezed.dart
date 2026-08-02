// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Restaurant {

 String get id; String get name; String get cuisine; String get tag; int get priceTier;// 0 = no limit/no data, 1..3 = €/€€/€€€
 double get rating; double get distanceKm; int get etaMinutes; String get signatureDish; String get recommendationReason; String get reviewQuote; String get reviewer; String get askMizAnswer; String? get imageAsset;
/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantCopyWith<Restaurant> get copyWith => _$RestaurantCopyWithImpl<Restaurant>(this as Restaurant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Restaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.cuisine, cuisine) || other.cuisine == cuisine)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.priceTier, priceTier) || other.priceTier == priceTier)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.etaMinutes, etaMinutes) || other.etaMinutes == etaMinutes)&&(identical(other.signatureDish, signatureDish) || other.signatureDish == signatureDish)&&(identical(other.recommendationReason, recommendationReason) || other.recommendationReason == recommendationReason)&&(identical(other.reviewQuote, reviewQuote) || other.reviewQuote == reviewQuote)&&(identical(other.reviewer, reviewer) || other.reviewer == reviewer)&&(identical(other.askMizAnswer, askMizAnswer) || other.askMizAnswer == askMizAnswer)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,cuisine,tag,priceTier,rating,distanceKm,etaMinutes,signatureDish,recommendationReason,reviewQuote,reviewer,askMizAnswer,imageAsset);

@override
String toString() {
  return 'Restaurant(id: $id, name: $name, cuisine: $cuisine, tag: $tag, priceTier: $priceTier, rating: $rating, distanceKm: $distanceKm, etaMinutes: $etaMinutes, signatureDish: $signatureDish, recommendationReason: $recommendationReason, reviewQuote: $reviewQuote, reviewer: $reviewer, askMizAnswer: $askMizAnswer, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class $RestaurantCopyWith<$Res>  {
  factory $RestaurantCopyWith(Restaurant value, $Res Function(Restaurant) _then) = _$RestaurantCopyWithImpl;
@useResult
$Res call({
 String id, String name, String cuisine, String tag, int priceTier, double rating, double distanceKm, int etaMinutes, String signatureDish, String recommendationReason, String reviewQuote, String reviewer, String askMizAnswer, String? imageAsset
});




}
/// @nodoc
class _$RestaurantCopyWithImpl<$Res>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._self, this._then);

  final Restaurant _self;
  final $Res Function(Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? cuisine = null,Object? tag = null,Object? priceTier = null,Object? rating = null,Object? distanceKm = null,Object? etaMinutes = null,Object? signatureDish = null,Object? recommendationReason = null,Object? reviewQuote = null,Object? reviewer = null,Object? askMizAnswer = null,Object? imageAsset = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cuisine: null == cuisine ? _self.cuisine : cuisine // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,priceTier: null == priceTier ? _self.priceTier : priceTier // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,etaMinutes: null == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int,signatureDish: null == signatureDish ? _self.signatureDish : signatureDish // ignore: cast_nullable_to_non_nullable
as String,recommendationReason: null == recommendationReason ? _self.recommendationReason : recommendationReason // ignore: cast_nullable_to_non_nullable
as String,reviewQuote: null == reviewQuote ? _self.reviewQuote : reviewQuote // ignore: cast_nullable_to_non_nullable
as String,reviewer: null == reviewer ? _self.reviewer : reviewer // ignore: cast_nullable_to_non_nullable
as String,askMizAnswer: null == askMizAnswer ? _self.askMizAnswer : askMizAnswer // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Restaurant].
extension RestaurantPatterns on Restaurant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Restaurant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Restaurant value)  $default,){
final _that = this;
switch (_that) {
case _Restaurant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Restaurant value)?  $default,){
final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String cuisine,  String tag,  int priceTier,  double rating,  double distanceKm,  int etaMinutes,  String signatureDish,  String recommendationReason,  String reviewQuote,  String reviewer,  String askMizAnswer,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
return $default(_that.id,_that.name,_that.cuisine,_that.tag,_that.priceTier,_that.rating,_that.distanceKm,_that.etaMinutes,_that.signatureDish,_that.recommendationReason,_that.reviewQuote,_that.reviewer,_that.askMizAnswer,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String cuisine,  String tag,  int priceTier,  double rating,  double distanceKm,  int etaMinutes,  String signatureDish,  String recommendationReason,  String reviewQuote,  String reviewer,  String askMizAnswer,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _Restaurant():
return $default(_that.id,_that.name,_that.cuisine,_that.tag,_that.priceTier,_that.rating,_that.distanceKm,_that.etaMinutes,_that.signatureDish,_that.recommendationReason,_that.reviewQuote,_that.reviewer,_that.askMizAnswer,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String cuisine,  String tag,  int priceTier,  double rating,  double distanceKm,  int etaMinutes,  String signatureDish,  String recommendationReason,  String reviewQuote,  String reviewer,  String askMizAnswer,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
return $default(_that.id,_that.name,_that.cuisine,_that.tag,_that.priceTier,_that.rating,_that.distanceKm,_that.etaMinutes,_that.signatureDish,_that.recommendationReason,_that.reviewQuote,_that.reviewer,_that.askMizAnswer,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _Restaurant implements Restaurant {
  const _Restaurant({required this.id, required this.name, required this.cuisine, required this.tag, required this.priceTier, required this.rating, required this.distanceKm, required this.etaMinutes, required this.signatureDish, required this.recommendationReason, required this.reviewQuote, required this.reviewer, required this.askMizAnswer, this.imageAsset});
  

@override final  String id;
@override final  String name;
@override final  String cuisine;
@override final  String tag;
@override final  int priceTier;
// 0 = no limit/no data, 1..3 = €/€€/€€€
@override final  double rating;
@override final  double distanceKm;
@override final  int etaMinutes;
@override final  String signatureDish;
@override final  String recommendationReason;
@override final  String reviewQuote;
@override final  String reviewer;
@override final  String askMizAnswer;
@override final  String? imageAsset;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantCopyWith<_Restaurant> get copyWith => __$RestaurantCopyWithImpl<_Restaurant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Restaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.cuisine, cuisine) || other.cuisine == cuisine)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.priceTier, priceTier) || other.priceTier == priceTier)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.etaMinutes, etaMinutes) || other.etaMinutes == etaMinutes)&&(identical(other.signatureDish, signatureDish) || other.signatureDish == signatureDish)&&(identical(other.recommendationReason, recommendationReason) || other.recommendationReason == recommendationReason)&&(identical(other.reviewQuote, reviewQuote) || other.reviewQuote == reviewQuote)&&(identical(other.reviewer, reviewer) || other.reviewer == reviewer)&&(identical(other.askMizAnswer, askMizAnswer) || other.askMizAnswer == askMizAnswer)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,cuisine,tag,priceTier,rating,distanceKm,etaMinutes,signatureDish,recommendationReason,reviewQuote,reviewer,askMizAnswer,imageAsset);

@override
String toString() {
  return 'Restaurant(id: $id, name: $name, cuisine: $cuisine, tag: $tag, priceTier: $priceTier, rating: $rating, distanceKm: $distanceKm, etaMinutes: $etaMinutes, signatureDish: $signatureDish, recommendationReason: $recommendationReason, reviewQuote: $reviewQuote, reviewer: $reviewer, askMizAnswer: $askMizAnswer, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$RestaurantCopyWith<$Res> implements $RestaurantCopyWith<$Res> {
  factory _$RestaurantCopyWith(_Restaurant value, $Res Function(_Restaurant) _then) = __$RestaurantCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String cuisine, String tag, int priceTier, double rating, double distanceKm, int etaMinutes, String signatureDish, String recommendationReason, String reviewQuote, String reviewer, String askMizAnswer, String? imageAsset
});




}
/// @nodoc
class __$RestaurantCopyWithImpl<$Res>
    implements _$RestaurantCopyWith<$Res> {
  __$RestaurantCopyWithImpl(this._self, this._then);

  final _Restaurant _self;
  final $Res Function(_Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? cuisine = null,Object? tag = null,Object? priceTier = null,Object? rating = null,Object? distanceKm = null,Object? etaMinutes = null,Object? signatureDish = null,Object? recommendationReason = null,Object? reviewQuote = null,Object? reviewer = null,Object? askMizAnswer = null,Object? imageAsset = freezed,}) {
  return _then(_Restaurant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cuisine: null == cuisine ? _self.cuisine : cuisine // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,priceTier: null == priceTier ? _self.priceTier : priceTier // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,etaMinutes: null == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int,signatureDish: null == signatureDish ? _self.signatureDish : signatureDish // ignore: cast_nullable_to_non_nullable
as String,recommendationReason: null == recommendationReason ? _self.recommendationReason : recommendationReason // ignore: cast_nullable_to_non_nullable
as String,reviewQuote: null == reviewQuote ? _self.reviewQuote : reviewQuote // ignore: cast_nullable_to_non_nullable
as String,reviewer: null == reviewer ? _self.reviewer : reviewer // ignore: cast_nullable_to_non_nullable
as String,askMizAnswer: null == askMizAnswer ? _self.askMizAnswer : askMizAnswer // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
