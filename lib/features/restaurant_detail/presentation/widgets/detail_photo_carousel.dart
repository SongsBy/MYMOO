import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 식당 상세 상단 사진 캐러셀 + "현재/전체" 카운터.
///
/// Figma 식당 상세(node 69379:1156)의 335×188 이미지(radius 16)와
/// 우하단 카운터(opacity 40% 배경, 흰색 텍스트)를 구현한다.
///
/// 첫 진입 시에는 리스트에서 넘겨받은 썸네일 1장만 들어올 수 있고,
/// 상세 로드가 끝나면 전체 사진으로 교체된다.
class DetailPhotoCarousel extends StatefulWidget {
  const DetailPhotoCarousel({
    super.key,
    required this.photos,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppRadius.md)),
  });

  /// 표시할 사진 URL 목록(최소 1장).
  final List<String> photos;

  /// 이미지 모서리 둥글기. full-bleed 로 쓸 땐 [BorderRadius.zero].
  final BorderRadius borderRadius;

  @override
  State<DetailPhotoCarousel> createState() => _DetailPhotoCarouselState();
}

class _DetailPhotoCarouselState extends State<DetailPhotoCarousel> {
  final _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.photos;

    return AspectRatio(
      // 디자인 335:188.
      aspectRatio: 335 / 188,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: PageView.builder(
                controller: _controller,
                itemCount: photos.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (_, i) => Image.network(
                  photos[i],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: AppColors.bgSecondary,
                    child: Center(
                      child: Icon(Icons.restaurant, color: AppColors.iconDisable),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (photos.length > 1)
            Positioned(
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: _Counter(current: _current + 1, total: photos.length),
            ),
        ],
      ),
    );
  }
}

/// "1/4" 형태의 사진 카운터 알약.
class _Counter extends StatelessWidget {
  const _Counter({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.opacity40,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        '$current/$total',
        style: AppTextStyles.caption1SemiBold.copyWith(
          color: AppColors.textInverse,
        ),
      ),
    );
  }
}
