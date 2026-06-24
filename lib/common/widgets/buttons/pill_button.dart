import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import 'app_button.dart';

/// 알약(pill) 모양 플로팅 CTA 버튼 — Figma "Button_M / CTA btn".
///
/// 브랜드 색 배경 + 반전 텍스트·아이콘에 완전히 둥근 모서리와 그림자를 더해
/// 콘텐츠 위에 떠 있는 액션(예: "지도 보기")에 쓴다. 내용 크기에 맞춰 줄어든다.
/// 라벨 뒤에 `+`(Line Rounded) 아이콘이 붙는다.
///
/// 스펙: 배경 brandPrimary / radius 999(완전 둥글게) / padding h16·v12 /
/// 라벨–아이콘 간격 4 / 아이콘 24 / 그림자 0·4·5 검정 12%.
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  /// 버튼 라벨.
  final String label;

  /// 탭 콜백. null 이면 비활성 상태.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      borderRadius: 999,
      gap: 4,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      boxShadow: const [
        BoxShadow(
          color: AppColors.opacity12,
          offset: Offset(0, 4),
          blurRadius: 5,
        ),
      ],
      trailing: SvgPicture.asset(
        'asset/icons/LineRounded/ic_plus.svg',
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.iconInverse,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
