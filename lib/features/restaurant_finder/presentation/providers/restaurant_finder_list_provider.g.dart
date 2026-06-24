// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_finder_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 밥집 찾기 리스트 페이지네이션 Notifier.
///
/// ★ 페이지네이션 패턴은 `restaurant_list/.../restaurant_list_provider.dart` 를 그대로 따른다.
///   (첫 페이지 = state / 다음 페이지 = 내부 필드 + getter)
///
/// 추가점: [SelectedCategory] 를 watch 해서 카테고리가 바뀌면 build 가 다시 돌아
/// 첫 페이지부터 새 필터로 재조회된다.

@ProviderFor(RestaurantFinderList)
const restaurantFinderListProvider = RestaurantFinderListProvider._();

/// 밥집 찾기 리스트 페이지네이션 Notifier.
///
/// ★ 페이지네이션 패턴은 `restaurant_list/.../restaurant_list_provider.dart` 를 그대로 따른다.
///   (첫 페이지 = state / 다음 페이지 = 내부 필드 + getter)
///
/// 추가점: [SelectedCategory] 를 watch 해서 카테고리가 바뀌면 build 가 다시 돌아
/// 첫 페이지부터 새 필터로 재조회된다.
final class RestaurantFinderListProvider
    extends
        $AsyncNotifierProvider<
          RestaurantFinderList,
          List<RestaurantSummaryModel>
        > {
  /// 밥집 찾기 리스트 페이지네이션 Notifier.
  ///
  /// ★ 페이지네이션 패턴은 `restaurant_list/.../restaurant_list_provider.dart` 를 그대로 따른다.
  ///   (첫 페이지 = state / 다음 페이지 = 내부 필드 + getter)
  ///
  /// 추가점: [SelectedCategory] 를 watch 해서 카테고리가 바뀌면 build 가 다시 돌아
  /// 첫 페이지부터 새 필터로 재조회된다.
  const RestaurantFinderListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantFinderListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantFinderListHash();

  @$internal
  @override
  RestaurantFinderList create() => RestaurantFinderList();
}

String _$restaurantFinderListHash() =>
    r'1070109616007743764b0346f44def221e06200b';

/// 밥집 찾기 리스트 페이지네이션 Notifier.
///
/// ★ 페이지네이션 패턴은 `restaurant_list/.../restaurant_list_provider.dart` 를 그대로 따른다.
///   (첫 페이지 = state / 다음 페이지 = 내부 필드 + getter)
///
/// 추가점: [SelectedCategory] 를 watch 해서 카테고리가 바뀌면 build 가 다시 돌아
/// 첫 페이지부터 새 필터로 재조회된다.

abstract class _$RestaurantFinderList
    extends $AsyncNotifier<List<RestaurantSummaryModel>> {
  FutureOr<List<RestaurantSummaryModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<RestaurantSummaryModel>>,
              List<RestaurantSummaryModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<RestaurantSummaryModel>>,
                List<RestaurantSummaryModel>
              >,
              AsyncValue<List<RestaurantSummaryModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
