// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    _RestaurantModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$RestaurantModelToJson(_RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailUrl': instance.thumbnailUrl,
    };

_RestaurantPageModel _$RestaurantPageModelFromJson(Map<String, dynamic> json) =>
    _RestaurantPageModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool,
      nextCursor: (json['nextCursor'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RestaurantPageModelToJson(
  _RestaurantPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'hasNext': instance.hasNext,
  'nextCursor': instance.nextCursor,
};
