import 'package:flutter/material.dart';

import '../../data/models/restaurant_model.dart';

/// 식당 리스트의 단일 항목 카드.
///
/// 이 feature 에서만 쓰는 위젯이므로 feature 의 presentation/widgets/ 에 둔다.
/// (여러 feature 에서 공유한다면 common/widgets/ 로 승격)
///
/// 색상/텍스트스타일은 AppColors / AppTextStyles 를 사용한다 (하드코딩 금지).
/// 아래는 Theme.of(context) 를 통해 테마를 참조하는 예시.
class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant, this.onTap});

  final RestaurantModel restaurant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                restaurant.thumbnailUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 64,
                  height: 64,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.restaurant),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                restaurant.name,
                style: textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
