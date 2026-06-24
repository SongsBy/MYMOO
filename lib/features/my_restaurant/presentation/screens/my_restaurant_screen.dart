import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 찜 탭 화면.
class MyRestaurantScreen extends StatelessWidget {
  const MyRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '찜 화면 (준비 중)',
        style: AppTextStyles.body2Medium.copyWith(
          color: AppColors.textTertiary,
        ),
      ),
    );
  }
}
