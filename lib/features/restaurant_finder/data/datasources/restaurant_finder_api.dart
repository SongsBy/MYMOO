import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/restaurant_summary_model.dart';

part 'restaurant_finder_api.g.dart';

/// 밥집 찾기 식당 API (retrofit).
///
/// 레퍼런스: `restaurant_list/data/datasources/restaurant_api.dart`
///
/// - baseUrl 은 dio 의 BaseOptions(AppConfig.baseUrl) 에서 주입된다고 가정.
/// - CancelToken 을 받아 빠른 스크롤 시 in-flight 요청을 취소할 수 있게 한다.
///
/// ⚠️ 엔드포인트 경로/쿼리 파라미터 이름(category/keyword/cursor/limit)과
///    페이지네이션 방식은 백엔드 스펙에 맞춘다. (백엔드 합의 필요)
@RestApi()
abstract class RestaurantFinderApi {
  factory RestaurantFinderApi(Dio dio, {String? baseUrl}) =
      _RestaurantFinderApi;

  /// 식당 목록 (커서 기반 페이지네이션 + 카테고리/검색 필터).
  @GET('/restaurants')
  Future<RestaurantSummaryPageModel> getRestaurants({
    @Query('category') String? category,
    @Query('keyword') String? keyword,
    @Query('cursor') int? cursor,
    @Query('limit') required int limit,
    @CancelRequest() CancelToken? cancelToken,
  });
}
