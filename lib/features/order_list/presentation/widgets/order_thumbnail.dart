import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// 주문 내역 카드의 식당 썸네일.
///
/// [imageUrl] 이 있으면 네트워크 이미지를, 없으면(placeholder) 회색 박스 +
/// 식당 아이콘을 그린다. 예약 카드(64 사각·radius16)와 지난 방문 카드
/// (44 원형)에서 함께 쓰므로 widgets/ 에 둔다.
class OrderThumbnail extends StatelessWidget {
  const OrderThumbnail({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.borderRadius,
  });

  final String? imageUrl;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: size,
        height: size,
        child: imageUrl == null
            ? _placeholder()
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                // 로딩 중에는 placeholder, 실패 시에도 placeholder 로 폴백한다.
                loadingBuilder: (context, child, progress) =>
                    progress == null ? child : _placeholder(),
                errorBuilder: (context, _, __) => _placeholder(),
              ),
      ),
    );
  }

  /// 이미지가 없거나 로딩/실패일 때 보여줄 회색 박스 + 식당 아이콘.
  Widget _placeholder() {
    return ColoredBox(
      color: AppColors.bgSecondary,
      child: Icon(
        Icons.restaurant_rounded,
        size: size * 0.45,
        color: AppColors.iconDisable,
      ),
    );
  }
}
