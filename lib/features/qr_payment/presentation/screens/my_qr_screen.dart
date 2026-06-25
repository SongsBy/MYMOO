import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 내 QR 코드(결제 코드) 화면.
///
/// QR 결제 화면 하단 시트의 "내 QR 코드 보기" 에서 진입한다.
/// 매장 직원이 스캔할 수 있도록 사용자의 결제 코드를 QR + 숫자로 보여주고,
/// 화면 진입 시 **네이티브 화면 밝기를 최대로** 올려 어두운 환경에서도
/// 잘 인식되게 한다. (화면을 벗어나면 원래 밝기로 복원)
///
/// Figma node 69425:966.
class MyQrScreen extends StatefulWidget {
  const MyQrScreen({
    super.key,
    this.userName = '길동',
    this.initialCode = '0002 9565 2834',
    this.balance = 1999000,
  });

  /// 헤더에 표시할 사용자 이름. ("○○님의 결제 코드")
  final String userName;

  /// 첫 표시 결제 코드. 자동 갱신 시 새 코드로 교체된다.
  final String initialCode;

  /// 보유중인 무(재화) 수량.
  final int balance;

  @override
  State<MyQrScreen> createState() => _MyQrScreenState();
}

class _MyQrScreenState extends State<MyQrScreen> with WidgetsBindingObserver {
  /// 결제 코드 1회 유효 시간(초). 0 이 되면 새 코드로 자동 갱신된다.
  static const int _cycleSeconds = 60;

  final Random _random = Random();

  late String _code;
  late int _remaining;
  Timer? _ticker;

  /// 네이티브 밝기 부스트가 실제로 적용됐는지 여부.
  /// 적용 성공 시에만 "화면 밝기가 자동으로 밝아졌어요" 안내를 노출한다.
  bool _brightnessBoosted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _code = widget.initialCode;
    _remaining = _cycleSeconds;
    _startTicker();
    unawaited(_boostBrightness());
  }

  @override
  void dispose() {
    _ticker?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_restoreBrightness());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱이 백그라운드로 가면 OS 가 밝기를 되돌리므로, 복귀 시 다시 올린다.
    if (state == AppLifecycleState.resumed) {
      unawaited(_boostBrightness());
    }
  }

  /// 네이티브 화면 밝기를 최대(1.0)로 올린다. (앱 스코프 — 앱 한정)
  Future<void> _boostBrightness() async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(1);
      if (mounted) setState(() => _brightnessBoosted = true);
    } catch (_) {
      // 플랫폼 미지원/실패 시엔 안내만 숨기고 화면은 그대로 동작.
    }
  }

  /// 진입 전 밝기로 복원한다.
  Future<void> _restoreBrightness() async {
    try {
      await ScreenBrightness().resetApplicationScreenBrightness();
    } catch (_) {
      // 복원 실패는 무시 (앱 종료/백그라운드 시 OS 가 정리).
    }
  }

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_remaining <= 1) {
          _code = _generateCode();
          _remaining = _cycleSeconds;
        } else {
          _remaining--;
        }
      });
    });
  }

  /// 12자리 랜덤 결제 코드를 "0000 0000 0000" 형태로 만든다.
  String _generateCode() {
    final buffer = StringBuffer();
    for (var i = 0; i < 12; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(_random.nextInt(10));
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentGreen,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _TopBar(onBack: () => Navigator.of(context).maybePop()),
                _Header(userName: widget.userName),
              ],
            ),
          ),
          Expanded(
            child: _QrSheet(
              code: _code,
              remaining: _remaining,
              balance: widget.balance,
              brightnessBoosted: _brightnessBoosted,
              onScanToPay: () => Navigator.of(context).maybePop(),
            ),
          ),
        ],
      ),
    );
  }
}

/// 상단 앱바 — 뒤로가기 / 중앙 타이틀. (초록 배경 위 흰 콘텐츠)
class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onBack,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textInverse,
                    size: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '내 QR 코드',
                textAlign: TextAlign.center,
                style: AppTextStyles.body1Bold.copyWith(
                  color: AppColors.textInverse,
                ),
              ),
            ),
            // 타이틀을 정확히 가운데 두기 위한 우측 더미 공간.
            const SizedBox(width: 40, height: 40),
          ],
        ),
      ),
    );
  }
}

