import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 필터 칩 — Figma "Filter chip" (Default / Activation).
///
/// 켜짐/꺼짐을 **하나의 컴포넌트**로 묶어 [selected] 토글로 표현한다.
/// 탭하면 [onSelected] 로 반전된 값이 전달된다.
///
/// 스펙
/// - 공통: radius 999, padding h12 / v6, 14px 텍스트.
/// - 꺼짐(Default): 배경 bgSecondary + 보조 텍스트(Medium), 아이콘 없음.
/// - 켜짐(Activation): 배경 brandBackground + brandSecondary 1.5px 테두리 +
///   brandPrimary 텍스트(SemiBold) + 우측 체크 아이콘(16, 라벨과 2 간격).
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  /// 칩 라벨(내용).
  final String label;

  /// 켜짐 여부. true 면 강조 배경 + 체크 아이콘 노출.
  final bool selected;

  /// 탭 콜백. 반전된 선택 값을 전달한다. null 이면 탭 불가.
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(999);
    final bg =
        selected ? AppColors.brandBackground : AppColors.bgSecondary;
    final textStyle = selected
        ? AppTextStyles.body3SemiBold.copyWith(color: AppColors.brandPrimary)
        : AppTextStyles.body3Medium.copyWith(color: AppColors.textSecondary);

    return Material(
      color: bg,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: selected
            ? const BorderSide(color: AppColors.brandSecondary, width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onSelected == null ? null : () => onSelected!(!selected),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: textStyle),
              if (selected) ...[
                const SizedBox(width: 2),
                SvgPicture.asset(
                  'asset/icons/LineRounded/ic_checkmark.svg',
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.brandPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
