// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantDetailModel {

 int get id;/// 행정 구역. 예: "안산시 단원구"
 String get region;/// 상세 주소. 예: "사회공단 4단지 203동"
 String get address;/// 현재 영업 여부. true 면 "영업중"(초록) 표시.
 bool get isOpen;/// 영업시간 안내. 예: "평일 11:00~14:00"
 String get businessHours;/// 전화번호. 예: "031-1234-5678"
 String get phone;/// 상단 사진 캐러셀 이미지 URL 목록.
 List<String> get photos;/// 식당 속성 태그. 예: ["국물 좋음", "넉넉한 양", "배달 가능", "현금 할인"]
 List<String> get tags;/// 이번 주 식단(요일별).
 List<WeeklyMenuModel> get weeklyMenus;/// "한 줄 리뷰" 상단 사진 모음 URL.
 List<String> get reviewPhotos;/// 한 줄 리뷰 목록.
 List<RestaurantReviewModel> get reviews;
/// Create a copy of RestaurantDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantDetailModelCopyWith<RestaurantDetailModel> get copyWith => _$RestaurantDetailModelCopyWithImpl<RestaurantDetailModel>(this as RestaurantDetailModel, _$identity);

  /// Serializes this RestaurantDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.region, region) || other.region == region)&&(identical(other.address, address) || other.address == address)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.businessHours, businessHours) || other.businessHours == businessHours)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.photos, photos)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.weeklyMenus, weeklyMenus)&&const DeepCollectionEquality().equals(other.reviewPhotos, reviewPhotos)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,region,address,isOpen,businessHours,phone,const DeepCollectionEquality().hash(photos),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(weeklyMenus),const DeepCollectionEquality().hash(reviewPhotos),const DeepCollectionEquality().hash(reviews));

