import '../../domain/entities/food_category.dart';
import '../models/restaurant_summary_model.dart';

/// 밥집 찾기 임시(더미) 데이터.
///
/// TODO(backend): 실제 API 연동 시 이 파일과 [DummyRestaurantFinderDataSource] 는 삭제하고,
///   repository 구현체가 [RestaurantFinderApi] 를 호출하도록 교체한다.
///   (교체 지점은 `RestaurantFinderRepositoryImpl` 의 주석 참고)
///
/// 화면/페이지네이션/필터 동작을 실제처럼 확인하기 위한 in-memory 데이터셋이다.
class DummyRestaurantFinderDataSource {
  const DummyRestaurantFinderDataSource();

  /// 카테고리·검색어 필터 + 커서 페이지네이션을 메모리에서 흉내 낸다.
  ///
  /// 실제 백엔드 호출과 동일한 시그니처/반환 형태를 유지해, repository 가
  /// 더미↔실제 전환 시 거의 바뀌지 않도록 한다.
  RestaurantSummaryPageModel page({
    required FoodCategory category,
    String? keyword,
    int? cursor,
    required int limit,
  }) {
    final start = cursor ?? 0;

    final filtered = _all.where((r) {
      final matchesCategory =
          category == FoodCategory.all || r.category == category;
      final matchesKeyword = keyword == null ||
          keyword.trim().isEmpty ||
          r.menuName.contains(keyword.trim()) ||
          r.restaurantName.contains(keyword.trim());
      return matchesCategory && matchesKeyword;
    }).toList();

    final end = (start + limit).clamp(0, filtered.length);
    final items = (start >= filtered.length)
        ? <RestaurantSummaryModel>[]
        : filtered.sublist(start, end);
    final hasNext = end < filtered.length;

    return RestaurantSummaryPageModel(
      items: items,
      hasNext: hasNext,
      nextCursor: hasNext ? end : null,
    );
  }

  /// 더미 식당 목록(여러 카테고리 혼합).
  static final List<RestaurantSummaryModel> _all = List.generate(48, (i) {
    const categories = [
      FoodCategory.baekban,
      FoodCategory.soup,
      FoodCategory.korean,
      FoodCategory.bunsik,
    ];
    final category = categories[i % categories.length];
    final menu = _menusByCategory[category]![i ~/ categories.length %
        _menusByCategory[category]!.length];
    return RestaurantSummaryModel(
      id: i + 1,
      menuName: menu.menu,
      restaurantName: menu.store,
      thumbnailUrl: 'https://picsum.photos/seed/mymoo$i/200/200',
      rating: 3.8 + (i % 12) * 0.1,
      reviewCount: 37 + i * 53 % 940,
      distanceMeters: 80 + (i % 9) * 60,
      price: 6000 + (i % 6) * 500,
      seatAvailable: i % 3 != 0,
      category: category,
    );
  });

  static final Map<FoodCategory, List<({String menu, String store})>>
      _menusByCategory = {
    FoodCategory.baekban: const [
      (menu: '제육볶음 백반', store: '정든집 기사식당'),
      (menu: '고등어구이 백반', store: '엄마손 백반'),
      (menu: '불고기 백반', store: '한끼 식당'),
    ],
    FoodCategory.soup: const [
      (menu: '순두부찌개', store: '바다순두부'),
      (menu: '김치찌개', store: '김치명가'),
      (menu: '된장찌개', store: '시골된장'),
    ],
    FoodCategory.korean: const [
      (menu: '비빔밥', store: '전주식당'),
      (menu: '갈비탕', store: '한우갈비'),
      (menu: '불고기정식', store: '아리랑'),
    ],
    FoodCategory.bunsik: const [
      (menu: '떡볶이 세트', store: '신전분식'),
      (menu: '김밥 한 줄', store: '김밥천국'),
      (menu: '라볶이', store: '엽기분식'),
    ],
  };
}
