import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 설정 그룹 카드 안의 한 줄.
///
/// `아이콘 + 제목 + (우측 영역)` 구성. 우측 영역은 셋 중 하나다.
/// - [trailing] 위젯(예: 토글)이 주어지면 그대로 노출.
/// - [value] 가 주어지면 회색 보조 텍스트로 노출.
/// - 그 외에는 [showChevron] 에 따라 오른쪽 화살표를 노출.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.trailing,
    this.showChevron = true,
    this.titleColor,
    this.iconColor,
    this.onTap,
  });

  final IconData icon;
  final String title;

  /// 제목 우측에 붙는 회색 보조 텍스트(예: "꺼짐", "v2.4.1 · 최신").
  final String? value;

  /// 우측 커스텀 위젯(예: 토글). 주어지면 [value]/[showChevron] 보다 우선.
  final Widget? trailing;

  /// 우측 화살표 노출 여부. [trailing] 이 있으면 무시된다.
  final bool showChevron;

  /// 제목 색상(예: 로그아웃은 빨강). 기본은 본문 색.
  final Color? titleColor;

  /// 아이콘 색상. 기본은 보조 색.
  final Color? iconColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            Icon(icon, size: 21, color: iconColor ?? AppColors.textSecondary),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body2Medium.copyWith(
                  color: titleColor ?? AppColors.textPrimary,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else ...[
              if (value != null)
                Text(
                  value!,
                  style: AppTextStyles.body3Medium.copyWith(
                    color: AppColors.textDisable,
                  ),
                ),
              if (showChevron) ...[
                if (value != null) const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.iconDisable,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
