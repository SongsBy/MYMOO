import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 보유 무(재화) 잔액 카드 — 초록 배경 + 캐릭터 일러스트.
///
/// Figma node 69379:1259.
class HomeBalanceCard extends StatelessWidget {
  const HomeBalanceCard({
    super.key,
    required this.title,
    required this.balance,
    required this.caption,
    this.onTap,
  });

  /// 상단 라벨. 예: "보유중인 무".
  final String title;

  /// 보유 수량. 천 단위 콤마로 포맷된다.
  final int balance;

  /// 하단 보조 문구. 예: "이번 달 27무를 사용했어요".
  final String caption;

  /// 탭 콜백. null 이면 탭 비활성.
  final VoidCallback? onTap;

  static const String _characterAsset = 'asset/images/home/maimu_character.svg';

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.md);
    return Material(
      color: AppColors.accentGreen,
      clipBehavior: Clip.antiAlias,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body2SemiBold.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _formatThousands(balance),
                      style: AppTextStyles.heading1Bold.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      caption,
                      style: AppTextStyles.body3Medium.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              SvgPicture.asset(_characterAsset, height: 90),
            ],
          ),
        ),
      ),
    );
  }
}

/// 천 단위 콤마 포맷. (intl 미사용 — 단순 정수 그룹핑)
String _formatThousands(int value) {
  final digits = value.abs().toString();
  final buffer = StringBuffer(value < 0 ? '-' : '');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}
