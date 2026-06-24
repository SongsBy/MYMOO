import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/chips/app_category_chip.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/food_category.dart';
import '../providers/selected_category_provider.dart';

/// 카테고리 필터 바 (가로 스크롤 칩 목록).
///
/// Figma "디자인03" 의 Category Section(node 69379:1555).
/// 공용 [AppCategoryChip] 을 재사용하고, 선택 상태는 [selectedCategoryProvider] 로 관리한다.
/// 선택이 바뀌면 [RestaurantFinderList] 가 자동으로 재조회한다(provider watch).
class CategoryFilterBar extends ConsumerWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        children: [
          for (final category in FoodCategory.values) ...[
            AppCategoryChip(
              label: category.label,
              selected: category == selected,
              onSelected: (_) =>
                  ref.read(selectedCategoryProvider.notifier).select(category),
            ),
            if (category != FoodCategory.values.last)
              const SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}
