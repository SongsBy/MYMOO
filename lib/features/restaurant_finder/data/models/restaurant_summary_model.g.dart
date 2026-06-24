// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantSummaryModel _$RestaurantSummaryModelFromJson(
  Map<String, dynamic> json,
) => _RestaurantSummaryModel(
  id: (json['id'] as num).toInt(),
  menuName: json['menuName'] as String,
  restaurantName: json['restaurantName'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  distanceMeters: (json['distanceMeters'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  seatAvailable: json['seatAvailable'] as bool,
  category: $enumDecode(_$FoodCategoryEnumMap, json['category']),
);

Map<String, dynamic> _$RestaurantSummaryModelToJson(
  _RestaurantSummaryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'menuName': instance.menuName,
  'restaurantName': instance.restaurantName,
  'thumbnailUrl': instance.thumbnailUrl,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'distanceMeters': instance.distanceMeters,
  'price': instance.price,
  'seatAvailable': instance.seatAvailable,
  'category': _$FoodCategoryEnumMap[instance.category]!,
};

const _$FoodCategoryEnumMap = {
  FoodCategory.all: 'all',
  FoodCategory.baekban: 'baekban',
  FoodCategory.soup: 'soup',
  FoodCategory.korean: 'korean',
  FoodCategory.bunsik: 'bunsik',
};

_RestaurantSummaryPageModel _$RestaurantSummaryPageModelFromJson(
  Map<String, dynamic> json,
) => _RestaurantSummaryPageModel(
  items: (json['items'] as List<dynamic>)
      .map((e) => RestaurantSummaryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasNext: json['hasNext'] as bool,
  nextCursor: (json['nextCursor'] as num?)?.toInt(),
);

Map<String, dynamic> _$RestaurantSummaryPageModelToJson(
  _RestaurantSummaryPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'hasNext': instance.hasNext,
  'nextCursor': instance.nextCursor,
};
