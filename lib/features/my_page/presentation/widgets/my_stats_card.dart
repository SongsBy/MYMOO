import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 한 칸의 통계 데이터(값·라벨·강조 색).
class MyStat {
  const MyStat({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;
}

/// 보유 무/쿠폰/찜한 식당 등 통계 3칸을 세로 구분선으로 나눠 보여주는 카드.
class MyStatsCard extends StatelessWidget {
  const MyStatsCard({super.key, required this.stats});

  final List<MyStat> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              if (i > 0)
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColors.borderSecondary,
                  indent: 16,
                  endIndent: 16,
                ),
              Expanded(child: _StatColumn(stat: stats[i])),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.stat});

  final MyStat stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            stat.value,
            style: AppTextStyles.heading2SemiBold.copyWith(color: stat.color),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: AppTextStyles.body3Medium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
