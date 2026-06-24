import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 공통 버튼.
///
/// 텍스트만 두거나(앞/뒤) 아이콘을 곁들일 수 있다.
/// - 앞 아이콘: [leading], 뒤 아이콘: [trailing] (각각 위젯 주입).
/// - [expanded] = true 면 가로 꽉 채움(주 액션 버튼). false 면 내용 크기.
///
/// 색/배경은 디자인 토큰 기본값(brandPrimary)을 쓰되 파라미터로 교체 가능.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.trailing,
    this.expanded = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.border,
    this.boxShadow,
    this.gap = 8,
  });

  /// 버튼 라벨.
  final String label;

  /// 탭 콜백. null 이면 비활성(disabled) 상태로 그린다.
  final VoidCallback? onPressed;

  /// 라벨 앞(좌측) 아이콘.
  final Widget? leading;

  /// 라벨 뒤(우측) 아이콘.
  final Widget? trailing;

  /// 가로를 꽉 채울지 여부.
  final bool expanded;

  /// 배경색. 미지정 시 brandPrimary.
  final Color? backgroundColor;

  /// 전경(텍스트/아이콘)색. 미지정 시 textInverse.
  final Color? foregroundColor;

  /// 모서리 둥글기. 기본 8.
  final double borderRadius;

  /// 내부 패딩. 기본 h20 / v14.
  final EdgeInsetsGeometry padding;

  /// 테두리. 미지정 시 테두리 없음(라인/아웃라인 버튼에서 지정).
  final BorderSide? border;

  /// 그림자. 미지정 시 그림자 없음(플로팅 버튼 등에서 지정).
  final List<BoxShadow>? boxShadow;

  /// 라벨과 아이콘 사이 간격. 기본 8.
  final double gap;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final bg = enabled
        ? (backgroundColor ?? AppColors.brandPrimary)
        : AppColors.brandTertiary;
    final fg = foregroundColor ?? AppColors.textInverse;
    final radius = BorderRadius.circular(borderRadius);

    Widget button = Material(
      color: bg,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: border ?? BorderSide.none,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: gap),
              ],
              Text(
                label,
                style: AppTextStyles.body1Bold.copyWith(color: fg),
              ),
              if (trailing != null) ...[
                SizedBox(width: gap),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );

    if (boxShadow != null) {
      button = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: boxShadow,
        ),
        child: button,
      );
    }

    return button;
  }
}