@override
String toString() {
  return 'RestaurantDetailModel(id: $id, region: $region, address: $address, isOpen: $isOpen, businessHours: $businessHours, phone: $phone, photos: $photos, tags: $tags, weeklyMenus: $weeklyMenus, reviewPhotos: $reviewPhotos, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $RestaurantDetailModelCopyWith<$Res>  {
  factory $RestaurantDetailModelCopyWith(RestaurantDetailModel value, $Res Function(RestaurantDetailModel) _then) = _$RestaurantDetailModelCopyWithImpl;
@useResult
$Res call({
 int id, String region, String address, bool isOpen, String businessHours, String phone, List<String> photos, List<String> tags, List<WeeklyMenuModel> weeklyMenus, List<String> reviewPhotos, List<RestaurantReviewModel> reviews
});




}
/// @nodoc
class _$RestaurantDetailModelCopyWithImpl<$Res>
    implements $RestaurantDetailModelCopyWith<$Res> {
  _$RestaurantDetailModelCopyWithImpl(this._self, this._then);

  final RestaurantDetailModel _self;
  final $Res Function(RestaurantDetailModel) _then;

/// Create a copy of RestaurantDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? region = null,Object? address = null,Object? isOpen = null,Object? businessHours = null,Object? phone = null,Object? photos = null,Object? tags = null,Object? weeklyMenus = null,Object? reviewPhotos = null,Object? reviews = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,businessHours: null == businessHours ? _self.businessHours : businessHours // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,weeklyMenus: null == weeklyMenus ? _self.weeklyMenus : weeklyMenus // ignore: cast_nullable_to_non_nullable
as List<WeeklyMenuModel>,reviewPhotos: null == reviewPhotos ? _self.reviewPhotos : reviewPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<RestaurantReviewModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantDetailModel].
extension RestaurantDetailModelPatterns on RestaurantDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String region,  String address,  bool isOpen,  String businessHours,  String phone,  List<String> photos,  List<String> tags,  List<WeeklyMenuModel> weeklyMenus,  List<String> reviewPhotos,  List<RestaurantReviewModel> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantDetailModel() when $default != null:
return $default(_that.id,_that.region,_that.address,_that.isOpen,_that.businessHours,_that.phone,_that.photos,_that.tags,_that.weeklyMenus,_that.reviewPhotos,_that.reviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String region,  String address,  bool isOpen,  String businessHours,  String phone,  List<String> photos,  List<String> tags,  List<WeeklyMenuModel> weeklyMenus,  List<String> reviewPhotos,  List<RestaurantReviewModel> reviews)  $default,) {final _that = this;
switch (_that) {
case _RestaurantDetailModel():
return $default(_that.id,_that.region,_that.address,_that.isOpen,_that.businessHours,_that.phone,_that.photos,_that.tags,_that.weeklyMenus,_that.reviewPhotos,_that.reviews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String region,  String address,  bool isOpen,  String businessHours,  String phone,  List<String> photos,  List<String> tags,  List<WeeklyMenuModel> weeklyMenus,  List<String> reviewPhotos,  List<RestaurantReviewModel> reviews)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantDetailModel() when $default != null:
return $default(_that.id,_that.region,_that.address,_that.isOpen,_that.businessHours,_that.phone,_that.photos,_that.tags,_that.weeklyMenus,_that.reviewPhotos,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantDetailModel implements RestaurantDetailModel {
  const _RestaurantDetailModel({required this.id, required this.region, required this.address, required this.isOpen, required this.businessHours, required this.phone, required final  List<String> photos, required final  List<String> tags, required final  List<WeeklyMenuModel> weeklyMenus, required final  List<String> reviewPhotos, required final  List<RestaurantReviewModel> reviews}): _photos = photos,_tags = tags,_weeklyMenus = weeklyMenus,_reviewPhotos = reviewPhotos,_reviews = reviews;
  factory _RestaurantDetailModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailModelFromJson(json);

@override final  int id;
/// 행정 구역. 예: "안산시 단원구"
@override final  String region;
/// 상세 주소. 예: "사회공단 4단지 203동"
@override final  String address;
/// 현재 영업 여부. true 면 "영업중"(초록) 표시.
@override final  bool isOpen;
/// 영업시간 안내. 예: "평일 11:00~14:00"
@override final  String businessHours;
/// 전화번호. 예: "031-1234-5678"
@override final  String phone;
/// 상단 사진 캐러셀 이미지 URL 목록.
 final  List<String> _photos;
/// 상단 사진 캐러셀 이미지 URL 목록.
@override List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

/// 식당 속성 태그. 예: ["국물 좋음", "넉넉한 양", "배달 가능", "현금 할인"]
 final  List<String> _tags;
/// 식당 속성 태그. 예: ["국물 좋음", "넉넉한 양", "배달 가능", "현금 할인"]
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// 이번 주 식단(요일별).
 final  List<WeeklyMenuModel> _weeklyMenus;
/// 이번 주 식단(요일별).
@override List<WeeklyMenuModel> get weeklyMenus {
  if (_weeklyMenus is EqualUnmodifiableListView) return _weeklyMenus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyMenus);
}

/// "한 줄 리뷰" 상단 사진 모음 URL.
 final  List<String> _reviewPhotos;
/// "한 줄 리뷰" 상단 사진 모음 URL.
@override List<String> get reviewPhotos {
  if (_reviewPhotos is EqualUnmodifiableListView) return _reviewPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviewPhotos);
}

/// 한 줄 리뷰 목록.
 final  List<RestaurantReviewModel> _reviews;
/// 한 줄 리뷰 목록.
@override List<RestaurantReviewModel> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of RestaurantDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantDetailModelCopyWith<_RestaurantDetailModel> get copyWith => __$RestaurantDetailModelCopyWithImpl<_RestaurantDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.region, region) || other.region == region)&&(identical(other.address, address) || other.address == address)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.businessHours, businessHours) || other.businessHours == businessHours)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other._photos, _photos)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._weeklyMenus, _weeklyMenus)&&const DeepCollectionEquality().equals(other._reviewPhotos, _reviewPhotos)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,region,address,isOpen,businessHours,phone,const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_weeklyMenus),const DeepCollectionEquality().hash(_reviewPhotos),const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'RestaurantDetailModel(id: $id, region: $region, address: $address, isOpen: $isOpen, businessHours: $businessHours, phone: $phone, photos: $photos, tags: $tags, weeklyMenus: $weeklyMenus, reviewPhotos: $reviewPhotos, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$RestaurantDetailModelCopyWith<$Res> implements $RestaurantDetailModelCopyWith<$Res> {
  factory _$RestaurantDetailModelCopyWith(_RestaurantDetailModel value, $Res Function(_RestaurantDetailModel) _then) = __$RestaurantDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String region, String address, bool isOpen, String businessHours, String phone, List<String> photos, List<String> tags, List<WeeklyMenuModel> weeklyMenus, List<String> reviewPhotos, List<RestaurantReviewModel> reviews
});




}
/// @nodoc
class __$RestaurantDetailModelCopyWithImpl<$Res>
    implements _$RestaurantDetailModelCopyWith<$Res> {
  __$RestaurantDetailModelCopyWithImpl(this._self, this._then);

  final _RestaurantDetailModel _self;
  final $Res Function(_RestaurantDetailModel) _then;

/// Create a copy of RestaurantDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? region = null,Object? address = null,Object? isOpen = null,Object? businessHours = null,Object? phone = null,Object? photos = null,Object? tags = null,Object? weeklyMenus = null,Object? reviewPhotos = null,Object? reviews = null,}) {
  return _then(_RestaurantDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,businessHours: null == businessHours ? _self.businessHours : businessHours // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,weeklyMenus: null == weeklyMenus ? _self._weeklyMenus : weeklyMenus // ignore: cast_nullable_to_non_nullable
as List<WeeklyMenuModel>,reviewPhotos: null == reviewPhotos ? _self._reviewPhotos : reviewPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<RestaurantReviewModel>,
  ));
}


}


