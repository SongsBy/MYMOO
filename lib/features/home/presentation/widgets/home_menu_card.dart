import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 홈 2열 메뉴 카드 — 좌상단 제목/부제 + 하단 일러스트 영역.
///
/// "밥 집 찾기", "QR 결제" 같은 정사각형에 가까운 진입 카드를 공통화한다.
/// 카드별로 다른 그림은 [decoration] 으로 주입한다(카드 안에 클리핑되어 배치).
///
/// Figma node 69379:1280 / 69379:1289.
class HomeMenuCard extends StatelessWidget {
  const HomeMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.decoration,
    this.onTap,
    this.height = 160,
  });

  /// 카드 제목. 예: "밥 집 찾기".
  final String title;

  /// 카드 부제. 예: "근처 밥 집 찾기".
  final String subtitle;

  /// 카드 하단을 채우는 일러스트. 보통 [Positioned] 들을 담은 위젯을 넘긴다.
  final Widget? decoration;

  /// 탭 콜백. null 이면 탭 비활성.
  final VoidCallback? onTap;

  /// 카드 높이.
  final double height;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.md);
    return Material(
      color: AppColors.bgSecondary,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AppColors.borderTertiary),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              if (decoration != null) Positioned.fill(child: decoration!),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: AppTextStyles.body1Bold),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle,
                      style: AppTextStyles.body3Medium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
