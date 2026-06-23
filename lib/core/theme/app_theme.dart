import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// 앱 전역 [ThemeData] 구성.
///
/// [AppColors] 와 [AppTextStyles] 를 묶어 Material 테마로 노출한다.
/// `MaterialApp.theme: AppTheme.light` 형태로 연결해서 사용한다.
abstract final class AppTheme {
  // 인스턴스화 방지.
  const AppTheme._();

  /// 라이트 테마 (현재 앱은 라이트 모드 단일 운영).
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.brandPrimary,
      secondary: AppColors.brandSecondary,
      surface: AppColors.bgInverse,
      error: AppColors.accentRed,
      onPrimary: AppColors.textInverse,
      onSecondary: AppColors.textInverse,
      onSurface: AppColors.textPrimary,
      onError: AppColors.textInverse,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Pretendard',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      // 텍스트 토큰은 AppTextStyles 를 그대로 매핑한다.
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgInverse,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.iconPrimary),
      ),
      iconTheme: const IconThemeData(color: AppColors.iconPrimary),
      dividerColor: AppColors.borderPrimary,
    );
  }

  /// Material 텍스트 슬롯 ↔ [AppTextStyles] 매핑.
  static final TextTheme _textTheme = TextTheme(
    titleLarge: AppTextStyles.heading2Bold, // 20 / Bold
    titleMedium: AppTextStyles.body1SemiBold, // 18 / SemiBold
    titleSmall: AppTextStyles.body2SemiBold, // 16 / SemiBold
    bodyLarge: AppTextStyles.body2Medium, // 16 / Medium
    bodyMedium: AppTextStyles.body3Regular, // 14 / Regular
    bodySmall: AppTextStyles.caption1Medium, // 12 / Medium
    labelLarge: AppTextStyles.body3SemiBold, // 14 / SemiBold
    labelMedium: AppTextStyles.caption1SemiBold, // 12 / SemiBold
    labelSmall: AppTextStyles.caption1Medium, // 12 / Medium
  );
}
