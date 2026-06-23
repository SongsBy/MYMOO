import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/restaurant_model.dart';

part 'restaurant_api.g.dart';

/// retrofit 으로 정의하는 식당 API.
///
/// - baseUrl 은 주입받는다 (dio 의 BaseOptions 또는 생성자 인자).
/// - CancelToken 을 받아 빠른 스크롤 시 in-flight 요청을 취소할 수 있게 한다.
@RestApi()
abstract class RestaurantApi {
  factory RestaurantApi(Dio dio, {String? baseUrl}) = _RestaurantApi;

  /// 식당 목록 (커서 기반 페이지네이션).
  ///
  /// ⚠️ 쿼리 파라미터 이름(cursor/limit)과 방식은 백엔드 스펙에 맞춘다.
  /// offset 방식이면 @Query('page') int page 형태로 변경.
  @GET('/restaurants')
  Future<RestaurantPageModel> getRestaurants({
    @Query('cursor') int? cursor,
    @Query('limit') required int limit,
    @CancelRequest() CancelToken? cancelToken,
  });
}
