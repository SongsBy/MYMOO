import 'package:flutter/foundation.dart';
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
class RestaurantFinderScreen extends StatefulWidget {
  const RestaurantFinderScreen({super.key});

  @override
  State<RestaurantFinderScreen> createState() => _RestaurantFinderScreenState();
}

class _RestaurantFinderScreenState extends State<RestaurantFinderScreen> {
  // 시트 높이 비율(화면 대비). snapSizes 도 이 값들과 일치시킨다.
  static const double _minSize = 0.12;
  static const double _initialSize = 0.3;
  static const double _maxSize = 0.95;

  // 이 높이를 넘어서면 상단(검색+칩)이 페이드아웃되기 시작하고,
  // [_maxSize] 에 도달하면 완전히 사라진다.
  static const double _overlayHideStart = 0.6;

  // 시트의 현재 높이 비율. 상단 오버레이의 표시/숨김을 구동한다.
  // setState 대신 ValueNotifier 로 오버레이만 다시 그려 비용을 줄인다.
  final ValueNotifier<double> _sheetExtent = ValueNotifier<double>(
    _initialSize,
  );

  @override
  void dispose() {
    _sheetExtent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      // 검색 바가 입력형으로 바뀌어도 시트가 키보드에 밀려 깨지지 않도록.
      resizeToAvoidBottomInset: false,
      // 시트 높이 변화를 받아 상단 오버레이 표시/숨김에 반영한다.
      body: NotificationListener<DraggableScrollableNotification>(
        onNotification: (n) {
          _sheetExtent.value = n.extent;
          return false;
        },
        child: Stack(
          children: [
            // 1) 지도 영역 (추후 Google Map 연동)
            const Positioned.fill(child: _MapPlaceholder()),

            // 2) 식당 리스트 — 드래그 가능한 바텀시트
            DraggableScrollableSheet(
              initialChildSize: _initialSize,
              minChildSize: _minSize,
              maxChildSize: _maxSize,
              snap: true,
              snapSizes: const [_minSize, _initialSize, _maxSize],
              builder: (context, scrollController) =>
                  _RestaurantSheet(scrollController: scrollController),
            ),

            // 3) 상단 검색 + 카테고리 (지도 위 플로팅, 시트가 max 면 가려짐)
            _TopOverlay(
              sheetExtent: _sheetExtent,
              hideStart: _overlayHideStart,
              hideEnd: _maxSize,
            ),
          ],
        ),
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
///
/// 앱바가 없는 화면이라 상태바 인셋([SafeArea])을 직접 처리해 최상단에 붙인다.
/// 시트 높이([sheetExtent])가 [hideStart]→[hideEnd] 로 올라갈수록 위로 밀려나며
/// 사라지고(=시트 max 면 완전히 가려짐), 시트가 내려오면 다시 나타난다.
class _TopOverlay extends StatelessWidget {
  const _TopOverlay({
    required this.sheetExtent,
    required this.hideStart,
    required this.hideEnd,
  });

  /// 시트의 현재 높이 비율(0~1).
  final ValueListenable<double> sheetExtent;

  /// 페이드아웃이 시작되는 시트 높이.
  final double hideStart;

  /// 완전히 사라지는 시트 높이(보통 maxChildSize).
  final double hideEnd;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: ValueListenableBuilder<double>(
          valueListenable: sheetExtent,
          builder: (context, extent, child) {
            // hideStart→hideEnd 구간에서 0→1 로 진행(시트가 올라올수록 1).
            final progress = ((extent - hideStart) / (hideEnd - hideStart))
                .clamp(0.0, 1.0);
            return IgnorePointer(
              // 절반 이상 숨겨지면 탭을 받지 않는다.
              ignoring: progress > 0.5,
              child: Opacity(
                opacity: 1 - progress,
                // 자기 높이만큼 위로 밀어 올려 자연스럽게 사라지게 한다.
                child: FractionalTranslation(
                  translation: Offset(0, -progress),
                  child: child,
                ),
              ),
            );
          },
          child: const Column(
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
        ),
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
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.md),
        ),
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
