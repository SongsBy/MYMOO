import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/restaurant_detail_model.dart';

part 'restaurant_detail_api.g.dart';

/// 식당 상세 API (retrofit).
///
/// 레퍼런스: `restaurant_finder/data/datasources/restaurant_finder_api.dart`
///
/// - baseUrl 은 dio 의 BaseOptions(AppConfig.baseUrl) 에서 주입된다고 가정.
/// - 상세는 단건 조회이므로 식당 id 를 path 로 받는다.
///
/// ⚠️ 엔드포인트 경로/응답 스키마는 백엔드 스펙에 맞춘다. (백엔드 합의 필요)
@RestApi()
abstract class RestaurantDetailApi {
  factory RestaurantDetailApi(Dio dio, {String? baseUrl}) = _RestaurantDetailApi;

  /// 식당 상세 단건 조회.
  @GET('/restaurants/{id}')
  Future<RestaurantDetailModel> getRestaurantDetail(
    @Path('id') int id, {
    @CancelRequest() CancelToken? cancelToken,
  });
}
