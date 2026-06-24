import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/restaurant_detail_model.dart';
import 'restaurant_detail_repository_provider.dart';

part 'restaurant_detail_provider.g.dart';

/// 식당 상세 데이터 provider (식당 id 별 family).
///
/// 리스트에서 넘어온 요약 정보로 헤더를 즉시 그리는 동안, 이 provider 가
/// 상세(주소/영업시간/태그/주간 식단/리뷰)를 비동기로 불러온다.
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다. (CLAUDE.md §5)
///
/// 화면을 벗어나면(provider dispose) in-flight 요청을 CancelToken 으로 취소한다.
@riverpod
Future<RestaurantDetailModel> restaurantDetail(Ref ref, int restaurantId) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  final repo = ref.watch(restaurantDetailRepositoryProvider);
  return repo.fetchDetail(restaurantId, cancelToken: cancelToken);
}
