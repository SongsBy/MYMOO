import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/app_error_view.dart';
import '../providers/restaurant_list_provider.dart';
import '../widgets/restaurant_card.dart';

/// 식당 리스트 화면.
///
/// ★ 페이지네이션 UI 연결의 레퍼런스다. 새 리스트 화면은 이 패턴을 그대로 복사한다.
///
/// 연결하는 상태:
/// - 첫 페이지 로딩 → state.loading (전체 스피너)
/// - 첫 페이지 에러 → state.error (AppErrorView, 전체 재시도)
/// - 데이터 + 다음 페이지 로딩 → 리스트 하단 인디케이터
/// - 다음 페이지 에러 → 리스트 하단 재시도 버튼 (기존 목록은 유지)
/// - pull-to-refresh → RefreshIndicator
/// - 스크롤 끝 근처 → loadNextPage()
class RestaurantListScreen extends ConsumerStatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  ConsumerState<RestaurantListScreen> createState() =>
      _RestaurantListScreenState();
}

class _RestaurantListScreenState extends ConsumerState<RestaurantListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final pos = _scrollController.position;
    // 끝에서 200px 이내로 들어오면 다음 페이지 요청 (중복 가드는 notifier 가 처리)
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      ref.read(restaurantListNotifierProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantListNotifierProvider);
    final notifier = ref.read(restaurantListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('식당')),
      body: state.when(
        // 1) 첫 페이지 로딩
        loading: () => const Center(child: CircularProgressIndicator()),

        // 2) 첫 페이지 에러 → 전체 재시도
        error: (error, _) => AppErrorView(
          onRetry: () => ref.invalidate(restaurantListNotifierProvider),
        ),

        // 3) 데이터
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('아직 등록된 식당이 없어요.'));
          }
          return RefreshIndicator(
            onRefresh: notifier.refresh,
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              // 마지막에 하단 인디케이터/재시도용 슬롯 1칸 추가
              itemCount: items.length + 1,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return RestaurantCard(restaurant: items[index]);
                }
                // 마지막 슬롯: 상태에 따라 로딩 / 재시도 / 빈 위젯
                return _FooterSlot(notifier: notifier);
              },
            ),
          );
        },
      ),
    );
  }
}

/// 리스트 하단 슬롯: 다음 페이지 로딩 인디케이터 또는 에러 재시도 버튼.
class _FooterSlot extends StatelessWidget {
  const _FooterSlot({required this.notifier});

  final RestaurantListNotifier notifier;

  @override
  Widget build(BuildContext context) {
    // 다음 페이지 에러 → 하단 재시도 (기존 목록은 그대로 유지됨)
    if (notifier.nextPageError != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: TextButton.icon(
            onPressed: notifier.retryNextPage,
            icon: const Icon(Icons.refresh),
            label: const Text('더 불러오기 실패 — 다시 시도'),
          ),
        ),
      );
    }

    // 다음 페이지 로딩 중
    if (notifier.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // 더 이상 페이지 없음 / 평상시
    if (!notifier.hasNext) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text('마지막입니다')),
      );
    }

    return const SizedBox.shrink();
  }
}