/// @nodoc
mixin _$WeeklyMenuModel {

/// 일(day). 예: 19
 int get date;/// 요일 라벨. 예: "수"
 String get weekday;/// 오늘(=기본 선택) 여부. 상단에 점 표시 + 강조 색.
 bool get isToday;/// 대표 메뉴 썸네일 URL.
 String get thumbnailUrl;/// 대표 메뉴명. 예: "김치찌개"
 String get menuName;/// 구성 반찬. 예: ["제육볶음", "대파계란말이", ...]
 List<String> get sideDishes;/// 가격(원). 예: 6500
 int get price;
/// Create a copy of WeeklyMenuModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyMenuModelCopyWith<WeeklyMenuModel> get copyWith => _$WeeklyMenuModelCopyWithImpl<WeeklyMenuModel>(this as WeeklyMenuModel, _$identity);

  /// Serializes this WeeklyMenuModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyMenuModel&&(identical(other.date, date) || other.date == date)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&const DeepCollectionEquality().equals(other.sideDishes, sideDishes)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,weekday,isToday,thumbnailUrl,menuName,const DeepCollectionEquality().hash(sideDishes),price);

@override
String toString() {
  return 'WeeklyMenuModel(date: $date, weekday: $weekday, isToday: $isToday, thumbnailUrl: $thumbnailUrl, menuName: $menuName, sideDishes: $sideDishes, price: $price)';
}


}

