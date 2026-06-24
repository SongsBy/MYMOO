import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../root_tab/presentation/providers/root_tab_index_provider.dart';
import '../widgets/home_balance_card.dart';
import '../widgets/home_find_map_decoration.dart';
import '../widgets/home_menu_card.dart';
import '../widgets/home_promo_banner.dart';
import '../widgets/home_quick_action.dart';
import '../widgets/home_user_greeting.dart';

/// 홈 탭 화면.
///
/// Figma "디자인01" (node 69379:1249) 의 본문 구성.
/// 상단 앱바/하단 바텀네비는 [RootTabScreen] 이 제공하므로 여기서는 콘텐츠만 그린다.
///
/// 현재는 정적 플레이스홀더 데이터로 레이아웃을 구성한다.
/// TODO(backend): 사용자/잔액/프로모션 데이터는 백엔드 스펙 확정 후
/// `@riverpod` provider 로 주입한다. (CLAUDE.md §3, §10)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // 카드 사이 가로 거터(디자인 13px).
  static const double _cardGutter = 13;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // HomeAppBar 와 동일한 배경색(bgInverse)으로 통일.
    return ColoredBox(
      color: AppColors.bgInverse,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 인사 + 잔액 카드 ──
            const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeUserGreeting(
                    userName: '길동',
                    message: '오늘도 든든하게 드세요!',
                    avatarAsset: 'asset/images/home/avatar.png',
                  ),
                  SizedBox(height: AppSpacing.lg),
                  HomeBalanceCard(
                    title: '보유중인 무',
                    balance: 1999000,
                    caption: '이번 달 27무를 사용했어요',
                  ),
                ],
              ),
            ),

            // ── 진입 카드 2열 + 프로모션 배너 ──
            Padding(
              padding: kScreenHorizontalPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: HomeMenuCard(
                          title: '밥 집 찾기',
                          subtitle: '근처 밥 집 찾기',
                          decoration: const HomeFindMapDecoration(),
                          // "밥집 찾기" → 주변밥집 탭으로 전환(바텀네비도 함께 이동).
                          onTap: () => ref
                              .read(rootTabIndexProvider.notifier)
                              .select(RootTabs.nearby),
                        ),
                      ),
                      const SizedBox(width: _cardGutter),
                      Expanded(
                        child: HomeMenuCard(
                          title: 'QR 결제',
                          subtitle: '스캔하고 식사하기',
                          decoration: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              'asset/images/home/qr_code.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  HomePromoBanner(
                    title: '마이무 회원이면 누구나',
                    highlight: '이번 달 첫 결제 시 5무 증정!',
                    current: 1,
                    total: 4,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // ── 퀵 액션 4분할 ──
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: HomeQuickAction(
                      icon: const QuickActionCircleIcon.full(
                        'asset/images/home/quick_heart.svg',
                      ),
                      label: '찜한 식당',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: _cardGutter),
                  Expanded(
                    child: HomeQuickAction(
                      icon: const QuickActionCircleIcon.composed(
                        inner: 'asset/images/home/quick_cutlery.svg',
                        size: 44,
                      ),
                      label: '최근 먹은 곳',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: _cardGutter),
                  Expanded(
                    child: HomeQuickAction(
                      icon: const QuickActionCircleIcon.composed(
                        inner: 'asset/images/home/quick_history.svg',
                        size: 23.5,
                      ),
                      label: '사용 내역',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: _cardGutter),
                  Expanded(
                    child: HomeQuickAction(
                      icon: const QuickActionCircleIcon.full(
                        'asset/images/home/quick_service.svg',
                      ),
                      label: '서비스 안내',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
