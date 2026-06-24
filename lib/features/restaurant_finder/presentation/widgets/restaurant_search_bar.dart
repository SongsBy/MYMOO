import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 밥집 찾기 상단 검색 바.
///
/// Figma "디자인03" 의 InputBox(node 69357:1736).
/// - 배경 bgPrimary(#f7f7f7), radius 16, padding h16/v14.
/// - 좌측 돋보기 아이콘(disable 색) + 플레이스홀더.
///
/// 현재는 탭 진입형(읽기 전용) 검색 바다. [onTap] 으로 검색 화면 진입을 연결한다.
/// TODO(search): 검색 화면/자동완성 기획 확정 시 입력형으로 확장하거나
///   별도 검색 화면으로 라우팅한다.
class RestaurantSearchBar extends StatelessWidget {
  const RestaurantSearchBar({
    super.key,
    this.hintText = '검색어를 입력하세요',
    this.onTap,
    this.backgroundColor = AppColors.bgPrimary,
    this.elevation = 0,
  });

  final String hintText;
  final VoidCallback? onTap;

  /// 배경색. 지도 위에 띄울 때는 [AppColors.bgInverse](흰색)를 쓴다.
  final Color backgroundColor;

  /// 그림자 깊이. 지도 위 플로팅 시 살짝 띄운다(예: 2).
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: AppColors.opacity20,
      borderRadius: BorderRadius.circular(AppRadius.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 14,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'asset/icons/search/ic_searchon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.iconDisable,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: AppSpacing.xs6),
              Expanded(
                child: Text(
                  hintText,
                  style: AppTextStyles.body2Medium.copyWith(
                    color: AppColors.textDisable,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
