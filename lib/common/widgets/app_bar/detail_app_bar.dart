import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'app_bar_action_item.dart';

/// 상세 페이지 앱바 — 좌측 뒤로가기 + 가운데 제목 + 우측 액션(마켓/알림/내정보).
///
/// 홈 앱바와 동일하게 [SafeArea]로 상태바 인셋을 처리하므로
/// 상세 화면 `Scaffold.body` 최상단(Column)에 배치한다.
class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onMarketTap,
    this.onNotificationTap,
    this.onProfileTap,
    this.hasNotification = false,
    this.showActions = true,
  });

  /// 제목. [showActions] 가 false 면 가운데 정렬, true 면 좌측 정렬.
  final String title;

  /// 뒤로가기 콜백. 미지정 시 [Navigator.maybePop].
  final VoidCallback? onBack;

  final VoidCallback? onMarketTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final bool hasNotification;

  /// 우측 마켓/알림/내정보 액션 노출 여부.
  ///
  /// 식당 상세처럼 로고·우측 액션이 없는 단순 앱바에서는 false 로 두어
  /// 좌측 뒤로가기 + 가운데 제목만 그린다.
  final bool showActions;

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
                GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(
                      child: SvgPicture.asset(
                        'asset/icons/arrow/ic_arrow_left.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    // 액션이 없으면 좌우 24px 여백이 대칭이라 제목이 정중앙에 온다.
                    textAlign: showActions ? TextAlign.start : TextAlign.center,
                    style: AppTextStyles.body1SemiBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (showActions)
                  AppBarActions(
                    onMarketTap: onMarketTap,
                    onNotificationTap: onNotificationTap,
                    onProfileTap: onProfileTap,
                    hasNotification: hasNotification,
                  )
                else
                  // 좌측 뒤로가기(24)와 대칭을 맞춰 제목을 가운데로.
                  const SizedBox(width: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
