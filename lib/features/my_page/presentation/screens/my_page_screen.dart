import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/my_profile_card.dart';
import '../widgets/my_stats_card.dart';
import '../widgets/settings_row.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_toggle.dart';

/// 내정보 탭 화면.
///
/// 프로필 카드 + 통계 + 설정 섹션들(결제/내 활동/알림 설정/고객 지원/기타)을
/// 세로로 스크롤한다. 상단 "내정보" 앱바는 [RootTabScreen] 의 공통 로고 앱바
/// 대신 이 화면이 직접 그린다.
///
/// 표시 데이터·토글은 아직 목업이다. 마이페이지 API 확정 시
/// `@riverpod` provider 로 끌어와 연결한다. (백엔드 팀원과 합의 필요)
class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _MyPageAppBar(),
        Expanded(child: _MyPageBody()),
      ],
    );
  }
}

/// 좌측 정렬 없이 가운데 "내정보" 제목만 있는 단순 앱바(루트 탭이라 뒤로가기 없음).
class _MyPageAppBar extends StatelessWidget {
  const _MyPageAppBar();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgInverse,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Center(
            child: Text(
              '내정보',
              style: AppTextStyles.body1SemiBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MyPageBody extends StatelessWidget {
  const _MyPageBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyProfileCard(
            name: '홍길동',
            email: 'gildong@maimu.kr',
            membership: 'GOLD 멤버',
            onEditTap: () {},
          ),
          const SizedBox(height: 20),
          const MyStatsCard(
            stats: [
              MyStat(
                value: '1,999,000',
                label: '보유 무',
                color: AppColors.accentGreen,
              ),
              MyStat(value: '3', label: '쿠폰', color: AppColors.brandPrimary),
              MyStat(value: '12', label: '찜한 식당', color: AppColors.accentRed),
            ],
          ),
          const SizedBox(height: 20),
          SettingsSection(
            title: '결제',
            rows: [
              SettingsRow(
                icon: Icons.credit_card,
                title: '결제 수단 관리',
                onTap: () {},
              ),
              SettingsRow(
                icon: Icons.sync,
                title: '자동 충전 설정',
                value: '꺼짐',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          SettingsSection(
            title: '내 활동',
            rows: [
              SettingsRow(
                icon: Icons.favorite_border,
                title: '찜한 식당',
                onTap: () {},
              ),
              SettingsRow(
                icon: Icons.receipt_long_outlined,
                title: '사용 내역',
                onTap: () {},
              ),
              SettingsRow(
                icon: Icons.star_border,
                title: '내가 쓴 리뷰',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SettingsSection(
            title: '알림 설정',
            rows: [
              SettingsRow(
                icon: Icons.notifications_none,
                title: '푸시 알림',
                showChevron: false,
                trailing: SettingsToggle(initialValue: true),
              ),
              SettingsRow(
                icon: Icons.card_giftcard,
                title: '혜택 · 이벤트 알림',
                showChevron: false,
                trailing: SettingsToggle(initialValue: true),
              ),
              SettingsRow(
                icon: Icons.campaign_outlined,
                title: '마케팅 정보 수신',
                showChevron: false,
                trailing: SettingsToggle(initialValue: false),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SettingsSection(
            title: '고객 지원',
            rows: [
              SettingsRow(
                icon: Icons.campaign_outlined,
                title: '공지사항',
                onTap: () {},
              ),
              SettingsRow(
                icon: Icons.help_outline,
                title: '자주 묻는 질문',
                onTap: () {},
              ),
              SettingsRow(
                icon: Icons.chat_bubble_outline,
                title: '1:1 문의',
                onTap: () {},
              ),
              SettingsRow(
                icon: Icons.info_outline,
                title: '서비스 안내',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          SettingsSection(
            title: '기타',
            rows: [
              SettingsRow(
                icon: Icons.description_outlined,
                title: '약관 및 정책',
                onTap: () {},
              ),
              const SettingsRow(
                icon: Icons.info_outline,
                title: '앱 버전',
                value: 'v2.4.1 · 최신',
                showChevron: false,
              ),
              SettingsRow(
                icon: Icons.logout,
                title: '로그아웃',
                titleColor: AppColors.accentRed,
                iconColor: AppColors.accentRed,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Text(
                '회원 탈퇴',
                style: AppTextStyles.body3Medium.copyWith(
                  color: AppColors.textDisable,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.textDisable,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
