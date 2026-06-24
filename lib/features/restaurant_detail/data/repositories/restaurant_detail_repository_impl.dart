import 'package:dio/dio.dart';

import '../../../../core/error/dio_error_mapper.dart';
import '../../domain/repositories/restaurant_detail_repository.dart';
import '../datasources/restaurant_detail_api.dart';
import '../datasources/restaurant_detail_dummy_data.dart';
import '../models/restaurant_detail_model.dart';

/// RestaurantDetailRepository 의 구현체 (data 레이어).
///
/// 레퍼런스: `restaurant_finder/data/repositories/restaurant_finder_repository_impl.dart`
///
/// 핵심 역할:
/// 1. (실서비스) retrofit API 호출
/// 2. DioException → Failure 변환 (core/error 의 공통 매퍼 재사용)
///
/// presentation 은 이 클래스를 직접 new 하지 않고, provider 로 주입받는다.
///
/// ──────────────────────────────────────────────────────────────
/// ⚠️ 현재는 백엔드 미연동 상태라 [DummyRestaurantDetailDataSource] 로 더미 데이터를 반환한다.
/// API 가 준비되면:
///   1. 생성자에서 [_dummy] 를 제거하고 [_api] 만 주입받는다.
///   2. [fetchDetail] 본문을 아래 주석의 "실 API 호출" 블록으로 교체한다.
///   3. `restaurant_detail_dummy_data.dart` 파일을 삭제한다.
/// 그 외 시그니처/반환 형태는 그대로라 상위(provider/UI)는 바뀌지 않는다.
/// ──────────────────────────────────────────────────────────────
class RestaurantDetailRepositoryImpl implements RestaurantDetailRepository {
  RestaurantDetailRepositoryImpl(
    this._api, {
    DummyRestaurantDetailDataSource dummy =
        const DummyRestaurantDetailDataSource(),
  }) : _dummy = dummy;

  // ignore: unused_field
  final RestaurantDetailApi _api;
  final DummyRestaurantDetailDataSource _dummy;

  @override
  Future<RestaurantDetailModel> fetchDetail(
    int id, {
    CancelToken? cancelToken,
  }) async {
    try {
      // ── 더미 데이터 (네트워크 지연 흉내) ──
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return _dummy.detail(id);

      // ── 실 API 호출 (백엔드 연동 시 위 더미 블록을 지우고 아래를 사용) ──
      // return await _api.getRestaurantDetail(id, cancelToken: cancelToken);
    } on DioException catch (e) {
      // 모든 repository 가 동일한 변환을 재사용 → 일관된 에러 처리
      throw mapDioExceptionToFailure(e);
    }
  }
}
