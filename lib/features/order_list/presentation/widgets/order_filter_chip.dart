import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 주문 내역 상단 필터 칩 (전체 / 리뷰 / 거래내역 / 찜한 식당).
///
/// 공용 [AppFilterChip] 과 시각 스펙이 달라(선택=brand 솔리드 배경,
/// 비선택=흰 배경+보더) 이 화면 전용으로 둔다.
///
/// 스펙(Figma node 69453:1228~1236)
/// - 공통: 높이 39, radius 999, 14px SemiBold, 좌우 16. 모든 칩이 동일 높이
///   (Figma `h-full`)라 보더 유무와 무관하게 높이가 같다.
/// - 선택: 배경 brandPrimary + 흰 텍스트.
/// - 비선택: 흰 배경 + borderPrimary 1px + textSecondary 텍스트.
class OrderFilterChip extends StatelessWidget {
  const OrderFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
  });

  /// Figma 칩 행 높이(node 69453:1228). 모든 칩이 이 높이로 통일된다.
  static const double _height = 39;

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Material(
        color: selected ? AppColors.brandPrimary : AppColors.bgInverse,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: selected
              ? BorderSide.none
              : const BorderSide(color: AppColors.borderPrimary),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // 고정 높이 안에서 세로 중앙 정렬(widthFactor 로 가로는 내용 폭만).
            child: Center(
              widthFactor: 1,
              child: Text(
                label,
                style: AppTextStyles.body3SemiBold.copyWith(
                  color: selected
                      ? AppColors.textInverse
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
