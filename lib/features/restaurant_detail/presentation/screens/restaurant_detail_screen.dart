import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/app_bar/detail_app_bar.dart';
import '../../../../common/widgets/app_error_view.dart';
import '../../../../common/widgets/buttons/sheet_button.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../restaurant_finder/data/models/restaurant_summary_model.dart';
import '../providers/restaurant_detail_provider.dart';
import '../widgets/restaurant_detail_header.dart';
import '../widgets/review_section.dart';
import '../widgets/weekly_meal_section.dart';

/// 식당 상세 화면.
///
/// Figma "디자인02" (node 69379:1152).
///
/// 진입 방식: 밥집 찾기 리스트에서 카드를 탭하면 **요약 모델([summary])** 을 그대로 넘겨받아
/// 사진·식당명·평점·거리를 즉시 그린다(리스트→상세 전달). 나머지 상세 정보
/// (주소/영업시간/전화/태그/주간 식단/리뷰)는 [restaurantDetailProvider] 로 비동기 로드한다.
///
/// 앱바: 로고/우측 액션이 없는 단순 상세 앱바([DetailAppBar.showActions] = false,
/// 좌측 뒤로가기 + 가운데 "식당 상세"). 바텀 네비게이션은 없다(루트 네비게이터 위로 push).
/// 하단 고정 CTA 는 재사용 컴포넌트 [SheetButton](하트 + "오늘 여기 갈래요").
class RestaurantDetailScreen extends ConsumerWidget {
  const RestaurantDetailScreen({super.key, required this.summary});

  /// 리스트에서 넘겨받은 요약 정보.
  final RestaurantSummaryModel summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(restaurantDetailProvider(summary.id));

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          const DetailAppBar(title: '식당 상세', showActions: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 헤더(요약 즉시 + 상세 채워지면 보강) ──
                  ColoredBox(
                    color: AppColors.bgInverse,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: RestaurantDetailHeader(
                        summary: summary,
                        detail: detailAsync.asData?.value,
                      ),
                    ),
                  ),
                  // ── 상세 영역(주간 식단 + 리뷰) ──
                  detailAsync.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: AppErrorView(
                        onRetry: () => ref.invalidate(
                          restaurantDetailProvider(summary.id),
                        ),
                      ),
                    ),
                    data: (detail) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        WeeklyMealSection(menus: detail.weeklyMenus),
                        const SizedBox(height: AppSpacing.md),
                        ReviewSection(
                          reviewCount: summary.reviewCount,
                          reviewPhotos: detail.reviewPhotos,
                          reviews: detail.reviews,
                          // TODO(review): 전체 리뷰 화면 생기면 라우팅 연결.
                          onSeeAll: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SheetButton(
          label: '오늘 여기 갈래요',
          // TODO(action): 찜/방문 예약 로직 연결 (백엔드 합의 필요).
          onIconTap: () {},
          onPressed: () {},
        ),
      ),
    );
  }
}
