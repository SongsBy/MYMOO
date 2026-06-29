/// 주문 내역(order_list) 화면에서 쓰는 순수 도메인 엔티티.
///
/// CLAUDE.md §3: domain 레이어는 순수 Dart 만 둔다(dio/Flutter import 금지).
/// 현재는 화면을 그리기 위한 placeholder 뷰모델이며, 추후 API 가 붙으면
/// `data/models/`(freezed) 에서 JSON 을 파싱해 이 엔티티로 변환한다.
library;

/// 주문 내역 화면 전체 데이터 묶음.
class OrderListData {
  const OrderListData({
    required this.reservation,
    required this.pastVisits,
  });

  /// 진행 중인 예약(예약 확정 카드). 없으면 null.
  final ReservationStatus? reservation;

  /// 지난 방문 목록.
  final List<PastVisit> pastVisits;
}

/// 진행 중인 예약 상태(예약 확정 카드).
class ReservationStatus {
  const ReservationStatus({
    required this.restaurantName,
    required this.imageUrl,
    required this.summary,
    required this.bannerText,
    required this.remainingText,
    required this.steps,
  });

  /// 식당명. 예: "청한식당 본점".
  final String restaurantName;

  /// 식당 대표 이미지 URL. 없으면 placeholder 를 그린다.
  final String? imageUrl;

  /// 인원·좌석·금액 요약. 예: "2명 · 창가 2인석 · 12,000무".
  final String summary;

  /// 상단 배너 문구. 예: "사장님이 자리를 잡아두었어요".
  final String bannerText;

  /// 남은 시간 강조 문구. 예: "입장까지 약 2시간 남았어요".
  final String remainingText;

  /// 예약 진행 타임라인 단계(요청 → 확정 → 방문 순).
  final List<ReservationStep> steps;
}

/// 예약 진행 타임라인의 한 단계.
class ReservationStep {
  const ReservationStep({
    required this.title,
    required this.subtitle,
    required this.done,
  });

  /// 단계 제목. 예: "예약 요청".
  final String title;

  /// 단계 보조 설명. 예: "오전 10:14 접수됨".
  final String subtitle;

  /// 완료 여부. true 면 채워진(brand) 체크, false 면 빈 원으로 그린다.
  final bool done;
}

/// 지난 방문 1건.
class PastVisit {
  const PastVisit({
    required this.restaurantName,
    required this.imageUrl,
    required this.timeAgo,
    required this.orderSummary,
    required this.reviewNotice,
  });

  /// 식당명. 예: "골목 손칼국수".
  final String restaurantName;

  /// 식당 대표 이미지 URL. 없으면 placeholder 를 그린다.
  final String? imageUrl;

  /// 방문 경과 시간. 예: "3시간 전".
  final String timeAgo;

  /// 주문 요약. 예: "바지락칼국수 1개 · 9,000무".
  final String orderSummary;

  /// 리뷰 작성 안내. 예: "리뷰 쓰기는 이후 3일 동안 가능해요".
  final String reviewNotice;
}
