import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/restaurant_model.dart';
import 'restaurant_repository_provider.dart';

part 'restaurant_list_provider.g.dart';

/// 식당 리스트 페이지네이션 Notifier.
///
/// ★ 이 클래스가 "리스트 + 페이지네이션" 레퍼런스 패턴이다.
///   새 리스트 feature는 이 구조를 그대로 복사해서 모델/엔드포인트만 교체한다.
///
/// 설계 포인트:
/// - state(AsyncValue<List<T>>) 는 "현재까지 쌓인 전체 목록" 만 담는다.
/// - 페이지 커서 / 다음페이지 로딩중 / 끝 도달 같은 메타는 state 가 아니라
///   Notifier 내부 필드로 관리한다 (UI 가 알 필요 없는 내부 상태).
/// - 첫 페이지 로딩/에러 = state 자체(AsyncLoading/AsyncError) 로 표현.
/// - 다음 페이지 로딩/에러 = 별도 getter(isLoadingMore / nextPageError) 로 표현
///   → 다음 페이지 실패가 이미 쌓인 목록을 날려버리지 않게 한다.
@riverpod
class RestaurantListNotifier extends _$RestaurantListNotifier {
  static const _limit = 20;

  int? _nextCursor;
  bool _hasNext = true;
  bool _isLoadingMore = false;
  Object? _nextPageError;
  CancelToken? _cancelToken;

  // ── UI 가 참조하는 읽기 전용 상태 ───────────────────────────
  bool get hasNext => _hasNext;
  bool get isLoadingMore => _isLoadingMore;
  Object? get nextPageError => _nextPageError;

  @override
  Future<List<RestaurantModel>> build() async {
    // provider 가 dispose 될 때 in-flight 요청 취소
    ref.onDispose(() => _cancelToken?.cancel());
    return _fetchFirstPage();
  }

  /// 첫 페이지 로드 (build 와 refresh 가 공유)
  Future<List<RestaurantModel>> _fetchFirstPage() async {
    _cancelToken?.cancel(); // 이전 요청 정리
    _cancelToken = CancelToken();
    _nextPageError = null;

    final repo = ref.read(restaurantRepositoryProvider);
    final page = await repo.fetchRestaurants(
      cursor: null,
      limit: _limit,
      cancelToken: _cancelToken,
    );
    _nextCursor = page.nextCursor;
    _hasNext = page.hasNext;
    return page.items;
  }

  /// 다음 페이지 로드.
  /// - 중복 호출 가드: 이미 로딩 중이거나 끝에 도달했으면 무시.
  /// - 실패해도 기존 목록은 유지하고 nextPageError 로만 노출.
  Future<void> loadNextPage() async {
    if (_isLoadingMore || !_hasNext) return;
    if (state is! AsyncData<List<RestaurantModel>>) return; // 첫 로딩 중이면 무시

    final current = state.requireValue;
    _isLoadingMore = true;
    _nextPageError = null;
    // notifier 내부 필드 변화를 UI 에 알리기 위해 동일 데이터로 state 갱신
    state = AsyncData(current);

    try {
      final repo = ref.read(restaurantRepositoryProvider);
      final page = await repo.fetchRestaurants(
        cursor: _nextCursor,
        limit: _limit,
        cancelToken: _cancelToken,
      );
      _nextCursor = page.nextCursor;
      _hasNext = page.hasNext;
      state = AsyncData([...current, ...page.items]);
    } catch (e) {
      // 다음 페이지 에러: 기존 목록 유지 + 하단 재시도용 에러만 보관
      _nextPageError = e;
      state = AsyncData(current);
    } finally {
      _isLoadingMore = false;
    }
  }

  /// 다음 페이지 로드 실패 후 하단 "재시도" 버튼에서 호출
  Future<void> retryNextPage() async {
    _nextPageError = null;
    await loadNextPage();
  }

  /// 당겨서 새로고침 (pull-to-refresh): 전체를 처음부터 다시 로드
  Future<void> refresh() async {
    _nextCursor = null;
    _hasNext = true;
    _isLoadingMore = false;
    _nextPageError = null;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchFirstPage);
  }
}
