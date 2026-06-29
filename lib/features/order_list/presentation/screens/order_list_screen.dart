import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/app_error_view.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/order_list_provider.dart';
import '../widgets/order_filter_chip.dart';
import '../widgets/past_visit_card.dart';
import '../widgets/reservation_status_card.dart';

/// 주문 내역 탭 화면.
///
/// Figma "order_List" (node 69453:1207). 루트 탭의 하나라 뒤로가기 없는
/// 자체 헤더("주문 내역")를 가지며, RootTabScreen 은 이 탭에서 공통 로고
/// 앱바([HomeAppBar])를 숨긴다.
///
/// 구성: 헤더 + 필터 칩 + (예약 확정 카드 / 지난 방문 목록).
/// 데이터는 [orderListProvider] 로 로드하고 `AsyncValue.when` 으로 분기한다.
class OrderListScreen extends ConsumerWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsync = ref.watch(orderListProvider);

    return Column(
      children: [
        const _Header(),
        const _FilterBar(),
        Expanded(
          child: orderListAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => AppErrorView(
              onRetry: () => ref.invalidate(orderListProvider),
            ),
            data: (data) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                children: [
                  if (data.reservation != null) ...[
                    const _SectionBadge(text: '예약 확정'),
                    const SizedBox(height: AppSpacing.md),
                    ReservationStatusCard(reservation: data.reservation!),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                  if (data.pastVisits.isNotEmpty) ...[
                    const _SectionLabel(text: '지난 방문'),
                    const SizedBox(height: AppSpacing.md),
                    for (var i = 0; i < data.pastVisits.length; i++) ...[
                      if (i > 0) const SizedBox(height: AppSpacing.md),
                      PastVisitCard(visit: data.pastVisits[i]),
                    ],
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 화면 자체 헤더 — 가운데 "주문 내역" (루트 탭이라 뒤로가기 없음).
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgInverse,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Center(
            child: Text(
              '내 식사',
              style: AppTextStyles.body1SemiBold
                  .copyWith(color: AppColors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

/// 상단 필터 칩 바.
///
/// 라벨: 전체 / 리뷰 / 거래내역 / 찜한 식당.
/// "리뷰"는 지난 방문 카드가 강조하는 리뷰 작성(3일 제한)을 마감 전에
/// 유도하도록 "전체" 다음(2번째)에 배치했다.
/// 선택은 현재 시각적 토글만 한다.
/// TODO(backend): 선택된 필터로 [orderListProvider] 질의를 분기한다. (백엔드 합의 필요)
class _FilterBar extends StatefulWidget {
  const _FilterBar();

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  static const _filters = ['전체', '리뷰', '거래내역', '찜한 식당'];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    // 배경 컨테이너 없이 칩만 배치한다(화면 배경 위에 그대로 노출).
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            for (var i = 0; i < _filters.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.sm),
              OrderFilterChip(
                label: _filters[i],
                selected: i == _selected,
                onTap: () => setState(() => _selected = i),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 강조 배지 라벨(brandBackground 배경) — "예약 확정".
class _SectionBadge extends StatelessWidget {
  const _SectionBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.brandBackground,
          borderRadius: BorderRadius.circular(AppRadius.sm / 2),
        ),
        child: Text(
          text,
          style: AppTextStyles.body3Bold.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

/// 일반 섹션 라벨 — "지난 방문".
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Text(
        text,
        style: AppTextStyles.body3Bold.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
