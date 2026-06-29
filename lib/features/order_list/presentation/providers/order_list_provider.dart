import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/order_list_entities.dart';

part 'order_list_provider.g.dart';

/// 주문 내역 데이터 provider.
///
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다(CLAUDE.md §5).
///
/// ⚠️ 현재는 더미 데이터를 반환하는 **placeholder** 다.
/// TODO(backend): 주문 내역 API 가 확정되면
///   1) `data/datasources/` 에 retrofit API 정의
///   2) `domain/repositories/` 인터페이스 + `data/repositories/` 구현체 추가
///   3) 아래 본문을 `ref.watch(orderListRepositoryProvider).fetch(...)` 로 교체
/// 한다. (페이지 키/응답 포맷은 백엔드 팀원과 합의 필요)
@riverpod
Future<OrderListData> orderList(Ref ref) async {
  return _dummyOrderList;
}

/// 더미 식당 대표 사진. 밥집 찾기(restaurant_finder) 더미 데이터와 동일한
/// picsum seed 패턴을 재사용해 일관된 이미지를 보여준다.
/// API 연동 시 실제 식당 이미지 URL 로 교체된다.
String _dummyThumb(int seed) => 'https://picsum.photos/seed/mymoo$seed/200/200';

/// 디자인(Figma node 69453:1207) 기준 더미 데이터.
/// API 연동 시 통째로 제거한다.
final OrderListData _dummyOrderList = OrderListData(
  reservation: ReservationStatus(
    restaurantName: '청한식당 본점',
    imageUrl: _dummyThumb(0),
    summary: '2명 · 창가 2인석 · 12,000무',
    bannerText: '사장님이 자리를 잡아두었어요',
    remainingText: '입장까지 약 2시간 남았어요',
    steps: const [
      ReservationStep(
        title: '예약 요청',
        subtitle: '오전 10:14 접수됨',
        done: true,
      ),
      ReservationStep(
        title: '사장님이 자리를 잡아뒀어요',
        subtitle: '오전 10:16 확정 · 창가 2인석',
        done: true,
      ),
      ReservationStep(
        title: '매장 방문',
        subtitle: '오후 12:30 입장 예정',
        done: false,
      ),
    ],
  ),
  pastVisits: [
    PastVisit(
      restaurantName: '골목 손칼국수',
      imageUrl: _dummyThumb(1),
      timeAgo: '3시간 전',
      orderSummary: '바지락칼국수 1개 · 9,000무',
      reviewNotice: '리뷰 쓰기는 이후 3일 동안 가능해요',
    ),
    PastVisit(
      restaurantName: '제육볶음 백반',
      imageUrl: _dummyThumb(2),
      timeAgo: '9시간 전',
      orderSummary: '제육볶음 1개 · 15,000무',
      reviewNotice: '리뷰 쓰기는 이후 3일 동안 가능해요',
    ),
    PastVisit(
      restaurantName: '삼청동 한상',
      imageUrl: _dummyThumb(3),
      timeAgo: '2일 전',
      orderSummary: '갈비찜 정식 1개 · 22,000무',
      reviewNotice: '리뷰 쓰기는 이후 3일 동안 가능해요',
    ),
    PastVisit(
      restaurantName: '정성담은 비빔밥',
      imageUrl: _dummyThumb(4),
      timeAgo: '3일 전',
      orderSummary: '전주비빔밥 1개 · 12,500무',
      reviewNotice: '리뷰 쓰기는 이후 3일 동안 가능해요',
    ),
  ],
);
