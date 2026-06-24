import 'package:dio/dio.dart' show CancelToken;

import '../../data/models/restaurant_detail_model.dart';

/// 식당 상세 repository 추상 클래스 (interface).
///
/// 레퍼런스: `restaurant_finder/domain/repositories/restaurant_finder_repository.dart`
///
/// - domain 은 순수 Dart 만 알아야 하므로 dio/retrofit/Flutter 를 import 하지 않는 것이 원칙이다.
///   다만 요청 취소를 위해 CancelToken 만 시그니처에 노출한다.
/// - 구현체는 data 레이어의 RestaurantDetailRepositoryImpl 이다. (의존성 역전)
abstract interface class RestaurantDetailRepository {
  Future<RestaurantDetailModel> fetchDetail(
    int id, {
    CancelToken? cancelToken,
  });
}
