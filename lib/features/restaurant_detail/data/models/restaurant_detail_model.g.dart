// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantDetailModel _$RestaurantDetailModelFromJson(
  Map<String, dynamic> json,
) => _RestaurantDetailModel(
  id: (json['id'] as num).toInt(),
  region: json['region'] as String,
  address: json['address'] as String,
  isOpen: json['isOpen'] as bool,
  businessHours: json['businessHours'] as String,
  phone: json['phone'] as String,
  photos: (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  weeklyMenus: (json['weeklyMenus'] as List<dynamic>)
      .map((e) => WeeklyMenuModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  reviewPhotos: (json['reviewPhotos'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  reviews: (json['reviews'] as List<dynamic>)
      .map((e) => RestaurantReviewModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RestaurantDetailModelToJson(
  _RestaurantDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'region': instance.region,
  'address': instance.address,
  'isOpen': instance.isOpen,
  'businessHours': instance.businessHours,
  'phone': instance.phone,
  'photos': instance.photos,
  'tags': instance.tags,
  'weeklyMenus': instance.weeklyMenus,
  'reviewPhotos': instance.reviewPhotos,
  'reviews': instance.reviews,
};

_WeeklyMenuModel _$WeeklyMenuModelFromJson(Map<String, dynamic> json) =>
    _WeeklyMenuModel(
      date: (json['date'] as num).toInt(),
      weekday: json['weekday'] as String,
      isToday: json['isToday'] as bool,
      thumbnailUrl: json['thumbnailUrl'] as String,
      menuName: json['menuName'] as String,
      sideDishes: (json['sideDishes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$WeeklyMenuModelToJson(_WeeklyMenuModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'weekday': instance.weekday,
      'isToday': instance.isToday,
      'thumbnailUrl': instance.thumbnailUrl,
      'menuName': instance.menuName,
      'sideDishes': instance.sideDishes,
      'price': instance.price,
    };

_RestaurantReviewModel _$RestaurantReviewModelFromJson(
  Map<String, dynamic> json,
) => _RestaurantReviewModel(
  userName: json['userName'] as String,
  avatarUrl: json['avatarUrl'] as String,
  relativeTime: json['relativeTime'] as String,
  rating: (json['rating'] as num).toDouble(),
  content: json['content'] as String,
);

Map<String, dynamic> _$RestaurantReviewModelToJson(
  _RestaurantReviewModel instance,
) => <String, dynamic>{
  'userName': instance.userName,
  'avatarUrl': instance.avatarUrl,
  'relativeTime': instance.relativeTime,
  'rating': instance.rating,
  'content': instance.content,
};
