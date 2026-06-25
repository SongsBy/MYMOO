import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/qr_payment_action_sheet.dart';
import '../widgets/qr_scan_overlay.dart';
import 'my_qr_screen.dart';

/// QR 결제 화면.
///
/// 홈의 "QR 결제" 진입 카드에서 전체화면으로 띄운다.
/// 실제 단말 카메라([MobileScanner])로 QR 을 인식하고, 하단 흰 시트에서
/// 보유 잔액/충전/내 QR 보기를 제공한다.
///
/// Figma node 69425:847.
class QrPaymentScreen extends StatefulWidget {
  const QrPaymentScreen({super.key, this.balance = 1999000});

  /// 보유중인 무(재화) 수량. (잔액 provider 연동 전까지 디자인 기본값)
  final int balance;

  @override
  State<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends State<QrPaymentScreen>
    with WidgetsBindingObserver {
  /// 네이티브 카메라 + 바코드 인식 컨트롤러.
  final MobileScannerController _controller = MobileScannerController(
    // 같은 코드를 연속으로 다시 잡지 않도록.
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  final ImagePicker _picker = ImagePicker();

  /// 스캔 성공 애니메이션 표시 중 여부. true 동안엔 추가 인식을 무시한다.
  bool _success = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_controller.dispose());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 백그라운드 전환 시 카메라 자원을 풀고, 복귀하면 다시 시작한다.
    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(_controller.start());
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        unawaited(_controller.stop());
    }
  }

  /// 카메라에서 QR/바코드가 잡혔을 때.
  void _onDetect(BarcodeCapture capture) {
    if (_success) return;
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null || raw.isEmpty) return;
    _onScanned(raw);
  }

  /// 스캔 영역 탭 — 데모용 성공 애니메이션.
  void _onTapDemo() {
    if (_success) return;
    _onScanned(null);
  }

  /// "갤러리에서 QR 불러오기" — 사진을 골라 이미지에서 QR 을 해석한다.
  Future<void> _onPickFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final result = await _controller.analyzeImage(image.path);
    final raw = result?.barcodes.firstOrNull?.rawValue;
    if (!mounted) return;
    if (raw == null || raw.isEmpty) {
      _showSnack('이미지에서 QR 코드를 찾지 못했어요');
      return;
    }
    _onScanned(raw);
  }

  /// 성공 애니메이션을 띄우고, 잠시 후 다시 스캔 대기로 돌아간다.
  ///
  /// [value] 가 null 이면 데모(탭) 성공, 값이 있으면 실제 인식이다.
  void _onScanned(String? value) {
    setState(() => _success = true);
    _showSnack(value == null ? '스캔 데모 — 결제 화면으로 연결됩니다' : 'QR 인식 완료: $value');
    Timer(const Duration(milliseconds: 1600), () {
      if (mounted) setState(() => _success = false);
    });
  }

  /// "내 QR 코드 보기" — 내 결제 코드 화면을 띄운다.
  /// 그동안 카메라는 멈추고, 돌아오면 다시 시작한다.
  Future<void> _openMyQr() async {
    await _controller.stop();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MyQrScreen(balance: widget.balance),
      ),
    );
    if (!mounted) return;
    await _controller.start();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scanDark,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: MobileScanner(
                    controller: _controller,
                    onDetect: _onDetect,
                    errorBuilder: (context, error) =>
                        _CameraError(error: error),
                  ),
                ),
                // 인식 영역 대비를 위한 옅은 상하 어둠.
                const Positioned.fill(
                  child: IgnorePointer(child: _ScanScrim()),
                ),
                Positioned.fill(
                  child: SafeArea(
                    bottom: false,
                    child: _ScanContent(
                      success: _success,
                      onBack: () => Navigator.of(context).maybePop(),
                      onToggleTorch: () => unawaited(_controller.toggleTorch()),
                      torchState: _controller,
                      onTapScan: _onTapDemo,
                      onPickFromGallery: () => unawaited(_onPickFromGallery()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          QrPaymentActionSheet(
            balance: widget.balance,
            onCharge: () => _showSnack('충전 화면은 준비 중이에요'),
            onShowMyQr: _openMyQr,
          ),
        ],
      ),
    );
  }
}