/// "○○님의 결제 코드" + 안내 문구. (초록 배경)
class _Header extends StatelessWidget {
  const _Header({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.xxl,
      ),
      child: Column(
        children: [
          Text(
            '$userName님의 결제 코드',
            style: AppTextStyles.heading2Bold.copyWith(
              color: AppColors.textInverse,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '매장 직원에게 이 화면을 보여주세요',
            style: AppTextStyles.body3Medium.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// 하단 흰색 시트 — 밝기 안내 / QR / 코드 / 갱신 / 잔액 / 결제 버튼.
class _QrSheet extends StatelessWidget {
  const _QrSheet({
    required this.code,
    required this.remaining,
    required this.balance,
    required this.brightnessBoosted,
    required this.onScanToPay,
  });

  final String code;
  final int remaining;
  final int balance;
  final bool brightnessBoosted;
  final VoidCallback onScanToPay;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            offset: Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xxl,
            28,
            AppSpacing.xxl,
            AppSpacing.xxl,
          ),
          child: Column(
            children: [
              if (brightnessBoosted) ...[
                const _BrightnessChip(),
                const SizedBox(height: AppSpacing.xxl),
              ],
              _QrCard(data: code),
              const SizedBox(height: AppSpacing.xl),
              Text(
                code,
                style: AppTextStyles.body2SemiBold.copyWith(
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _RefreshChip(remaining: remaining),
              const SizedBox(height: 28),
              _BalanceBox(balance: balance),
              const SizedBox(height: AppSpacing.md),
              _ScanToPayButton(onTap: onScanToPay),
            ],
          ),
        ),
      ),
    );
  }
}

/// "화면 밝기가 자동으로 밝아졌어요" 안내 칩.
class _BrightnessChip extends StatelessWidget {
  const _BrightnessChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs6,
      ),
      decoration: const ShapeDecoration(
        color: Color(0xFFF0FAF6),
        shape: StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wb_sunny_rounded,
            size: 14,
            color: AppColors.accentGreen,
          ),
          const SizedBox(width: AppSpacing.xs6),
          Text(
            '화면 밝기가 자동으로 밝아졌어요',
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }
}

/// QR 코드 카드 — 흰 배경 + 옅은 보더/그림자 위에 QR 을 그린다.
/// 중앙에는 브랜드 식별용 "무" 마크를 얹는다.
class _QrCard extends StatelessWidget {
  const _QrCard({required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 190,
            gapless: true,
            // 가운데 "무" 마크가 일부 모듈을 가려도 인식되도록 오류 정정 최대.
            errorCorrectionLevel: QrErrorCorrectLevel.H,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppColors.textPrimary,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppColors.textPrimary,
            ),
          ),
          // 중앙 브랜드 식별 마크.
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.bgInverse,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Text(
              '무',
              style: AppTextStyles.body3Bold.copyWith(
                color: AppColors.accentGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "54초 후 자동 갱신" 칩 (회색 알약 + 새로고침 아이콘).
class _RefreshChip extends StatelessWidget {
  const _RefreshChip({required this.remaining});

  final int remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: 7,
      ),
      decoration: const ShapeDecoration(
        color: AppColors.bgSecondary,
        shape: StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.refresh_rounded,
            size: 13,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: AppSpacing.xs6),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$remaining초',
                  style: AppTextStyles.caption1SemiBold.copyWith(
                    fontSize: 13,
                    color: AppColors.accentGreen,
                  ),
                ),
                TextSpan(
                  text: ' 후 자동 갱신',
                  style: AppTextStyles.caption1Medium.copyWith(
                    fontSize: 13,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "보유중인 무" 잔액 박스.
class _BalanceBox extends StatelessWidget {
  const _BalanceBox({required this.balance});

  final int balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Text(
            '보유중인 무',
            style: AppTextStyles.body3Medium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const Spacer(),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: _formatThousands(balance),
                  style: AppTextStyles.body1Bold,
                ),
                TextSpan(
                  text: '무',
                  style: AppTextStyles.caption1Medium.copyWith(
                    fontSize: 13,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "QR 스캔으로 결제하기" 아웃라인 버튼 (브랜드 보더).
class _ScanToPayButton extends StatelessWidget {
  const _ScanToPayButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.brandPrimary),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_scanner_rounded,
                size: 20,
                color: AppColors.brandPrimary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'QR 스캔으로 결제하기',
                style: AppTextStyles.body2Bold.copyWith(
                  color: AppColors.brandPrimary,
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
