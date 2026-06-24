import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/food_category.dart';

part 'selected_category_provider.g.dart';

/// 현재 선택된 카테고리(필터) 상태.
///
/// 휘발성 UI 상태지만, 리스트 notifier 가 watch 해서 자동으로 재조회해야 하므로
/// (화면 위젯의 setState 가 아니라) Riverpod Notifier 로 둔다.
///
/// 기본값은 [FoodCategory.all] (전체).
@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  FoodCategory build() => FoodCategory.all;

  /// 카테고리 선택. 같은 값이면 무시한다.
  void select(FoodCategory category) {
    if (state == category) return;
    state = category;
  }
}
