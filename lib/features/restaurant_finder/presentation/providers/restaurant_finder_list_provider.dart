import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/restaurant_summary_model.dart';
import '../../domain/entities/food_category.dart';
import 'restaurant_finder_repository_provider.dart';
import 'selected_category_provider.dart';

part 'restaurant_finder_list_provider.g.dart';

/// 밥집 찾기 리스트 페이지네이션 Notifier.
///
/// ★ 페이지네이션 패턴은 `restaurant_list/.../restaurant_list_provider.dart` 를 그대로 따른다.
///   (첫 페이지 = state / 다음 페이지 = 내부 필드 + getter)
///
/// 추가점: [SelectedCategory] 를 watch 해서 카테고리가 바뀌면 build 가 다시 돌아
/// 첫 페이지부터 새 필터로 재조회된다.
@riverpod
class RestaurantFinderList extends _$RestaurantFinderList {
  static const _limit = 20;

  int? _nextCursor;
  bool _hasNext = true;
  bool _isLoadingMore = false;
  Object? _nextPageError;
  CancelToken? _cancelToken;

  late FoodCategory _category;

  // ── UI 가 참조하는 읽기 전용 상태 ───────────────────────────
  bool get hasNext => _hasNext;
  bool get isLoadingMore => _isLoadingMore;
  Object? get nextPageError => _nextPageError;

  @override
  Future<List<RestaurantSummaryModel>> build() async {
    // 카테고리가 바뀌면 build 재실행 → 첫 페이지부터 새 필터로 로드.
    _category = ref.watch(selectedCategoryProvider);
    // provider 가 dispose 될 때 in-flight 요청 취소
    ref.onDispose(() => _cancelToken?.cancel());
    return _fetchFirstPage();
  }

  /// 첫 페이지 로드 (build 와 refresh 가 공유)
  Future<List<RestaurantSummaryModel>> _fetchFirstPage() async {
    _cancelToken?.cancel(); // 이전 요청 정리
    _cancelToken = CancelToken();
    _nextCursor = null;
    _hasNext = true;
    _isLoadingMore = false;
    _nextPageError = null;

    final repo = ref.read(restaurantFinderRepositoryProvider);
    final page = await repo.fetchRestaurants(
      category: _category,
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
    if (state is! AsyncData<List<RestaurantSummaryModel>>) return;

    final current = state.requireValue;
    _isLoadingMore = true;
    _nextPageError = null;
    // notifier 내부 필드 변화를 UI 에 알리기 위해 동일 데이터로 state 갱신
    state = AsyncData(current);

    try {
      final repo = ref.read(restaurantFinderRepositoryProvider);
      final page = await repo.fetchRestaurants(
        category: _category,
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
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchFirstPage);
  }
}
