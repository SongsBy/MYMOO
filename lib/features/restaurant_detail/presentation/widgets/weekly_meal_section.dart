import 'package:flutter/material.dart';

import '../../../../common/widgets/dot_separator.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/int_format_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/restaurant_detail_model.dart';

/// "이번 주 식단" 섹션 — 요일 선택 + 선택한 날의 대표 메뉴 카드.
///
/// Figma 식당 상세(node 69379:1193)의 요일 셀 5개 + 메뉴 카드.
/// 선택된 요일은 순수 UI 상태이므로 [StatefulWidget] 로컬 상태로 관리한다
/// (공유/비즈니스 상태가 아니므로 Riverpod 대상 아님).
class WeeklyMealSection extends StatefulWidget {
  const WeeklyMealSection({super.key, required this.menus});

  /// 요일별 식단(5일).
  final List<WeeklyMenuModel> menus;

  @override
  State<WeeklyMealSection> createState() => _WeeklyMealSectionState();
}

class _WeeklyMealSectionState extends State<WeeklyMealSection> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    // 기본 선택 = 오늘(isToday). 없으면 첫째 날.
    final todayIndex = widget.menus.indexWhere((m) => m.isToday);
    _selected = todayIndex >= 0 ? todayIndex : 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.menus.isEmpty) return const SizedBox.shrink();
    final menu = widget.menus[_selected];

    return Container(
      width: double.infinity,
      color: AppColors.bgInverse,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이번 주 식단', style: AppTextStyles.body1SemiBold),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (var i = 0; i < widget.menus.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _DayCell(
                    menu: widget.menus[i],
                    selected: i == _selected,
                    onTap: () => setState(() => _selected = i),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _MealCard(menu: menu),
        ],
      ),
    );
  }
}

/// 요일 셀 (날짜 + 요일). 선택 시 brandBackground + 상단 점.
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.menu,
    required this.selected,
    required this.onTap,
  });

  final WeeklyMenuModel menu;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateStyle = selected
        ? AppTextStyles.body1SemiBold.copyWith(color: AppColors.brandPrimary)
        : AppTextStyles.body1Medium;
    final weekdayStyle = selected
        ? AppTextStyles.body3Medium.copyWith(color: AppColors.brandPrimary)
        : AppTextStyles.body3Medium.copyWith(color: AppColors.textTertiary);

    return Material(
      color: selected ? AppColors.brandBackground : AppColors.bgPrimary,
      borderRadius: BorderRadius.circular(AppRadius.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs6,
            vertical: AppSpacing.md,
          ),
          child: Column(
            children: [
              // 선택 시 날짜 위에 6px 브랜드 점.
              SizedBox(
                height: AppSpacing.sm,
                child: selected
                    ? const Center(
                        child: DotSeparator(size: 6, color: AppColors.brandPrimary),
                      )
                    : null,
              ),
              Text('${menu.date}', style: dateStyle),
              Text(menu.weekday, style: weekdayStyle),
            ],
          ),
        ),
      ),
    );
  }
}

/// 선택한 요일의 대표 메뉴 카드 (썸네일 + 메뉴명/구성 + 가격).
class _MealCard extends StatelessWidget {
  const _MealCard({required this.menu});

  final WeeklyMenuModel menu;

  static const double _thumbSize = 100;
  static const double _thumbRadius = 12.8;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _Thumbnail(url: menu.thumbnailUrl),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(menu.menuName, style: AppTextStyles.body2SemiBold),
              const SizedBox(height: AppSpacing.xs),
              _SideDishes(items: menu.sideDishes),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${menu.price.withThousandsSeparator}원',
                style: AppTextStyles.body2Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(_MealCard._thumbRadius),
          child: Image.network(
            url,
            width: _MealCard._thumbSize,
            height: _MealCard._thumbSize,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: _MealCard._thumbSize,
              height: _MealCard._thumbSize,
              color: AppColors.bgSecondary,
              child: const Icon(Icons.restaurant, color: AppColors.iconDisable),
            ),
          ),
        ),
        Positioned(
          left: AppSpacing.sm,
          top: AppSpacing.sm,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: AppColors.opacity60,
              borderRadius: BorderRadius.circular(AppRadius.sm - 2),
            ),
            child: Text(
              '대표메뉴',
              style: AppTextStyles.caption1SemiBold.copyWith(
                color: AppColors.textInverse,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 반찬 구성 — 점(•)으로 구분해 줄바꿈되는 목록.
class _SideDishes extends StatelessWidget {
  const _SideDishes({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.body3Medium.copyWith(
      color: AppColors.textTertiary,
    );
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const DotSeparator(),
          Text(items[i], style: style),
        ],
      ],
    );
  }
}
