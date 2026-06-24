import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 정적(선택 불가) 태그 칩 — Figma 식당 상세의 "국물 좋음 / 넉넉한 양 …" 태그.
///
/// 선택 토글이 있는 [AppCategoryChip]/[AppFilterChip] 과 달리,
/// 단순히 식당 속성을 나열하는 표시 전용 칩이다.
///
/// 스펙: 배경 bgSecondary / radius 999 / padding h12·v6 / body3Medium(보조 텍스트).
class AppTagChip extends StatelessWidget {
  const AppTagChip({super.key, required this.label});

  /// 칩 라벨.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs6,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: AppTextStyles.body3Medium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
