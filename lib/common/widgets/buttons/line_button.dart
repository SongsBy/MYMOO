import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import 'app_button.dart';

/// 라인(아웃라인) 브랜드 버튼 — Figma "Button_XL / line brand".
///
/// 흰 배경 + 브랜드 색 테두리·텍스트·아이콘으로 그려지는 보조 강조 버튼.
/// 라벨 뒤에 `+`(Line Rounded) 아이콘이 붙는다.
///
/// 스펙: 배경 white / 테두리 brandPrimary 1px / radius 16 /
/// padding h16·v13 / 라벨–아이콘 간격 6 / 아이콘 24.
class LineButton extends StatelessWidget {
  const LineButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
  });

  /// 버튼 라벨.
  final String label;

  /// 탭 콜백. null 이면 비활성 상태.
  final VoidCallback? onPressed;

  /// 가로를 꽉 채울지 여부. 기본 true.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      expanded: expanded,
      backgroundColor: AppColors.bgInverse,
      foregroundColor: AppColors.brandPrimary,
      border: const BorderSide(color: AppColors.brandPrimary),
      borderRadius: 16,
      gap: 6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      trailing: SvgPicture.asset(
        'asset/icons/LineRounded/ic_plus.svg',
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.iconBrand,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
