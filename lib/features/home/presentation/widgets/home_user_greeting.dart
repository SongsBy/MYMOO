import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 홈 상단 사용자 인사 영역 — 프로필 이미지 + 2줄 인사 문구.
///
/// Figma "Streak and Notification" 상단 행. (node 69379:1252)
class HomeUserGreeting extends StatelessWidget {
  const HomeUserGreeting({
    super.key,
    required this.userName,
    required this.message,
    this.avatarAsset,
  });

  /// 사용자 이름(님 호칭 포함 전 순수 이름). 예: "길동".
  final String userName;

  /// 인사 메시지 둘째 줄. 예: "오늘도 든든하게 드세요!".
  final String message;

  /// 프로필 이미지 asset 경로. null 이면 기본 플레이스홀더 원을 표시한다.
  final String? avatarAsset;

  static const double _avatarSize = 44;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Avatar(asset: avatarAsset, size: _avatarSize),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$userName님,', style: AppTextStyles.heading2Bold),
              Text(message, style: AppTextStyles.heading2Bold),
            ],
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.asset, required this.size});

  final String? asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: asset == null
            ? const ColoredBox(color: AppColors.bgSecondary)
            : Image.asset(asset!, fit: BoxFit.cover),
      ),
    );
  }
}
