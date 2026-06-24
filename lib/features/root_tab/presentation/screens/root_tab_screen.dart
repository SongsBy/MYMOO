import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/app_bar/home_app_bar.dart';
import '../../../../common/widgets/bottom_nav/root_bottom_nav.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../my_page/presentation/screens/my_page_screen.dart';
import '../../../my_restaurant/presentation/screens/my_restaurant_screen.dart';
import '../../../restaurant_finder/presentation/screens/restaurant_finder_screen.dart';
import '../providers/root_tab_index_provider.dart';

/// 앱의 루트 탭 셸.
///
/// 상단 [HomeAppBar]와 하단 [RootBottomNav]는 고정이고, 가운데 body만
/// 선택된 탭에 따라 [IndexedStack]으로 교체된다(각 탭 상태 보존).
///
/// 선택 인덱스는 [rootTabIndexProvider]가 관리한다. 홈의 "밥집 찾기" 처럼
/// 셸 바깥(자식 화면)에서도 탭을 전환할 수 있도록 Riverpod 으로 끌어올렸다.
class RootTabScreen extends ConsumerWidget {
  const RootTabScreen({super.key});

  // 탭별 화면. 순서는 [_navItems] / [RootTabs] 인덱스와 일치해야 한다.
  static const _tabScreens = <Widget>[
    HomeScreen(),
    RestaurantFinderScreen(),
    MyRestaurantScreen(),
    MyPageScreen(),
  ];

  // TODO(design): 탭 구성/아이콘은 디자인 확정 시 교체.
  static const _navItems = <RootBottomNavItem>[
    RootBottomNavItem(
      activeIcon: 'asset/icons/home/ic_homefill.svg',
      inactiveIcon: 'asset/icons/home/ic_homedisable.svg',
      label: '홈',
    ),
    RootBottomNavItem(
      activeIcon: 'asset/icons/map/ic_homefill.svg',
      inactiveIcon: 'asset/icons/map/ic_homeDisable.svg',
      label: '주변밥집',
    ),
    RootBottomNavItem(
      // 꽉 찬(채워진) 24×24 하트 1개를 상태별 색으로만 칠한다.
      // 비선택=gray(disable), 선택=brand(주황). (라인 하트 아님)
      activeIcon: 'asset/icons/heart/ic_heartfill.svg',
      inactiveIcon: 'asset/icons/heart/ic_heartfill.svg',
      label: '찜',
      tinted: true,
    ),
    RootBottomNavItem(
      activeIcon: 'asset/icons/user/ic_userfill.svg',
      inactiveIcon: 'asset/icons/user/ic_userdisable.svg',
      label: '내정보',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(rootTabIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: IndexedStack(index: currentIndex, children: _tabScreens),
          ),
        ],
      ),
      bottomNavigationBar: RootBottomNav(
        items: _navItems,
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(rootTabIndexProvider.notifier).select(index),
      ),
    );
  }
}
