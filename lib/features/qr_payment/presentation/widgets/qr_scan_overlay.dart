import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

/// QR 스캔 가이드 프레임.
///
/// 카메라 프리뷰 위에 겹쳐 그리는 248×248 정사각 프레임이다.
/// - 네 모서리에 초록 'ㄱ'자 브래킷.
/// - 평소엔 위아래로 움직이는 스캔 라인.
/// - [success] 가 true 면 스캔 성공 체크 애니메이션으로 전환된다.
///
/// Figma node 69425:887 (스캔 영역).
class QrScanOverlay extends StatefulWidget {
  const QrScanOverlay({super.key, this.size = 248, this.success = false});

  /// 프레임 한 변 길이.
  final double size;

  /// 스캔 성공 상태. true 면 체크 애니메이션을 보여준다.
  final bool success;

  @override
  State<QrScanOverlay> createState() => _QrScanOverlayState();
}

class _QrScanOverlayState extends State<QrScanOverlay>
    with TickerProviderStateMixin {
  /// 스캔 라인 왕복 애니메이션.
  late final AnimationController _lineController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat(reverse: true);

  /// 성공 체크 등장 애니메이션.
  late final AnimationController _successController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  /// 브래킷 한 변 길이.
  static const double _bracketLength = 32;

  /// 브래킷 두께.
  static const double _bracketThickness = 3;

  @override
  void didUpdateWidget(QrScanOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.success && !oldWidget.success) {
      _lineController.stop();
      _successController.forward(from: 0);
    } else if (!widget.success && oldWidget.success) {
      _successController.reverse();
      _lineController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _lineController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 네 모서리 브래킷.
          ..._corners(),
          // 스캔 라인 (성공 전).
          if (!widget.success)
            Positioned.fill(
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: _lineController,
                  builder: (context, _) {
                    final top =
                        _lineController.value * (widget.size - _scanLineHeight);
                    return Stack(
                      children: [
                        Positioned(
                          top: top,
                          left: 0,
                          right: 0,
                          child: const _ScanLine(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          // 성공 체크.
          Positioned.fill(
            child: Center(
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _successController,
                  curve: Curves.elasticOut,
                ),
                child: FadeTransition(
                  opacity: _successController,
                  child: const _SuccessCheck(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const double _scanLineHeight = 2;

  List<Widget> _corners() {
    // (top, bottom, left, right) 중 해당 모서리에 0, 나머지는 null.
    return [
      // 좌상
      _bar(top: 0, left: 0, horizontal: true),
      _bar(top: 0, left: 0, horizontal: false),
      // 우상
      _bar(top: 0, right: 0, horizontal: true),
      _bar(top: 0, right: 0, horizontal: false),
      // 좌하
      _bar(bottom: 0, left: 0, horizontal: true),
      _bar(bottom: 0, left: 0, horizontal: false),
      // 우하
      _bar(bottom: 0, right: 0, horizontal: true),
      _bar(bottom: 0, right: 0, horizontal: false),
    ];
  }

  Widget _bar({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required bool horizontal,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: horizontal ? _bracketLength : _bracketThickness,
        height: horizontal ? _bracketThickness : _bracketLength,
        decoration: BoxDecoration(
          color: AppColors.accentGreen,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ),
    );
  }
}

/// 위아래로 움직이는 그라데이션 스캔 라인.
class _ScanLine extends StatelessWidget {
  const _ScanLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x001D9E75),
            Color(0x4D1D9E75),
            AppColors.accentGreen,
            Color(0xFF37DB96),
            AppColors.accentGreen,
            Color(0x4D1D9E75),
            Color(0x001D9E75),
          ],
          stops: [0.0, 0.15, 0.4, 0.5, 0.6, 0.85, 1.0],
        ),
        boxShadow: [BoxShadow(color: Color(0x6637DB96), blurRadius: 12)],
      ),
    );
  }
}

/// 스캔 성공 시 가운데에 뜨는 초록 체크 원.
class _SuccessCheck extends StatelessWidget {
  const _SuccessCheck();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.accentGreen,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Color(0x6637DB96), blurRadius: 24)],
      ),
      child: const Icon(
        Icons.check_rounded,
        color: AppColors.textInverse,
        size: 44,
      ),
    );
  }
}
