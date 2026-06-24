import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/dot_separator.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/restaurant_detail_model.dart';

/// 한 줄 리뷰 카드 — Figma "container / review" (296×146).
///
/// 프로필 + 이름/시간 + 별점 + 본문. 가로 캐러셀에 들어가므로 폭을 고정한다.
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final RestaurantReviewModel review;

  /// 디자인 카드 폭(296).
  static const double width = 296;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bgInverse,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(url: review.avatarUrl),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        review.userName,
                        style: AppTextStyles.body3Medium,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                        child: DotSeparator(),
                      ),
                      Text(
                        review.relativeTime,
                        style: AppTextStyles.body3Medium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Row(
                    children: [
                      _Stars(rating: review.rating),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: AppTextStyles.body3Medium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // 카드 높이가 고정이라(가로 캐러셀), 남는 높이만큼만 차지하고
          // 넘치면 말줄임 처리해 세로 오버플로우를 막는다.
          Expanded(
            child: Text(
              review.content,
              style: AppTextStyles.body3Medium.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url});

  final String url;

  static const double _size = 40;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: _size,
        height: _size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: _size,
          height: _size,
          color: AppColors.bgSecondary,
          child: const Icon(
            Icons.person,
            size: 24,
            color: AppColors.iconDisable,
          ),
        ),
      ),
    );
  }
}

/// 5칸 별점. 채워진 칸 수 = 반올림한 평점.
class _Stars extends StatelessWidget {
  const _Stars({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final filled = rating.round().clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          SvgPicture.asset(
            'asset/icons/other_component/ic_Rating.svg',
            width: 16,
            height: 16,
            colorFilter: i < filled
                ? null
                : const ColorFilter.mode(
                    AppColors.iconDisable,
                    BlendMode.srcIn,
                  ),
          ),
      ],
    );
  }
}
