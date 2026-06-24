import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_detail_model.freezed.dart';
part 'restaurant_detail_model.g.dart';

/// 식당 상세 화면의 전체 데이터 모델.
///
/// 리스트(밥집 찾기) 카드에서 넘겨받는 요약 정보(식당명/사진/평점/거리 등,
/// `RestaurantSummaryModel`)와 별개로, 상세 화면에서만 필요한 정보
/// (주소/영업시간/전화/태그/주간 식단/리뷰)를 담는다.
///
/// 흐름: 리스트에서 요약을 넘겨 헤더를 즉시 그리고,
///       이 상세 모델은 `restaurantDetailProvider(id)` 로 비동기 로드해 채운다.
///
/// API 응답(JSON) ↔ 객체 변환은 이 data 레이어 model 에서만 한다.
/// ⚠️ 필드명/타입은 백엔드 응답 스펙에 맞춰 조정한다. (백엔드 합의 필요)
@freezed
abstract class RestaurantDetailModel with _$RestaurantDetailModel {
  const factory RestaurantDetailModel({
    required int id,

    /// 행정 구역. 예: "안산시 단원구"
    required String region,

    /// 상세 주소. 예: "사회공단 4단지 203동"
    required String address,

    /// 현재 영업 여부. true 면 "영업중"(초록) 표시.
    required bool isOpen,

    /// 영업시간 안내. 예: "평일 11:00~14:00"
    required String businessHours,

    /// 전화번호. 예: "031-1234-5678"
    required String phone,

    /// 상단 사진 캐러셀 이미지 URL 목록.
    required List<String> photos,

    /// 식당 속성 태그. 예: ["국물 좋음", "넉넉한 양", "배달 가능", "현금 할인"]
    required List<String> tags,

    /// 이번 주 식단(요일별).
    required List<WeeklyMenuModel> weeklyMenus,

    /// "한 줄 리뷰" 상단 사진 모음 URL.
    required List<String> reviewPhotos,

    /// 한 줄 리뷰 목록.
    required List<RestaurantReviewModel> reviews,
  }) = _RestaurantDetailModel;

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);
}

/// 이번 주 식단의 하루치 항목.
@freezed
abstract class WeeklyMenuModel with _$WeeklyMenuModel {
  const factory WeeklyMenuModel({
    /// 일(day). 예: 19
    required int date,

    /// 요일 라벨. 예: "수"
    required String weekday,

    /// 오늘(=기본 선택) 여부. 상단에 점 표시 + 강조 색.
    required bool isToday,

    /// 대표 메뉴 썸네일 URL.
    required String thumbnailUrl,

    /// 대표 메뉴명. 예: "김치찌개"
    required String menuName,

    /// 구성 반찬. 예: ["제육볶음", "대파계란말이", ...]
    required List<String> sideDishes,

    /// 가격(원). 예: 6500
    required int price,
  }) = _WeeklyMenuModel;

  factory WeeklyMenuModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyMenuModelFromJson(json);
}

/// 한 줄 리뷰 1건.
@freezed
abstract class RestaurantReviewModel with _$RestaurantReviewModel {
  const factory RestaurantReviewModel({
    /// 작성자(마스킹) 이름. 예: "박OO"
    required String userName,

    /// 작성자 프로필 이미지 URL.
    required String avatarUrl,

    /// 상대 시간. 예: "3일 전"
    required String relativeTime,

    /// 평점(0.0~5.0). 예: 5.0
    required double rating,

    /// 리뷰 본문.
    required String content,
  }) = _RestaurantReviewModel;

  factory RestaurantReviewModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantReviewModelFromJson(json);
}
