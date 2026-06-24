import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_model.freezed.dart';
part 'restaurant_model.g.dart';

/// 식당 단일 항목 모델.
///
/// API 응답(JSON) ↔ 객체 변환은 이 data 레이어 model 에서만 한다.
@freezed
abstract class RestaurantModel with _$RestaurantModel {
  const factory RestaurantModel({
    required int id,
    required String name,
    required String thumbnailUrl,
  }) = _RestaurantModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}

/// 페이지네이션 응답 래퍼.
///
/// ⚠️ 실제 필드(hasNext / nextCursor / total 등)는 백엔드 페이지네이션 포맷에 맞춘다.
/// - cursor 방식: nextCursor (int/String/DateTime)
/// - offset 방식: 이 래퍼를 page/offset/totalPages 구조로 변경
@freezed
abstract class RestaurantPageModel with _$RestaurantPageModel {
  const factory RestaurantPageModel({
    required List<RestaurantModel> items,
    required bool hasNext,
    int? nextCursor,
  }) = _RestaurantPageModel;

  factory RestaurantPageModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantPageModelFromJson(json);
}
