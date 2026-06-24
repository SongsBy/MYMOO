import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// [AppCategoryChip] 크기 단계.
///
/// 디자인의 "size" 속성에 대응한다.
/// - [xl]: padding h16 / v8 (기본)
/// - [l] : padding h12 / v4 (조밀한 영역)
enum AppCategoryChipSize {
  xl(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
  l(EdgeInsets.symmetric(horizontal: 12, vertical: 4));

  const AppCategoryChipSize(this.padding);

  /// 칩 내부 패딩.
  final EdgeInsets padding;
}

/// 카테고리 선택 칩 — Figma "Category chip" (Activation / Disabld).
///
/// 활성/비활성(= 선택/미선택)을 **하나의 컴포넌트**로 묶어 [selected] 토글로
/// 표현한다. 탭하면 [onSelected] 로 반전된 값이 전달된다.
///
/// 스펙
/// - 공통: radius 999(완전 둥글게), 14px 텍스트, line-height 140%.
/// - 선택(Activation): 배경 brandPrimary + 반전 텍스트(Bold).
/// - 미선택(Disabld): 흰 배경 + borderPrimary 테두리 + 보조 텍스트(Medium).
class AppCategoryChip extends StatelessWidget {
  const AppCategoryChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.size = AppCategoryChipSize.xl,
  });

  /// 칩 라벨(카테고리명).
  final String label;

  /// 선택(활성) 여부. true 면 brandPrimary 채움.
  final bool selected;

  /// 탭 콜백. 반전된 선택 값을 전달한다. null 이면 탭 불가.
  final ValueChanged<bool>? onSelected;

  /// 크기 단계. 기본 [AppCategoryChipSize.xl].
  final AppCategoryChipSize size;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(999);
    final bg = selected ? AppColors.brandPrimary : AppColors.bgInverse;
    final textStyle = selected
        ? AppTextStyles.body3Bold.copyWith(color: AppColors.textInverse)
        : AppTextStyles.body3Medium.copyWith(color: AppColors.textSecondary);

    return Material(
      color: bg,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: selected
            ? BorderSide.none
            : const BorderSide(color: AppColors.borderPrimary),
      ),
      child: InkWell(
        onTap: onSelected == null ? null : () => onSelected!(!selected),
        child: Padding(
          padding: size.padding,
          child: Text(label, style: textStyle),
        ),
      ),
    );
  }
}
