// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantSummaryModel {

 int get id;/// 대표 메뉴명. 예: "제육볶음 백반"
 String get menuName;/// 식당명. 예: "정든집 기사식당"
 String get restaurantName;/// 썸네일 이미지 URL.
 String get thumbnailUrl;/// 평점(0.0~5.0). 예: 4.7
 double get rating;/// 리뷰 수. 예: 787
 int get reviewCount;/// 현재 위치로부터의 거리(미터). 예: 120
 int get distanceMeters;/// 대표 메뉴 가격(원). 예: 6500
 int get price;/// 자리(좌석) 여유 여부. true 면 "자리 있음" 뱃지 노출.
 bool get seatAvailable;/// 메뉴 분류(카테고리). 카테고리 필터링에 사용.
 FoodCategory get category;
/// Create a copy of RestaurantSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantSummaryModelCopyWith<RestaurantSummaryModel> get copyWith => _$RestaurantSummaryModelCopyWithImpl<RestaurantSummaryModel>(this as RestaurantSummaryModel, _$identity);

  /// Serializes this RestaurantSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.price, price) || other.price == price)&&(identical(other.seatAvailable, seatAvailable) || other.seatAvailable == seatAvailable)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,menuName,restaurantName,thumbnailUrl,rating,reviewCount,distanceMeters,price,seatAvailable,category);

@override
String toString() {
  return 'RestaurantSummaryModel(id: $id, menuName: $menuName, restaurantName: $restaurantName, thumbnailUrl: $thumbnailUrl, rating: $rating, reviewCount: $reviewCount, distanceMeters: $distanceMeters, price: $price, seatAvailable: $seatAvailable, category: $category)';
}


}

