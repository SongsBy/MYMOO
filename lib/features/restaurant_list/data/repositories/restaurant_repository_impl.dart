import 'package:dio/dio.dart';

import '../../../../core/error/dio_error_mapper.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_api.dart';
import '../models/restaurant_model.dart';

/// RestaurantRepository 의 실제 구현체 (data 레이어).
///
/// 핵심 역할:
/// 1. retrofit API 호출
/// 2. DioException → Failure 변환 (core/error 의 공통 매퍼 재사용)
///
/// presentation 은 이 클래스를 직접 new 하지 않고, provider 로 주입받는다.
class RestaurantRepositoryImpl implements RestaurantRepository {
  RestaurantRepositoryImpl(this._api);

  final RestaurantApi _api;

  @override
  Future<RestaurantPageModel> fetchRestaurants({
    int? cursor,
    required int limit,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _api.getRestaurants(
        cursor: cursor,
        limit: limit,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      // 모든 repository 가 동일한 변환을 재사용 → 일관된 에러 처리
      throw mapDioExceptionToFailure(e);
    }
  }
}
