import 'package:flutter/widgets.dart';

import 'app_colors.dart';

/// 앱 전역에서 사용하는 텍스트 스타일 모음.
///
/// 위젯에서 `TextStyle(...)` 을 직접 생성하지 말고, 여기 정의된 상수를 사용한다.
/// 색상만 다르게 써야 한다면 사용처에서 `.copyWith(color: ...)` 로 덮어쓴다.
///
/// 디자인 스펙
/// - 폰트: Pretendard (pubspec.yaml 의 family 명과 일치)
/// - line-height: 전부 140% → Flutter 의 [TextStyle.height] 는 배수이므로 1.4
abstract final class AppTextStyles {
  // 인스턴스화 방지.
  const AppTextStyles._();

  /// 폰트 크기. line-height 140% 는 항상 height: 1.4 로 환산된다.
  static const double _lineHeight = 1.4;

  /// 모든 스타일이 공유하는 기본값 (폰트/줄높이/색상).
  /// 각 스타일은 이 헬퍼에 크기와 두께만 더해 재사용한다.
  static TextStyle _base(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: _lineHeight,
      color: AppColors.textPrimary,
    );
  }

  // Heading2 — 20px
  static final TextStyle heading2Bold = _base(20, FontWeight.w700);
  static final TextStyle heading2SemiBold = _base(20, FontWeight.w600);
  static final TextStyle heading2Medium = _base(20, FontWeight.w500);

  // Body1 — 18px
  static final TextStyle body1Bold = _base(18, FontWeight.w700);
  static final TextStyle body1SemiBold = _base(18, FontWeight.w600);
  static final TextStyle body1Medium = _base(18, FontWeight.w500);

  // Body2 — 16px
  static final TextStyle body2Bold = _base(16, FontWeight.w700);
  static final TextStyle body2SemiBold = _base(16, FontWeight.w600);
  static final TextStyle body2Medium = _base(16, FontWeight.w500);

  // Body3 — 14px
  static final TextStyle body3Bold = _base(14, FontWeight.w700);
  static final TextStyle body3SemiBold = _base(14, FontWeight.w600);
  static final TextStyle body3Medium = _base(14, FontWeight.w500);
  static final TextStyle body3Regular = _base(14, FontWeight.w400);

  // Caption1 — 12px
  static final TextStyle caption1Bold = _base(12, FontWeight.w700);
  static final TextStyle caption1SemiBold = _base(12, FontWeight.w600);
  static final TextStyle caption1Medium = _base(12, FontWeight.w500);
}