/// @nodoc
abstract mixin class $RestaurantSummaryModelCopyWith<$Res>  {
  factory $RestaurantSummaryModelCopyWith(RestaurantSummaryModel value, $Res Function(RestaurantSummaryModel) _then) = _$RestaurantSummaryModelCopyWithImpl;
@useResult
$Res call({
 int id, String menuName, String restaurantName, String thumbnailUrl, double rating, int reviewCount, int distanceMeters, int price, bool seatAvailable, FoodCategory category
});




}
/// @nodoc
class _$RestaurantSummaryModelCopyWithImpl<$Res>
    implements $RestaurantSummaryModelCopyWith<$Res> {
  _$RestaurantSummaryModelCopyWithImpl(this._self, this._then);

  final RestaurantSummaryModel _self;
  final $Res Function(RestaurantSummaryModel) _then;

/// Create a copy of RestaurantSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? menuName = null,Object? restaurantName = null,Object? thumbnailUrl = null,Object? rating = null,Object? reviewCount = null,Object? distanceMeters = null,Object? price = null,Object? seatAvailable = null,Object? category = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,menuName: null == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,seatAvailable: null == seatAvailable ? _self.seatAvailable : seatAvailable // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as FoodCategory,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantSummaryModel].
extension RestaurantSummaryModelPatterns on RestaurantSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String menuName,  String restaurantName,  String thumbnailUrl,  double rating,  int reviewCount,  int distanceMeters,  int price,  bool seatAvailable,  FoodCategory category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantSummaryModel() when $default != null:
return $default(_that.id,_that.menuName,_that.restaurantName,_that.thumbnailUrl,_that.rating,_that.reviewCount,_that.distanceMeters,_that.price,_that.seatAvailable,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String menuName,  String restaurantName,  String thumbnailUrl,  double rating,  int reviewCount,  int distanceMeters,  int price,  bool seatAvailable,  FoodCategory category)  $default,) {final _that = this;
switch (_that) {
case _RestaurantSummaryModel():
return $default(_that.id,_that.menuName,_that.restaurantName,_that.thumbnailUrl,_that.rating,_that.reviewCount,_that.distanceMeters,_that.price,_that.seatAvailable,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String menuName,  String restaurantName,  String thumbnailUrl,  double rating,  int reviewCount,  int distanceMeters,  int price,  bool seatAvailable,  FoodCategory category)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantSummaryModel() when $default != null:
return $default(_that.id,_that.menuName,_that.restaurantName,_that.thumbnailUrl,_that.rating,_that.reviewCount,_that.distanceMeters,_that.price,_that.seatAvailable,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantSummaryModel implements RestaurantSummaryModel {
  const _RestaurantSummaryModel({required this.id, required this.menuName, required this.restaurantName, required this.thumbnailUrl, required this.rating, required this.reviewCount, required this.distanceMeters, required this.price, required this.seatAvailable, required this.category});
  factory _RestaurantSummaryModel.fromJson(Map<String, dynamic> json) => _$RestaurantSummaryModelFromJson(json);

@override final  int id;
/// 대표 메뉴명. 예: "제육볶음 백반"
@override final  String menuName;
/// 식당명. 예: "정든집 기사식당"
@override final  String restaurantName;
/// 썸네일 이미지 URL.
@override final  String thumbnailUrl;
/// 평점(0.0~5.0). 예: 4.7
@override final  double rating;
/// 리뷰 수. 예: 787
@override final  int reviewCount;
/// 현재 위치로부터의 거리(미터). 예: 120
@override final  int distanceMeters;
/// 대표 메뉴 가격(원). 예: 6500
@override final  int price;
/// 자리(좌석) 여유 여부. true 면 "자리 있음" 뱃지 노출.
@override final  bool seatAvailable;
/// 메뉴 분류(카테고리). 카테고리 필터링에 사용.
@override final  FoodCategory category;

/// Create a copy of RestaurantSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantSummaryModelCopyWith<_RestaurantSummaryModel> get copyWith => __$RestaurantSummaryModelCopyWithImpl<_RestaurantSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.price, price) || other.price == price)&&(identical(other.seatAvailable, seatAvailable) || other.seatAvailable == seatAvailable)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,menuName,restaurantName,thumbnailUrl,rating,reviewCount,distanceMeters,price,seatAvailable,category);

@override
String toString() {
  return 'RestaurantSummaryModel(id: $id, menuName: $menuName, restaurantName: $restaurantName, thumbnailUrl: $thumbnailUrl, rating: $rating, reviewCount: $reviewCount, distanceMeters: $distanceMeters, price: $price, seatAvailable: $seatAvailable, category: $category)';
}


}

/// @nodoc
abstract mixin class _$RestaurantSummaryModelCopyWith<$Res> implements $RestaurantSummaryModelCopyWith<$Res> {
  factory _$RestaurantSummaryModelCopyWith(_RestaurantSummaryModel value, $Res Function(_RestaurantSummaryModel) _then) = __$RestaurantSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String menuName, String restaurantName, String thumbnailUrl, double rating, int reviewCount, int distanceMeters, int price, bool seatAvailable, FoodCategory category
});




}
/// @nodoc
class __$RestaurantSummaryModelCopyWithImpl<$Res>
    implements _$RestaurantSummaryModelCopyWith<$Res> {
  __$RestaurantSummaryModelCopyWithImpl(this._self, this._then);

  final _RestaurantSummaryModel _self;
  final $Res Function(_RestaurantSummaryModel) _then;

/// Create a copy of RestaurantSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? menuName = null,Object? restaurantName = null,Object? thumbnailUrl = null,Object? rating = null,Object? reviewCount = null,Object? distanceMeters = null,Object? price = null,Object? seatAvailable = null,Object? category = null,}) {
  return _then(_RestaurantSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,menuName: null == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,seatAvailable: null == seatAvailable ? _self.seatAvailable : seatAvailable // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as FoodCategory,
  ));
}


}


