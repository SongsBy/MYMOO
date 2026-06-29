import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/app_bar/home_app_bar.dart';
import '../../../../common/widgets/bottom_nav/root_bottom_nav.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../my_page/presentation/screens/my_page_screen.dart';
import '../../../order_list/presentation/screens/order_list_screen.dart';
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
    OrderListScreen(),
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
      activeIcon: 'asset/icons/other_component/ic_able_reservation.svg',
      inactiveIcon: 'asset/icons/other_component/ic_disable_reservation.svg',
      label: '내 식사',
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

    // 주변밥집(지도) 탭은 검색 바를, 주문 내역 탭은 "내 식사", 내정보 탭은
    // "내정보" 앱바를 각자 화면 최상단에 붙이므로 공통 로고 앱바를 숨긴다.
    // 그 외 탭은 [HomeAppBar] 노출.
    final showAppBar = currentIndex != RootTabs.nearby &&
        currentIndex != RootTabs.orderHistory &&
        currentIndex != RootTabs.myInfo;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Column(
        children: [
          if (showAppBar) const HomeAppBar(),
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
