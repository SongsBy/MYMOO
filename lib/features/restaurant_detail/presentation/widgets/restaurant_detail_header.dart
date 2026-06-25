import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/chips/app_tag_chip.dart';
import '../../../../common/widgets/dot_separator.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../restaurant_finder/data/models/restaurant_summary_model.dart';
import '../../data/models/restaurant_detail_model.dart';
import 'detail_photo_carousel.dart';

/// 식당 상세 상단 헤더 — 사진 + 이름/평점/거리 + 주소·영업시간·전화 + 태그.
///
/// 데이터 출처가 두 곳이다(CLAUDE.md §3 의 데이터 흐름):
/// - [summary]: 리스트(밥집 찾기)에서 넘겨받아 **즉시** 그리는 정보(사진/식당명/평점/거리).
/// - [detail] : 상세 API 로 비동기 로드되는 정보(지역/주소/영업시간/전화/태그).
///   아직 로드 전이면 null 이며, 해당 영역은 그리지 않는다.
class RestaurantDetailHeader extends StatelessWidget {
  const RestaurantDetailHeader({
    super.key,
    required this.summary,
    this.detail,
  });

  final RestaurantSummaryModel summary;
  final RestaurantDetailModel? detail;

  @override
  Widget build(BuildContext context) {
    // 상세가 오기 전엔 리스트 썸네일 1장으로 캐러셀을 채운다.
    final photos = detail?.photos ?? [summary.thumbnailUrl];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상단 큰 이미지는 화면 전체 폭을 차지(full-bleed) — 라운드 없이 모서리까지.
        DetailPhotoCarousel(
          photos: photos,
          borderRadius: BorderRadius.zero,
        ),
        // 이미지 아래 정보 블록만 좌우 패딩을 준다.
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NameAndProperty(summary: summary, region: detail?.region),
              if (detail != null) ...[
                const SizedBox(height: AppSpacing.lg),
                _InfoRows(detail: detail!),
                const SizedBox(height: AppSpacing.lg),
                _TagWrap(tags: detail!.tags),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NameAndProperty extends StatelessWidget {
  const _NameAndProperty({required this.summary, this.region});

  final RestaurantSummaryModel summary;
  final String? region;

  @override
  Widget build(BuildContext context) {
    final infoStyle = AppTextStyles.body3Medium.copyWith(
      color: AppColors.textPrimary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(summary.restaurantName, style: AppTextStyles.heading2Bold),
        const SizedBox(height: AppSpacing.xs6),
        Row(
          children: [
            if (region != null) ...[
              Text(region!, style: infoStyle),
              const _DotPadded(),
            ],
            Text('${summary.distanceMeters}m', style: infoStyle),
            const _DotPadded(),
            const _RatingStar(),
            const SizedBox(width: AppSpacing.xxs),
            Text(summary.rating.toStringAsFixed(1), style: infoStyle),
            const SizedBox(width: AppSpacing.xxs),
            Text(
              '(${summary.reviewCount})',
              style: AppTextStyles.body3Medium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRows extends StatelessWidget {
  const _InfoRows({required this.detail});

  final RestaurantDetailModel detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(
          icon: 'asset/icons/other_component/ic_grayPin.svg',
          child: Text(detail.address, style: _bodyStyle),
        ),
        const SizedBox(height: AppSpacing.sm),
        _InfoRow(
          icon: 'asset/icons/other_component/ic_grayClock.svg',
          child: Row(
            children: [
              Text(
                detail.isOpen ? '영업중' : '영업 종료',
                style: AppTextStyles.body3SemiBold.copyWith(
                  color: detail.isOpen
                      ? AppColors.accentGreen
                      : AppColors.textTertiary,
                ),
              ),
              const _DotPadded(),
              Text(detail.businessHours, style: _bodyStyle),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _InfoRow(
          icon: 'asset/icons/other_component/ic_grayPhone.svg',
          child: Text(detail.phone, style: _bodyStyle),
        ),
      ],
    );
  }

  static final TextStyle _bodyStyle = AppTextStyles.body3Regular.copyWith(
    color: AppColors.textSecondary,
  );
}

/// 아이콘(20) + 내용 한 줄.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.child});

  final String icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(icon, width: 20, height: 20),
        const SizedBox(width: AppSpacing.xs6),
        Expanded(child: child),
      ],
    );
  }
}

class _TagWrap extends StatelessWidget {
  const _TagWrap({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs6,
      children: [for (final tag in tags) AppTagChip(label: tag)],
    );
  }
}

/// 좌우 여백 없이 가운데 정렬에 쓰는 점 구분자(앞뒤 4px 간격).
class _DotPadded extends StatelessWidget {
  const _DotPadded();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: DotSeparator(),
    );
  }
}

/// 16px 평점 별 아이콘.
class _RatingStar extends StatelessWidget {
  const _RatingStar();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'asset/icons/other_component/ic_Rating.svg',
      width: 16,
      height: 16,
    );
  }
}