/// @nodoc
mixin _$RestaurantSummaryPageModel {

 List<RestaurantSummaryModel> get items; bool get hasNext; int? get nextCursor;
/// Create a copy of RestaurantSummaryPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantSummaryPageModelCopyWith<RestaurantSummaryPageModel> get copyWith => _$RestaurantSummaryPageModelCopyWithImpl<RestaurantSummaryPageModel>(this as RestaurantSummaryPageModel, _$identity);

  /// Serializes this RestaurantSummaryPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantSummaryPageModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),hasNext,nextCursor);

@override
String toString() {
  return 'RestaurantSummaryPageModel(items: $items, hasNext: $hasNext, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $RestaurantSummaryPageModelCopyWith<$Res>  {
  factory $RestaurantSummaryPageModelCopyWith(RestaurantSummaryPageModel value, $Res Function(RestaurantSummaryPageModel) _then) = _$RestaurantSummaryPageModelCopyWithImpl;
@useResult
$Res call({
 List<RestaurantSummaryModel> items, bool hasNext, int? nextCursor
});




}
/// @nodoc
class _$RestaurantSummaryPageModelCopyWithImpl<$Res>
    implements $RestaurantSummaryPageModelCopyWith<$Res> {
  _$RestaurantSummaryPageModelCopyWithImpl(this._self, this._then);

  final RestaurantSummaryPageModel _self;
  final $Res Function(RestaurantSummaryPageModel) _then;

/// Create a copy of RestaurantSummaryPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? hasNext = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RestaurantSummaryModel>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantSummaryPageModel].
extension RestaurantSummaryPageModelPatterns on RestaurantSummaryPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantSummaryPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantSummaryPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantSummaryPageModel value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantSummaryPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantSummaryPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantSummaryPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RestaurantSummaryModel> items,  bool hasNext,  int? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantSummaryPageModel() when $default != null:
return $default(_that.items,_that.hasNext,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RestaurantSummaryModel> items,  bool hasNext,  int? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _RestaurantSummaryPageModel():
return $default(_that.items,_that.hasNext,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RestaurantSummaryModel> items,  bool hasNext,  int? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantSummaryPageModel() when $default != null:
return $default(_that.items,_that.hasNext,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantSummaryPageModel implements RestaurantSummaryPageModel {
  const _RestaurantSummaryPageModel({required final  List<RestaurantSummaryModel> items, required this.hasNext, this.nextCursor}): _items = items;
  factory _RestaurantSummaryPageModel.fromJson(Map<String, dynamic> json) => _$RestaurantSummaryPageModelFromJson(json);

 final  List<RestaurantSummaryModel> _items;
@override List<RestaurantSummaryModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool hasNext;
@override final  int? nextCursor;

/// Create a copy of RestaurantSummaryPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantSummaryPageModelCopyWith<_RestaurantSummaryPageModel> get copyWith => __$RestaurantSummaryPageModelCopyWithImpl<_RestaurantSummaryPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantSummaryPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantSummaryPageModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),hasNext,nextCursor);

@override
String toString() {
  return 'RestaurantSummaryPageModel(items: $items, hasNext: $hasNext, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$RestaurantSummaryPageModelCopyWith<$Res> implements $RestaurantSummaryPageModelCopyWith<$Res> {
  factory _$RestaurantSummaryPageModelCopyWith(_RestaurantSummaryPageModel value, $Res Function(_RestaurantSummaryPageModel) _then) = __$RestaurantSummaryPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<RestaurantSummaryModel> items, bool hasNext, int? nextCursor
});




}
/// @nodoc
class __$RestaurantSummaryPageModelCopyWithImpl<$Res>
    implements _$RestaurantSummaryPageModelCopyWith<$Res> {
  __$RestaurantSummaryPageModelCopyWithImpl(this._self, this._then);

  final _RestaurantSummaryPageModel _self;
  final $Res Function(_RestaurantSummaryPageModel) _then;

/// Create a copy of RestaurantSummaryPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? hasNext = null,Object? nextCursor = freezed,}) {
  return _then(_RestaurantSummaryPageModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RestaurantSummaryModel>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
