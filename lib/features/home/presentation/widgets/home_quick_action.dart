import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 홈 하단 4분할 퀵 액션 1개 — 원형 아이콘 + 라벨.
///
/// Figma node 69379:1303 등. 부모 [Row] 에서 [Expanded] 로 균등 분할한다.
class HomeQuickAction extends StatelessWidget {
  const HomeQuickAction({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  /// 74×74 원형 아이콘 위젯. [QuickActionCircleIcon] 사용을 권장.
  final Widget icon;

  /// 아이콘 아래 라벨. 예: "찜한 식당".
  final String label;

  /// 탭 콜백. null 이면 탭 비활성.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: AppSpacing.lg - 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.body3Medium,
          ),
        ],
      ),
    );
  }
}

/// 퀵 액션용 74px 원형 아이콘.
///
/// 두 가지 형태를 지원한다.
/// - [QuickActionCircleIcon.full] : 원+아이콘이 한 SVG 에 모두 포함된 경우.
/// - [QuickActionCircleIcon.composed] : 흰 원 위에 내부 아이콘 SVG 를 올리는 경우.
class QuickActionCircleIcon extends StatelessWidget {
  /// 원과 아이콘이 한 SVG 에 담긴 형태.
  const QuickActionCircleIcon.full(this.fullAsset, {super.key})
    : innerAsset = null,
      innerSize = null;

  /// 흰 원 배경 위에 내부 아이콘 SVG 를 올리는 형태.
  const QuickActionCircleIcon.composed({
    super.key,
    required String inner,
    required double size,
  }) : fullAsset = null,
       innerAsset = inner,
       innerSize = size;

  static const double _size = 74;

  final String? fullAsset;
  final String? innerAsset;
  final double? innerSize;

  @override
  Widget build(BuildContext context) {
    if (fullAsset != null) {
      return SvgPicture.asset(fullAsset!, width: _size, height: _size);
    }
    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.bgInverse,
              shape: BoxShape.circle,
            ),
            child: SizedBox.expand(),
          ),
          SvgPicture.asset(innerAsset!, height: innerSize),
        ],
      ),
    );
  }
}