/// 카메라 위 어두운 영역의 실제 콘텐츠(앱바·가이드·스캔 프레임·갤러리 버튼).
class _ScanContent extends StatelessWidget {
  const _ScanContent({
    required this.success,
    required this.onBack,
    required this.onToggleTorch,
    required this.torchState,
    required this.onTapScan,
    required this.onPickFromGallery,
  });

  final bool success;
  final VoidCallback onBack;
  final VoidCallback onToggleTorch;
  final ValueListenable<MobileScannerState> torchState;
  final VoidCallback onTapScan;
  final VoidCallback onPickFromGallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(onBack: onBack, onToggleTorch: onToggleTorch, state: torchState),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'QR 코드를 네모 안에 맞춰주세요',
          style: AppTextStyles.body3Medium.copyWith(
            color: AppColors.textInverse.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GestureDetector(
          onTap: onTapScan,
          behavior: HitTestBehavior.opaque,
          child: QrScanOverlay(success: success),
        ),
        const SizedBox(height: AppSpacing.xxl + AppSpacing.sm),
        Text(
          '자동으로 인식됩니다',
          style: AppTextStyles.body2SemiBold.copyWith(
            color: AppColors.textInverse,
          ),
        ),
        const SizedBox(height: AppSpacing.xs6),
        Text(
          '탭하면 스캔 성공 애니메이션을 볼 수 있어요',
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.textInverse.withValues(alpha: 0.4),
          ),
        ),
        const Spacer(),
        _GalleryButton(onTap: onPickFromGallery),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

/// 상단 앱바 — 뒤로가기 / 타이틀 / 플래시 토글.
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onBack,
    required this.onToggleTorch,
    required this.state,
  });

  final VoidCallback onBack;
  final VoidCallback onToggleTorch;
  final ValueListenable<MobileScannerState> state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            _CircleIconButton(icon: Icons.arrow_back_rounded, onTap: onBack),
            Expanded(
              child: Text(
                'QR 결제',
                textAlign: TextAlign.center,
                style: AppTextStyles.body1Bold.copyWith(
                  color: AppColors.textInverse,
                ),
              ),
            ),
            ValueListenableBuilder<MobileScannerState>(
              valueListenable: state,
              builder: (context, value, _) {
                final on = value.torchState == TorchState.on;
                return _CircleIconButton(
                  icon: on ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                  onTap: onToggleTorch,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 원형 아이콘 버튼(어두운 배경 위 흰 아이콘).
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: AppColors.textInverse, size: 24),
        ),
      ),
    );
  }
}

/// "갤러리에서 QR 불러오기" 알약 버튼.
class _GalleryButton extends StatelessWidget {
  const _GalleryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.textInverse.withValues(alpha: 0.05),
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.textInverse.withValues(alpha: 0.15),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 11,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_outlined,
                size: 15,
                color: AppColors.textInverse.withValues(alpha: 0.6),
              ),
              const SizedBox(width: AppSpacing.xs6),
              Text(
                '갤러리에서 QR 불러오기',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.textInverse.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 카메라 프리뷰 위 상하 그라데이션 스크림(텍스트 가독성용).
class _ScanScrim extends StatelessWidget {
  const _ScanScrim();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xB3000000),
            Color(0x4D000000),
            Color(0x80000000),
            Color(0xCC000000),
          ],
          stops: [0.0, 0.35, 0.7, 1.0],
        ),
      ),
    );
  }
}

/// 카메라 시작 실패(권한 거부 등) 시 대체 화면.
class _CameraError extends StatelessWidget {
  const _CameraError({required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    final isPermission =
        error.errorCode == MobileScannerErrorCode.permissionDenied;
    return ColoredBox(
      color: AppColors.scanDark,
      child: Center(
        child: Padding(
          padding: kScreenHorizontalPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPermission ? Icons.no_photography_outlined : Icons.error_outline,
                color: AppColors.textInverse.withValues(alpha: 0.6),
                size: 44,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                isPermission
                    ? '카메라 권한이 필요해요\n설정에서 카메라 접근을 허용해주세요'
                    : '카메라를 시작할 수 없어요',
                textAlign: TextAlign.center,
                style: AppTextStyles.body3Medium.copyWith(
                  color: AppColors.textInverse.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
