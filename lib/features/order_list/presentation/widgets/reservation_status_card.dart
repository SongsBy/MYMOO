import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/order_list_entities.dart';
import 'order_thumbnail.dart';

/// 진행 중인 예약(예약 확정) 카드.
///
/// Figma node 69453:1243. 배너 + 식당 정보 + 진행 타임라인 + 하단 버튼(길찾기/예약상세).
///
/// 버튼 콜백은 추후 API/라우팅 연동 지점이다(현재는 placeholder).
class ReservationStatusCard extends StatelessWidget {
  const ReservationStatusCard({
    super.key,
    required this.reservation,
    this.onDirections,
    this.onDetail,
  });

  final ReservationStatus reservation;
  final VoidCallback? onDirections;
  final VoidCallback? onDetail;

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
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Banner(text: reservation.bannerText),
            const SizedBox(height: AppSpacing.lg),
            _RestaurantInfo(reservation: reservation),
            const SizedBox(height: AppSpacing.xl),
            _Timeline(steps: reservation.steps),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: _OutlinedAction(
                    icon: Icons.near_me_outlined,
                    label: '길찾기',
                    onTap: onDirections,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _OutlinedAction(
                    icon: Icons.description_outlined,
                    label: '예약상세',
                    onTap: onDetail,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 카드 그림자 — 검정 4% (Figma drop-shadow 0·2·4 rgba(0,0,0,0.04)).
/// 그림자 색은 토큰화돼 있지 않아 RootBottomNav 와 동일하게 인라인 상수로 둔다.
const Color _cardShadow = Color(0x0A000000);

/// 상단 배너 — "사장님이 자리를 잡아두었어요".
class _Banner extends StatelessWidget {
  const _Banner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.brandBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.accentGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 16,
              color: AppColors.iconInverse,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: AppTextStyles.body3SemiBold
                  .copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

/// 식당 썸네일 + 이름 + 요약 + 남은 시간.
class _RestaurantInfo extends StatelessWidget {
  const _RestaurantInfo({required this.reservation});

  final ReservationStatus reservation;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderThumbnail(
          imageUrl: reservation.imageUrl,
          size: 64,
          borderRadius: AppRadius.md,
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reservation.restaurantName,
                style: AppTextStyles.body1Bold
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                reservation.summary,
                style: AppTextStyles.body3Regular
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: AppColors.brandPrimary,
                  ),
                  const SizedBox(width: AppSpacing.xs6),
                  Flexible(
                    child: Text(
                      reservation.remainingText,
                      style: AppTextStyles.body3Bold
                          .copyWith(color: AppColors.brandPrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 예약 진행 타임라인(요청 → 확정 → 방문).
class _Timeline extends StatelessWidget {
  const _Timeline({required this.steps});

  final List<ReservationStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          _TimelineRow(step: steps[i], isLast: i == steps.length - 1),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.step, required this.isLast});

  final ReservationStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _StepDot(done: step.done),
              if (!isLast)
                const Expanded(
                  child: SizedBox(
                    width: 2,
                    child: ColoredBox(color: AppColors.brandPrimary),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: step.done
                        ? AppTextStyles.body3SemiBold
                            .copyWith(color: AppColors.textPrimary)
                        : AppTextStyles.body3Medium
                            .copyWith(color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    step.subtitle,
                    style: AppTextStyles.caption1Medium
                        .copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 타임라인 단계 점. 완료=brand 원 + 흰 체크, 예정=흰 원 + 보더.
class _StepDot extends StatelessWidget {
  const _StepDot({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: done ? AppColors.brandPrimary : AppColors.bgInverse,
        shape: BoxShape.circle,
        border: done
            ? null
            : Border.all(color: AppColors.borderPrimary, width: 2),
      ),
      child: done
          ? const Icon(Icons.check_rounded, size: 12, color: AppColors.iconInverse)
          : null,
    );
  }
}

/// 라인(아웃라인) 보조 액션 버튼 — 아이콘 + 라벨.
class _OutlinedAction extends StatelessWidget {
  const _OutlinedAction({
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
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.borderPrimary),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: AppColors.iconSecondary),
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
