import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 홈 프로모션 배너 — 주황 배경 + 우하단 진행 카운터.
///
/// Figma node 69379:1294.
class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({
    super.key,
    required this.title,
    required this.highlight,
    this.current,
    this.total,
    this.onTap,
  });

  /// 윗줄 문구. 예: "마이무 회원이면 누구나".
  final String title;

  /// 강조(아랫줄) 문구. 예: "이번 달 첫 결제 시 5무 증정!".
  final String highlight;

  /// 진행 카운터 현재값. [current] 와 [total] 이 모두 있으면 우하단에 표시.
  final int? current;

  /// 진행 카운터 전체값.
  final int? total;

  /// 탭 콜백. null 이면 탭 비활성.
  final VoidCallback? onTap;

  bool get _hasCounter => current != null && total != null;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.brandSecondary,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        // 텍스트 폭이 아니라 가용 가로폭을 모두 채우도록 강제한다.
        child: Stack(
          children: [
            const SizedBox(width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body2Medium.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs6),
                  Text(
                    highlight,
                    style: AppTextStyles.body1Bold.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                ],
              ),
            ),
            if (_hasCounter)
              Positioned(
                right: 10,
                bottom: 10,
                child: _Counter(current: current!, total: total!),
              ),
          ],
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.opacity40,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        '$current / $total',
        style: AppTextStyles.caption1SemiBold.copyWith(
          color: AppColors.textInverse,
        ),
      ),
    );
  }
}
