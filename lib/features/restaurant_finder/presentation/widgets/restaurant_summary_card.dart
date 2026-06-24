import 'package:flutter/material.dart';

import '../../../../common/widgets/dot_separator.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/int_format_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/restaurant_summary_model.dart';

/// 밥집 찾기 리스트의 단일 항목 카드.
///
/// Figma "디자인03" 의 리스트 아이템(node 69328:1648).
/// 이 feature 에서만 쓰는 위젯이라 feature 의 presentation/widgets/ 에 둔다.
///
/// 색상/텍스트는 AppColors / AppTextStyles 만 사용한다 (하드코딩 금지).
class RestaurantSummaryCard extends StatelessWidget {
  const RestaurantSummaryCard({
    super.key,
    required this.restaurant,
    this.onTap,
  });

  final RestaurantSummaryModel restaurant;
  final VoidCallback? onTap;

  // 썸네일 한 변 길이(디자인 100) / 라운드(디자인 12.8).
  static const double _thumbSize = 100;
  static const double _thumbRadius = 12.8;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Thumbnail(url: restaurant.thumbnailUrl),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TitleRow(
                    menuName: restaurant.menuName,
                    seatAvailable: restaurant.seatAvailable,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  _SubInfoRow(
                    restaurantName: restaurant.restaurantName,
                    distanceMeters: restaurant.distanceMeters,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _RatingRow(
                    rating: restaurant.rating,
                    reviewCount: restaurant.reviewCount,
                  ),
                  const SizedBox(height: AppSpacing.xs6),
                  Text(
                    '${restaurant.price.withThousandsSeparator}원',
                    style: AppTextStyles.body2Bold.copyWith(
                      color: AppColors.brandPrimary,
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

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(RestaurantSummaryCard._thumbRadius),
      child: Image.network(
        url,
        width: RestaurantSummaryCard._thumbSize,
        height: RestaurantSummaryCard._thumbSize,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: RestaurantSummaryCard._thumbSize,
          height: RestaurantSummaryCard._thumbSize,
          color: AppColors.bgSecondary,
          child: const Icon(Icons.restaurant, color: AppColors.iconDisable),
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({required this.menuName, required this.seatAvailable});

  final String menuName;
  final bool seatAvailable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            menuName,
            style: AppTextStyles.body1SemiBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _SeatBadge(available: seatAvailable),
      ],
    );
  }
}

/// 좌석 여유 뱃지. 디자인: "자리 있음" (accentSky 배경 / accentBlue 텍스트).
class _SeatBadge extends StatelessWidget {
  const _SeatBadge({required this.available});

  final bool available;

  @override
  Widget build(BuildContext context) {
    final bg = available ? AppColors.accentSky : AppColors.bgSecondary;
    final fg = available ? AppColors.accentBlue : AppColors.textTertiary;
    final label = available ? '자리 있음' : '만석';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.xs6),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption1SemiBold.copyWith(color: fg),
      ),
    );
  }
}

class _SubInfoRow extends StatelessWidget {
  const _SubInfoRow({
    required this.restaurantName,
    required this.distanceMeters,
  });

  final String restaurantName;
  final int distanceMeters;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.body3Medium.copyWith(
      color: AppColors.textTertiary,
    );
    return Row(
      children: [
        Flexible(
          child: Text(
            restaurantName,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: DotSeparator(),
        ),
        Text('${distanceMeters}m', style: style),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.rating, required this.reviewCount});

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star_rounded,
          size: 16,
          color: AppColors.brandSecondary,
        ),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.body3Medium,
        ),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          '($reviewCount)',
          style: AppTextStyles.body3Medium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}
