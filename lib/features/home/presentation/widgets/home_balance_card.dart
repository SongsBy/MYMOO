import 'package:flutter/material.dart';

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

  static const String _characterAsset = 'asset/images/home/mymoo_ch.png';

  /// 캐릭터 렌더링 크기. 이 값만 키우면 카드 위로 더 튀어나온다.
  static const double _characterSize = 130;

  /// 카드 안에서 캐릭터가 차지할 가로 자리(텍스트와 겹치지 않게 확보).
  static const double _characterSlotWidth = 96;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.md);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
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
                  // 캐릭터가 올라갈 자리만 비워둔다(실제 이미지는 Stack 위에).
                  const SizedBox(width: _characterSlotWidth),
                ],
              ),
            ),
          ),
        ),
        // 카드 위에 겹쳐서, 위쪽으로 튀어나오게 그린다.
        Positioned(
          right: 0,
          top: 0,
          child: IgnorePointer(
            child: Image.asset(
              _characterAsset,
              width: _characterSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
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
