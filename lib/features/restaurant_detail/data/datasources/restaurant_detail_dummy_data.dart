import '../models/restaurant_detail_model.dart';

/// 식당 상세 임시(더미) 데이터.
///
/// TODO(backend): 실제 API 연동 시 이 파일과 [DummyRestaurantDetailDataSource] 는 삭제하고,
///   repository 구현체가 [RestaurantDetailApi] 를 호출하도록 교체한다.
///   (교체 지점은 `RestaurantDetailRepositoryImpl` 의 주석 참고)
///
/// 화면 구성을 실제처럼 확인하기 위한 in-memory 데이터다.
/// id 를 받아도 동일한 상세를 돌려주되, 사진 seed 에 id 를 섞어 다양성만 준다.
class DummyRestaurantDetailDataSource {
  const DummyRestaurantDetailDataSource();

  RestaurantDetailModel detail(int id) {
    return RestaurantDetailModel(
      id: id,
      region: '안산시 단원구',
      address: '사회공단 4단지 203동',
      isOpen: true,
      businessHours: '평일 11:00~14:00',
      phone: '031-1234-5678',
      photos: List.generate(
        4,
        (i) => 'https://picsum.photos/seed/mymoo-detail-$id-$i/700/400',
      ),
      tags: const ['국물 좋음', '넉넉한 양', '배달 가능', '현금 할인'],
      weeklyMenus: _weeklyMenus(id),
      reviewPhotos: List.generate(
        3,
        (i) => 'https://picsum.photos/seed/mymoo-review-$id-$i/300/300',
      ),
      reviews: _reviews,
    );
  }

  List<WeeklyMenuModel> _weeklyMenus(int id) {
    const days = [
      (date: 17, weekday: '월'),
      (date: 18, weekday: '화'),
      (date: 19, weekday: '수'),
      (date: 20, weekday: '목'),
      (date: 21, weekday: '금'),
    ];
    const menus = [
      (
        menu: '제육볶음',
        sides: ['계란찜', '미역국', '시금치 나물', '김치', '밥'],
        price: 6000,
      ),
      (
        menu: '고등어구이',
        sides: ['된장국', '콩나물', '깍두기', '밥'],
        price: 6500,
      ),
      (
        menu: '김치찌개',
        sides: ['제육볶음', '대파계란말이', '시금치 나물', '쌈채소', '밥국'],
        price: 6500,
      ),
      (
        menu: '순두부찌개',
        sides: ['계란후라이', '멸치볶음', '김', '밥'],
        price: 7000,
      ),
      (
        menu: '불고기',
        sides: ['잡채', '시금치 나물', '김치', '밥'],
        price: 7500,
      ),
    ];

    return List.generate(days.length, (i) {
      return WeeklyMenuModel(
        date: days[i].date,
        weekday: days[i].weekday,
        isToday: i == 2, // 디자인 기준 수요일(19일)이 오늘.
        thumbnailUrl: 'https://picsum.photos/seed/mymoo-menu-$id-$i/200/200',
        menuName: menus[i].menu,
        sideDishes: menus[i].sides,
        price: menus[i].price,
      );
    });
  }

  static const List<RestaurantReviewModel> _reviews = [
    RestaurantReviewModel(
      userName: '박OO',
      avatarUrl: 'https://i.pravatar.cc/80?img=12',
      relativeTime: '3일 전',
      rating: 5,
      content: '국물이 깊고 맛이 푸짐해요! 뼈가 해장하기도 딱 좋습니다. '
          '무엇보다 사장님이 매우 친절하시고 청결도도 높아서 자주 이용 중입니다.',
    ),
    RestaurantReviewModel(
      userName: '김OO',
      avatarUrl: 'https://i.pravatar.cc/80?img=32',
      relativeTime: '5일 전',
      rating: 4.5,
      content: '반찬이 매일 바뀌어서 질리지 않아요. 양도 넉넉하고 가성비가 정말 좋습니다.',
    ),
    RestaurantReviewModel(
      userName: '이OO',
      avatarUrl: 'https://i.pravatar.cc/80?img=45',
      relativeTime: '1주 전',
      rating: 5,
      content: '점심마다 줄 서는 이유가 있네요. 집밥 느낌 그대로라 단골 됐습니다.',
    ),
  ];
}
