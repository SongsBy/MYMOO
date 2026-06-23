import 'package:dio/dio.dart' show CancelToken;

import '../../data/models/restaurant_model.dart';

/// 식당 repository 추상 클래스 (interface).
///
/// domain 레이어에 위치한다.
/// - domain 은 순수 Dart 만 알아야 하므로 dio/retrofit/Flutter 를 import 하지 않는 것이 원칙이다.
/// - 다만 CancelToken 은 페이지네이션 취소를 위해 시그니처에 노출한다.
///   (이것까지 숨기고 싶다면 자체 CancelToken 추상을 만들 수 있으나, 1인 앱에서는 과하다.)
///
/// 구현체는 data 레이어의 RestaurantRepositoryImpl 이다. (의존성 역전)
abstract interface class RestaurantRepository {
  Future<RestaurantPageModel> fetchRestaurants({
    int? cursor,
    required int limit,
    CancelToken? cancelToken,
  });
}