/// @nodoc
abstract mixin class $WeeklyMenuModelCopyWith<$Res>  {
  factory $WeeklyMenuModelCopyWith(WeeklyMenuModel value, $Res Function(WeeklyMenuModel) _then) = _$WeeklyMenuModelCopyWithImpl;
@useResult
$Res call({
 int date, String weekday, bool isToday, String thumbnailUrl, String menuName, List<String> sideDishes, int price
});




}
/// @nodoc
class _$WeeklyMenuModelCopyWithImpl<$Res>
    implements $WeeklyMenuModelCopyWith<$Res> {
  _$WeeklyMenuModelCopyWithImpl(this._self, this._then);

  final WeeklyMenuModel _self;
  final $Res Function(WeeklyMenuModel) _then;

/// Create a copy of WeeklyMenuModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? weekday = null,Object? isToday = null,Object? thumbnailUrl = null,Object? menuName = null,Object? sideDishes = null,Object? price = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as String,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,menuName: null == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String,sideDishes: null == sideDishes ? _self.sideDishes : sideDishes // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyMenuModel].
extension WeeklyMenuModelPatterns on WeeklyMenuModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyMenuModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyMenuModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyMenuModel value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyMenuModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyMenuModel value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyMenuModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int date,  String weekday,  bool isToday,  String thumbnailUrl,  String menuName,  List<String> sideDishes,  int price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyMenuModel() when $default != null:
return $default(_that.date,_that.weekday,_that.isToday,_that.thumbnailUrl,_that.menuName,_that.sideDishes,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int date,  String weekday,  bool isToday,  String thumbnailUrl,  String menuName,  List<String> sideDishes,  int price)  $default,) {final _that = this;
switch (_that) {
case _WeeklyMenuModel():
return $default(_that.date,_that.weekday,_that.isToday,_that.thumbnailUrl,_that.menuName,_that.sideDishes,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int date,  String weekday,  bool isToday,  String thumbnailUrl,  String menuName,  List<String> sideDishes,  int price)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyMenuModel() when $default != null:
return $default(_that.date,_that.weekday,_that.isToday,_that.thumbnailUrl,_that.menuName,_that.sideDishes,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyMenuModel implements WeeklyMenuModel {
  const _WeeklyMenuModel({required this.date, required this.weekday, required this.isToday, required this.thumbnailUrl, required this.menuName, required final  List<String> sideDishes, required this.price}): _sideDishes = sideDishes;
  factory _WeeklyMenuModel.fromJson(Map<String, dynamic> json) => _$WeeklyMenuModelFromJson(json);

/// 일(day). 예: 19
@override final  int date;
/// 요일 라벨. 예: "수"
@override final  String weekday;
/// 오늘(=기본 선택) 여부. 상단에 점 표시 + 강조 색.
@override final  bool isToday;
/// 대표 메뉴 썸네일 URL.
@override final  String thumbnailUrl;
/// 대표 메뉴명. 예: "김치찌개"
@override final  String menuName;
/// 구성 반찬. 예: ["제육볶음", "대파계란말이", ...]
 final  List<String> _sideDishes;
/// 구성 반찬. 예: ["제육볶음", "대파계란말이", ...]
@override List<String> get sideDishes {
  if (_sideDishes is EqualUnmodifiableListView) return _sideDishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sideDishes);
}

/// 가격(원). 예: 6500
@override final  int price;

/// Create a copy of WeeklyMenuModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyMenuModelCopyWith<_WeeklyMenuModel> get copyWith => __$WeeklyMenuModelCopyWithImpl<_WeeklyMenuModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyMenuModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyMenuModel&&(identical(other.date, date) || other.date == date)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&const DeepCollectionEquality().equals(other._sideDishes, _sideDishes)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,weekday,isToday,thumbnailUrl,menuName,const DeepCollectionEquality().hash(_sideDishes),price);

@override
String toString() {
  return 'WeeklyMenuModel(date: $date, weekday: $weekday, isToday: $isToday, thumbnailUrl: $thumbnailUrl, menuName: $menuName, sideDishes: $sideDishes, price: $price)';
}


}

/// @nodoc
abstract mixin class _$WeeklyMenuModelCopyWith<$Res> implements $WeeklyMenuModelCopyWith<$Res> {
  factory _$WeeklyMenuModelCopyWith(_WeeklyMenuModel value, $Res Function(_WeeklyMenuModel) _then) = __$WeeklyMenuModelCopyWithImpl;
@override @useResult
$Res call({
 int date, String weekday, bool isToday, String thumbnailUrl, String menuName, List<String> sideDishes, int price
});




}
/// @nodoc
class __$WeeklyMenuModelCopyWithImpl<$Res>
    implements _$WeeklyMenuModelCopyWith<$Res> {
  __$WeeklyMenuModelCopyWithImpl(this._self, this._then);

  final _WeeklyMenuModel _self;
  final $Res Function(_WeeklyMenuModel) _then;

/// Create a copy of WeeklyMenuModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? weekday = null,Object? isToday = null,Object? thumbnailUrl = null,Object? menuName = null,Object? sideDishes = null,Object? price = null,}) {
  return _then(_WeeklyMenuModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as String,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,menuName: null == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String,sideDishes: null == sideDishes ? _self._sideDishes : sideDishes // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RestaurantReviewModel {

/// 작성자(마스킹) 이름. 예: "박OO"
 String get userName;/// 작성자 프로필 이미지 URL.
 String get avatarUrl;/// 상대 시간. 예: "3일 전"
 String get relativeTime;/// 평점(0.0~5.0). 예: 5.0
 double get rating;/// 리뷰 본문.
 String get content;
/// Create a copy of RestaurantReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantReviewModelCopyWith<RestaurantReviewModel> get copyWith => _$RestaurantReviewModelCopyWithImpl<RestaurantReviewModel>(this as RestaurantReviewModel, _$identity);

  /// Serializes this RestaurantReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantReviewModel&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.relativeTime, relativeTime) || other.relativeTime == relativeTime)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,avatarUrl,relativeTime,rating,content);

@override
String toString() {
  return 'RestaurantReviewModel(userName: $userName, avatarUrl: $avatarUrl, relativeTime: $relativeTime, rating: $rating, content: $content)';
}


}

/// @nodoc
abstract mixin class $RestaurantReviewModelCopyWith<$Res>  {
  factory $RestaurantReviewModelCopyWith(RestaurantReviewModel value, $Res Function(RestaurantReviewModel) _then) = _$RestaurantReviewModelCopyWithImpl;
@useResult
$Res call({
 String userName, String avatarUrl, String relativeTime, double rating, String content
});




}
/// @nodoc
class _$RestaurantReviewModelCopyWithImpl<$Res>
    implements $RestaurantReviewModelCopyWith<$Res> {
  _$RestaurantReviewModelCopyWithImpl(this._self, this._then);

  final RestaurantReviewModel _self;
  final $Res Function(RestaurantReviewModel) _then;

/// Create a copy of RestaurantReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = null,Object? avatarUrl = null,Object? relativeTime = null,Object? rating = null,Object? content = null,}) {
  return _then(_self.copyWith(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,relativeTime: null == relativeTime ? _self.relativeTime : relativeTime // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantReviewModel].
extension RestaurantReviewModelPatterns on RestaurantReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userName,  String avatarUrl,  String relativeTime,  double rating,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantReviewModel() when $default != null:
return $default(_that.userName,_that.avatarUrl,_that.relativeTime,_that.rating,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userName,  String avatarUrl,  String relativeTime,  double rating,  String content)  $default,) {final _that = this;
switch (_that) {
case _RestaurantReviewModel():
return $default(_that.userName,_that.avatarUrl,_that.relativeTime,_that.rating,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userName,  String avatarUrl,  String relativeTime,  double rating,  String content)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantReviewModel() when $default != null:
return $default(_that.userName,_that.avatarUrl,_that.relativeTime,_that.rating,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantReviewModel implements RestaurantReviewModel {
  const _RestaurantReviewModel({required this.userName, required this.avatarUrl, required this.relativeTime, required this.rating, required this.content});
  factory _RestaurantReviewModel.fromJson(Map<String, dynamic> json) => _$RestaurantReviewModelFromJson(json);

/// 작성자(마스킹) 이름. 예: "박OO"
@override final  String userName;
/// 작성자 프로필 이미지 URL.
@override final  String avatarUrl;
/// 상대 시간. 예: "3일 전"
@override final  String relativeTime;
/// 평점(0.0~5.0). 예: 5.0
@override final  double rating;
/// 리뷰 본문.
@override final  String content;

/// Create a copy of RestaurantReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantReviewModelCopyWith<_RestaurantReviewModel> get copyWith => __$RestaurantReviewModelCopyWithImpl<_RestaurantReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantReviewModel&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.relativeTime, relativeTime) || other.relativeTime == relativeTime)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,avatarUrl,relativeTime,rating,content);

@override
String toString() {
  return 'RestaurantReviewModel(userName: $userName, avatarUrl: $avatarUrl, relativeTime: $relativeTime, rating: $rating, content: $content)';
}


}

/// @nodoc
abstract mixin class _$RestaurantReviewModelCopyWith<$Res> implements $RestaurantReviewModelCopyWith<$Res> {
  factory _$RestaurantReviewModelCopyWith(_RestaurantReviewModel value, $Res Function(_RestaurantReviewModel) _then) = __$RestaurantReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String userName, String avatarUrl, String relativeTime, double rating, String content
});




}
/// @nodoc
class __$RestaurantReviewModelCopyWithImpl<$Res>
    implements _$RestaurantReviewModelCopyWith<$Res> {
  __$RestaurantReviewModelCopyWithImpl(this._self, this._then);

  final _RestaurantReviewModel _self;
  final $Res Function(_RestaurantReviewModel) _then;

/// Create a copy of RestaurantReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = null,Object? avatarUrl = null,Object? relativeTime = null,Object? rating = null,Object? content = null,}) {
  return _then(_RestaurantReviewModel(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,relativeTime: null == relativeTime ? _self.relativeTime : relativeTime // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
