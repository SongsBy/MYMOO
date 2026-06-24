import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 내정보 탭 화면.
class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '내정보 화면 (준비 중)',
        style: AppTextStyles.body2Medium.copyWith(
          color: AppColors.textTertiary,
        ),
      ),
    );
  }
}
