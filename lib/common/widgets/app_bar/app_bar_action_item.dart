import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 앱바 우측 액션 1개 (아이콘 + 라벨, 선택적 배지).
///
/// 홈/상세 앱바가 공유하는 마켓·알림·내정보 액션의 단위 위젯.
/// 아이콘은 [icon]으로 주입한다(아직 전용 SVG가 없어 placeholder를 넘길 수 있음).
class AppBarActionItem extends StatelessWidget {
  const AppBarActionItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.showBadge = false,
  });

  /// 28×28 영역에 그릴 아이콘 위젯.
  final Widget icon;

  /// 아이콘 아래 라벨.
  final String label;

  /// 탭 콜백.
  final VoidCallback? onTap;

  /// 우상단 알림 배지 표시 여부.
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(width: 28, height: 28, child: Center(child: icon)),
              if (showBadge)
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.accentRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption2SemiBold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// 마켓 · 알림 · 내정보 — 홈/상세 앱바가 공유하는 우측 액션 묶음.
///
/// 아직 전용 아이콘이 없어 placeholder 박스를 사용한다.
/// 디자인 확정 후 [AppBarActionItem.icon]에 실제 SVG를 끼우면 된다.
class AppBarActions extends StatelessWidget {
  const AppBarActions({
    super.key,
    this.onMarketTap,
    this.onNotificationTap,
    this.onProfileTap,
    this.hasNotification = false,
  });

  final VoidCallback? onMarketTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  /// 알림 배지 표시 여부.
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBarActionItem(
          icon: const _ActionIconPlaceholder(),
          label: '마켓',
          onTap: onMarketTap,
        ),
        const SizedBox(width: 16),
        AppBarActionItem(
          icon: const _ActionIconPlaceholder(),
          label: '알림',
          onTap: onNotificationTap,
          showBadge: hasNotification,
        ),
        const SizedBox(width: 16),
        AppBarActionItem(
          icon: const _ActionIconPlaceholder(),
          label: '내정보',
          onTap: onProfileTap,
        ),
      ],
    );
  }
}

/// 전용 아이콘 확정 전까지 쓰는 28×28 자리표시 박스. (TODO: 실제 SVG로 교체)
class _ActionIconPlaceholder extends StatelessWidget {
  const _ActionIconPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
