import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/order_list_entities.dart';
import 'order_thumbnail.dart';

/// 지난 방문 1건 카드.
///
/// Figma node 69453:1312. 썸네일 + 이름/경과시간 + 주문 요약 +
/// 액션 버튼(리뷰쓰기/가게보기/방문상세) + 리뷰 안내 문구.
///
/// 버튼 콜백은 추후 API/라우팅 연동 지점이다(현재는 placeholder).
class PastVisitCard extends StatelessWidget {
  const PastVisitCard({
    super.key,
    required this.visit,
    this.onWriteReview,
    this.onViewStore,
    this.onViewDetail,
  });

  final PastVisit visit;
  final VoidCallback? onWriteReview;
  final VoidCallback? onViewStore;
  final VoidCallback? onViewDetail;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: const [
          BoxShadow(color: _cardShadow, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderThumbnail(
                  imageUrl: visit.imageUrl,
                  size: 44,
                  borderRadius: 999,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              visit.restaurantName,
                              style: AppTextStyles.body3Bold
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            visit.timeAgo,
                            style: AppTextStyles.caption1Medium
                                .copyWith(color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        visit.orderSummary,
                        style: AppTextStyles.body3Regular
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _Action(
                    icon: Icons.edit_outlined,
                    label: '리뷰쓰기',
                    onTap: onWriteReview,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _Action(
                    icon: Icons.storefront_outlined,
                    label: '가게보기',
                    onTap: onViewStore,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _Action(
                    icon: Icons.receipt_long_outlined,
                    label: '방문상세',
                    onTap: onViewDetail,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              visit.reviewNotice,
              style: AppTextStyles.caption1Medium
                  .copyWith(color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}

/// 카드 그림자 — 검정 4% (Figma drop-shadow 0·2·4 rgba(0,0,0,0.04)).
const Color _cardShadow = Color(0x0A000000);

/// 지난 방문 카드의 작은 액션 버튼(아이콘 + 라벨, radius 10).
class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgInverse,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.borderPrimary),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: AppColors.iconSecondary),
              const SizedBox(width: AppSpacing.xs6),
              Text(
                label,
                style: AppTextStyles.body3Medium
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
