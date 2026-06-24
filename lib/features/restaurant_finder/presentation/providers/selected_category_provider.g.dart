// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 현재 선택된 카테고리(필터) 상태.
///
/// 휘발성 UI 상태지만, 리스트 notifier 가 watch 해서 자동으로 재조회해야 하므로
/// (화면 위젯의 setState 가 아니라) Riverpod Notifier 로 둔다.
///
/// 기본값은 [FoodCategory.all] (전체).

@ProviderFor(SelectedCategory)
const selectedCategoryProvider = SelectedCategoryProvider._();

/// 현재 선택된 카테고리(필터) 상태.
///
/// 휘발성 UI 상태지만, 리스트 notifier 가 watch 해서 자동으로 재조회해야 하므로
/// (화면 위젯의 setState 가 아니라) Riverpod Notifier 로 둔다.
///
/// 기본값은 [FoodCategory.all] (전체).
final class SelectedCategoryProvider
    extends $NotifierProvider<SelectedCategory, FoodCategory> {
  /// 현재 선택된 카테고리(필터) 상태.
  ///
  /// 휘발성 UI 상태지만, 리스트 notifier 가 watch 해서 자동으로 재조회해야 하므로
  /// (화면 위젯의 setState 가 아니라) Riverpod Notifier 로 둔다.
  ///
  /// 기본값은 [FoodCategory.all] (전체).
  const SelectedCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryHash();

  @$internal
  @override
  SelectedCategory create() => SelectedCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodCategory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodCategory>(value),
    );
  }
}

String _$selectedCategoryHash() => r'2b389695d5c343842e6a1ab6a2128114557c70b4';

/// 현재 선택된 카테고리(필터) 상태.
///
/// 휘발성 UI 상태지만, 리스트 notifier 가 watch 해서 자동으로 재조회해야 하므로
/// (화면 위젯의 setState 가 아니라) Riverpod Notifier 로 둔다.
///
/// 기본값은 [FoodCategory.all] (전체).

abstract class _$SelectedCategory extends $Notifier<FoodCategory> {
  FoodCategory build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FoodCategory, FoodCategory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FoodCategory, FoodCategory>,
              FoodCategory,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
