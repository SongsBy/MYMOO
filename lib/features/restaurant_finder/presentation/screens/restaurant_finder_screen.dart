import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/app_error_view.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../restaurant_detail/presentation/screens/restaurant_detail_screen.dart';
import '../../data/models/restaurant_summary_model.dart';
import '../providers/restaurant_finder_list_provider.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/restaurant_search_bar.dart';
import '../widgets/restaurant_summary_card.dart';

/// 밥집 찾기 화면 (홈의 "밥 집 찾기" 카드 진입).
///
/// 네이버 지도식 구성:
/// - 배경: 지도 영역 (현재는 플레이스홀더, 추후 Google Map 연동).
/// - 상단 플로팅: 검색 바 + 카테고리 필터 (지도 위에 떠 있음).
/// - 하단: 식당 리스트를 담은 드래그 가능한 바텀시트([DraggableScrollableSheet]).
///
/// 로고 앱바/바텀네비는 RootTab 셸이 제공한다(홈 탭의 중첩 Navigator 로 진입).
///
/// 페이지네이션은 `restaurant_list` 패턴을 따른다(첫 페이지=state / 다음 페이지=getter).
/// 다음 페이지 트리거는 바텀시트 리스트의 스크롤을 [NotificationListener] 로 감지한다.
class RestaurantFinderScreen extends StatelessWidget {
  const RestaurantFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      // 검색 바가 입력형으로 바뀌어도 시트가 키보드에 밀려 깨지지 않도록.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1) 지도 영역 (추후 Google Map 연동)
          const Positioned.fill(child: _MapPlaceholder()),

          // 2) 식당 리스트 — 드래그 가능한 바텀시트
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.12,
            maxChildSize: 0.88,
            snap: true,
            snapSizes: const [0.12, 0.5, 0.88],
            builder: (context, scrollController) =>
                _RestaurantSheet(scrollController: scrollController),
          ),

          // 3) 상단 검색 + 카테고리 (지도 위 플로팅, 시트보다 위)
          const _TopOverlay(),
        ],
      ),
    );
  }
}

/// 지도 자리 플레이스홀더.
///
/// TODO(map): google_maps_flutter(또는 네이버 지도 SDK) 연동 시 이 위젯을 지도로 교체한다.
class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bgSecondary,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.map_outlined,
              size: 48,
              color: AppColors.iconDisable,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '지도 영역',
              style: AppTextStyles.body2Medium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'Google Map 연동 예정',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.textDisable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 지도 위에 떠 있는 검색 바 + 카테고리 필터.
class _TopOverlay extends StatelessWidget {
  const _TopOverlay();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.sm,
            ),
            child: RestaurantSearchBar(
              backgroundColor: AppColors.bgInverse,
              elevation: 2,
            ),
          ),
          CategoryFilterBar(),
        ],
      ),
    );
  }
}

/// 식당 리스트 바텀시트 본문.
///
/// 핸들·로딩·에러·리스트를 모두 하나의 [CustomScrollView] 에 담아,
/// 시트 어디를 드래그해도(핸들 포함) 시트 크기가 조절되도록 한다.
class _RestaurantSheet extends ConsumerWidget {
  const _RestaurantSheet({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(restaurantFinderListProvider);
    final notifier = ref.read(restaurantFinderListProvider.notifier);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
        boxShadow: [
          BoxShadow(
            color: AppColors.opacity12,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
        child: RefreshIndicator(
          onRefresh: notifier.refresh,
          child: NotificationListener<ScrollNotification>(
            // 끝에서 200px 이내로 들어오면 다음 페이지 요청 (중복 가드는 notifier 가 처리)
            onNotification: (n) {
              if (n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
                notifier.loadNextPage();
              }
              return false;
            },
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: _SheetHandle()),
                _bodySliver(ref, state, notifier),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodySliver(
    WidgetRef ref,
    AsyncValue<List<RestaurantSummaryModel>> state,
    RestaurantFinderList notifier,
  ) {
    return state.when(
      // 1) 첫 페이지 로딩
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),

      // 2) 첫 페이지 에러 → 전체 재시도
      error: (error, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: AppErrorView(
            onRetry: () => ref.invalidate(restaurantFinderListProvider),
          ),
        ),
      ),

      // 3) 데이터
      data: (items) {
        if (items.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: Text('조건에 맞는 식당이 없어요.')),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < items.length) {
                final restaurant = items[index];
                return RestaurantSummaryCard(
                  restaurant: restaurant,
                  // 상세로 이동 — 요약 모델을 그대로 넘겨 헤더를 즉시 그린다.
                  // rootNavigator 로 push 해 로고 앱바/바텀네비 위 풀스크린으로 띄운다.
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          RestaurantDetailScreen(summary: restaurant),
                    ),
                  ),
                );
              }
              return _FooterSlot(notifier: notifier);
            },
            // 마지막에 하단 인디케이터/재시도용 슬롯 1칸 추가
            childCount: items.length + 1,
          ),
        );
      },
    );
  }
}

/// 바텀시트 상단 드래그 핸들.
class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.borderTertiary,
            borderRadius: BorderRadius.circular(AppSpacing.xxs),
          ),
        ),
      ),
    );
  }
}

/// 리스트 하단 슬롯: 다음 페이지 로딩 인디케이터 또는 에러 재시도 버튼.
class _FooterSlot extends StatelessWidget {
  const _FooterSlot({required this.notifier});

  final RestaurantFinderList notifier;

  @override
  Widget build(BuildContext context) {
    // 다음 페이지 에러 → 하단 재시도 (기존 목록은 그대로 유지됨)
    if (notifier.nextPageError != null) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
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
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // 더 이상 페이지 없음 → 여백만
    return const SizedBox(height: AppSpacing.xl);
  }
}
