import 'package:dio/dio.dart' show CancelToken;

import '../../data/models/restaurant_summary_model.dart';
import '../entities/food_category.dart';

/// 밥집 찾기 repository 추상 클래스 (interface).
///
/// 레퍼런스: `restaurant_list/domain/repositories/restaurant_repository.dart`
///
/// - domain 은 순수 Dart 만 알아야 하므로 dio/retrofit/Flutter 를 import 하지 않는 것이 원칙이다.
///   다만 CancelToken 은 페이지네이션 취소를 위해 시그니처에 노출한다.
/// - 구현체는 data 레이어의 RestaurantFinderRepositoryImpl 이다. (의존성 역전)
abstract interface class RestaurantFinderRepository {
  Future<RestaurantSummaryPageModel> fetchRestaurants({
    required FoodCategory category,
    String? keyword,
    int? cursor,
    required int limit,
    CancelToken? cancelToken,
  });
}
