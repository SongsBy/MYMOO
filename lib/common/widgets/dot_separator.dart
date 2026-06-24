import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// 텍스트·정보 사이를 구분하는 작은 점(•).
///
/// Figma 전반(식당 요약/상세의 "안산시 단원구 · 10m · …", 메뉴 구성, 리뷰 메타 등)에서
/// 반복되는 3px 회색 점을 한 곳에서 정의해 재사용한다.
class DotSeparator extends StatelessWidget {
  const DotSeparator({
    super.key,
    this.size = 3,
    this.color = AppColors.textTertiary,
  });

  /// 점 지름. 기본 3.
  final double size;

  /// 점 색상. 기본 textTertiary.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
