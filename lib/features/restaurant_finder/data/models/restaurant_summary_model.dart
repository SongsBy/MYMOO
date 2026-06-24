import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/food_category.dart';

part 'restaurant_summary_model.freezed.dart';
part 'restaurant_summary_model.g.dart';

/// 밥집 찾기 리스트의 단일 항목(요약) 모델.
///
/// 리스트 카드 1장에 필요한 정보만 담는 "요약" 모델이다.
/// 상세 화면이 생기면 별도의 RestaurantDetailModel 을 둔다.
///
/// API 응답(JSON) ↔ 객체 변환은 이 data 레이어 model 에서만 한다.
///
/// ⚠️ 필드명/타입은 백엔드 응답 스펙에 맞춰 조정한다. (백엔드 합의 필요)
@freezed
abstract class RestaurantSummaryModel with _$RestaurantSummaryModel {
  const factory RestaurantSummaryModel({
    required int id,

    /// 대표 메뉴명. 예: "제육볶음 백반"
    required String menuName,

    /// 식당명. 예: "정든집 기사식당"
    required String restaurantName,

    /// 썸네일 이미지 URL.
    required String thumbnailUrl,

    /// 평점(0.0~5.0). 예: 4.7
    required double rating,

    /// 리뷰 수. 예: 787
    required int reviewCount,

    /// 현재 위치로부터의 거리(미터). 예: 120
    required int distanceMeters,

    /// 대표 메뉴 가격(원). 예: 6500
    required int price,

    /// 자리(좌석) 여유 여부. true 면 "자리 있음" 뱃지 노출.
    required bool seatAvailable,

    /// 메뉴 분류(카테고리). 카테고리 필터링에 사용.
    required FoodCategory category,
  }) = _RestaurantSummaryModel;

  factory RestaurantSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantSummaryModelFromJson(json);
}

/// 페이지네이션 응답 래퍼.
///
/// ⚠️ 실제 필드(hasNext / nextCursor / total 등)는 백엔드 페이지네이션 포맷에 맞춘다.
/// - cursor 방식: nextCursor (int/String/DateTime)
/// - offset 방식: 이 래퍼를 page/offset/totalPages 구조로 변경
/// (레퍼런스: `restaurant_list/data/models/restaurant_model.dart`)
@freezed
abstract class RestaurantSummaryPageModel with _$RestaurantSummaryPageModel {
  const factory RestaurantSummaryPageModel({
    required List<RestaurantSummaryModel> items,
    required bool hasNext,
    int? nextCursor,
  }) = _RestaurantSummaryPageModel;

  factory RestaurantSummaryPageModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantSummaryPageModelFromJson(json);
}
