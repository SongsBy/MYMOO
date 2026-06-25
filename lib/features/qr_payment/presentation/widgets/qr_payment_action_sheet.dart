import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// QR 결제 화면 하단의 흰색 액션 시트.
///
/// 보유 무 잔액 + 충전하기 칩, 그리고 "내 QR 코드 보기" CTA 버튼으로 구성된다.
/// 카메라 영역(어두운 상단) 아래에 고정으로 붙는다.
///
/// Figma node 69425:910.
class QrPaymentActionSheet extends StatelessWidget {
  const QrPaymentActionSheet({
    super.key,
    required this.balance,
    this.onCharge,
    this.onShowMyQr,
  });

  /// 보유중인 무(재화) 수량. 천 단위 콤마로 표시된다.
  final int balance;

  /// 충전하기 칩 탭 콜백.
  final VoidCallback? onCharge;

  /// "내 QR 코드 보기" 버튼 탭 콜백.
  final VoidCallback? onShowMyQr;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bgInverse,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BalanceRow(balance: balance, onCharge: onCharge),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: _ShowMyQrButton(onTap: onShowMyQr),
            ),
          ],
        ),
      ),
    );
  }
}

/// 보유 잔액 + 충전하기 칩 행. 하단에 옅은 구분선을 둔다.
class _BalanceRow extends StatelessWidget {
  const _BalanceRow({required this.balance, this.onCharge});

  final int balance;
  final VoidCallback? onCharge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderSecondary),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        17,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '보유중인 무',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: _formatThousands(balance),
                        style: AppTextStyles.heading1Bold,
                      ),
                      TextSpan(
                        text: '무',
                        style: AppTextStyles.caption1Medium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _ChargeChip(onTap: onCharge),
        ],
      ),
    );
  }
}

/// 초록 알약형 "충전하기 >" 칩.
class _ChargeChip extends StatelessWidget {
  const _ChargeChip({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0FAF6),
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '충전하기',
                style: AppTextStyles.caption1SemiBold.copyWith(
                  color: AppColors.accentGreen,
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
              const Icon(
                Icons.chevron_right_rounded,
                size: 14,
                color: AppColors.accentGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 브랜드색 "내 QR 코드 보기" 메인 CTA 버튼.
class _ShowMyQrButton extends StatelessWidget {
  const _ShowMyQrButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.brandPrimary,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_2_rounded,
                size: 20,
                color: AppColors.textInverse,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '내 QR 코드 보기',
                style: AppTextStyles.body2Bold.copyWith(
                  color: AppColors.textInverse,
                ),
              ),
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
