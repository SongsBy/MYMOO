import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/restaurant_detail_model.dart';
import 'review_card.dart';

/// "한 줄 리뷰" 섹션 — 제목/개수/전체보기 + 리뷰 사진 + 리뷰 카드 캐러셀.
///
/// Figma 식당 상세(node 69379:1231). 리뷰 사진/카드는 가로 스크롤한다.
class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.reviewCount,
    required this.reviewPhotos,
    required this.reviews,
    this.onSeeAll,
  });

  /// 총 리뷰 수(리스트에서 받은 요약값). 제목 옆 강조 숫자.
  final int reviewCount;

  /// 상단 리뷰 사진 URL.
  final List<String> reviewPhotos;

  /// 리뷰 카드 목록.
  final List<RestaurantReviewModel> reviews;

  /// "전체 보기" 탭 콜백.
  final VoidCallback? onSeeAll;

  // 섹션 좌우 패딩(가로 스크롤 항목이 화면 끝까지 자연스럽게 흐르도록 직접 적용).
  static const double _hPad = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bgInverse,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _hPad),
            child: _Header(reviewCount: reviewCount, onSeeAll: onSeeAll),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (reviewPhotos.isNotEmpty) ...[
            _ReviewPhotos(photos: reviewPhotos),
            const SizedBox(height: AppSpacing.lg),
          ],
          _ReviewCards(reviews: reviews),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.reviewCount, this.onSeeAll});

  final int reviewCount;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('한 줄 리뷰', style: AppTextStyles.body1SemiBold),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '$reviewCount',
              style: AppTextStyles.body1SemiBold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onSeeAll,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                '전체 보기',
                style: AppTextStyles.body3Medium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              SvgPicture.asset(
                'asset/icons/arrow/ic_arrow_right.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.iconSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 상단 리뷰 사진(105×105) 가로 스크롤.
class _ReviewPhotos extends StatelessWidget {
  const _ReviewPhotos({required this.photos});

  final List<String> photos;

  static const double _size = 105;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: ReviewSection._hPad),
        itemCount: photos.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Image.network(
            photos[i],
            width: _size,
            height: _size,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: _size,
              height: _size,
              color: AppColors.bgSecondary,
              child: const Icon(Icons.image, color: AppColors.iconDisable),
            ),
          ),
        ),
      ),
    );
  }
}

/// 리뷰 카드(296폭) 가로 스크롤.
class _ReviewCards extends StatelessWidget {
  const _ReviewCards({required this.reviews});

  final List<RestaurantReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 146,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: ReviewSection._hPad),
        itemCount: reviews.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) => ReviewCard(review: reviews[i]),
      ),
    );
  }
}
