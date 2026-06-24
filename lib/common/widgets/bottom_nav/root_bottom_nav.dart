import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 바텀네비 탭 1개의 정의(아이콘 쌍 + 라벨).
class RootBottomNavItem {
  const RootBottomNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    this.iconSize = 24,
    this.activeIconSize,
    this.tinted = false,
  });

  /// 선택 상태 아이콘(SVG asset 경로).
  final String activeIcon;

  /// 비선택 상태 아이콘(SVG asset 경로).
  final String inactiveIcon;

  final String label;

  /// 비선택 아이콘 렌더 크기. 24×24 칸 중앙에 그려진다.
  /// viewBox가 다른 아이콘(여백 없는 글리프 등)의 시각 크기를 맞출 때 조정한다.
  final double iconSize;

  /// 선택 아이콘 렌더 크기. 미지정 시 [iconSize]를 따른다.
  /// 선택/비선택 아이콘의 viewBox가 다를 때 따로 맞춘다.
  final double? activeIconSize;

  /// true면 단일 형태(주로 라인) 아이콘을 선택 상태에 따라 색만 바꿔 칠한다
  /// (선택=brand / 비선택=disable). fill/disable 두 에셋을 쓰는 탭은 false.
  final bool tinted;
}

/// RootTab 고정 하단 네비게이션.
///
/// 탭 구성은 [items]로 주입한다(데이터 기반이라 교체가 쉬움).
/// 선택 인덱스([currentIndex])와 [onTap]만 상위(RootTab 셸)가 관리한다.
class RootBottomNav extends StatelessWidget {
  const RootBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<RootBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    // 상단 좌·우 모서리를 16px 라운드 + 위쪽 방향 드롭섀도(0,-4 / blur 10 / 검정 4%).
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavCell(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavCell extends StatelessWidget {
  const _NavCell({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final RootBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = selected ? AppColors.iconBrand : AppColors.iconDisable;
    final iconSize =
        selected ? (item.activeIconSize ?? item.iconSize) : item.iconSize;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: SvgPicture.asset(
                selected ? item.activeIcon : item.inactiveIcon,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                colorFilter: item.tinted
                    ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            // 라벨: 선택=Caption1 SemiBold/brand, 비선택=Caption1 Medium/disable.
            style: (selected
                    ? AppTextStyles.caption1SemiBold
                    : AppTextStyles.caption1Medium)
                .copyWith(
              color: selected ? AppColors.brandPrimary : AppColors.textDisable,
            ),
          ),
        ],
      ),
    );
  }
}
