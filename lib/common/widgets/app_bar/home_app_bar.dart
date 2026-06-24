import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 홈 화면 앱바 — 좌측 로고("마이무")만 노출.
///
/// RootTab의 고정 상단 바로 사용한다. 상태바 인셋은 [SafeArea]로 처리하므로
/// `Scaffold.body` 최상단(Column)에 그대로 배치하면 된다.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgInverse,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '마이무',
                  style: AppTextStyles.body1Bold.copyWith(
                    color: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
