// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 식당 상세 데이터 provider (식당 id 별 family).
///
/// 리스트에서 넘어온 요약 정보로 헤더를 즉시 그리는 동안, 이 provider 가
/// 상세(주소/영업시간/태그/주간 식단/리뷰)를 비동기로 불러온다.
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다. (CLAUDE.md §5)
///
/// 화면을 벗어나면(provider dispose) in-flight 요청을 CancelToken 으로 취소한다.

@ProviderFor(restaurantDetail)
const restaurantDetailProvider = RestaurantDetailFamily._();

/// 식당 상세 데이터 provider (식당 id 별 family).
///
/// 리스트에서 넘어온 요약 정보로 헤더를 즉시 그리는 동안, 이 provider 가
/// 상세(주소/영업시간/태그/주간 식단/리뷰)를 비동기로 불러온다.
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다. (CLAUDE.md §5)
///
/// 화면을 벗어나면(provider dispose) in-flight 요청을 CancelToken 으로 취소한다.

final class RestaurantDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<RestaurantDetailModel>,
          RestaurantDetailModel,
          FutureOr<RestaurantDetailModel>
        >
    with
        $FutureModifier<RestaurantDetailModel>,
        $FutureProvider<RestaurantDetailModel> {
  /// 식당 상세 데이터 provider (식당 id 별 family).
  ///
  /// 리스트에서 넘어온 요약 정보로 헤더를 즉시 그리는 동안, 이 provider 가
  /// 상세(주소/영업시간/태그/주간 식단/리뷰)를 비동기로 불러온다.
  /// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다. (CLAUDE.md §5)
  ///
  /// 화면을 벗어나면(provider dispose) in-flight 요청을 CancelToken 으로 취소한다.
  const RestaurantDetailProvider._({
    required RestaurantDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'restaurantDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$restaurantDetailHash();

  @override
  String toString() {
    return r'restaurantDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RestaurantDetailModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RestaurantDetailModel> create(Ref ref) {
    final argument = this.argument as int;
    return restaurantDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RestaurantDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$restaurantDetailHash() => r'2e3fdb2bbe35647c4a0d38c90a605d2cd39de13b';

/// 식당 상세 데이터 provider (식당 id 별 family).
///
/// 리스트에서 넘어온 요약 정보로 헤더를 즉시 그리는 동안, 이 provider 가
/// 상세(주소/영업시간/태그/주간 식단/리뷰)를 비동기로 불러온다.
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다. (CLAUDE.md §5)
///
/// 화면을 벗어나면(provider dispose) in-flight 요청을 CancelToken 으로 취소한다.

final class RestaurantDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RestaurantDetailModel>, int> {
  const RestaurantDetailFamily._()
    : super(
        retry: null,
        name: r'restaurantDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 식당 상세 데이터 provider (식당 id 별 family).
  ///
  /// 리스트에서 넘어온 요약 정보로 헤더를 즉시 그리는 동안, 이 provider 가
  /// 상세(주소/영업시간/태그/주간 식단/리뷰)를 비동기로 불러온다.
  /// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다. (CLAUDE.md §5)
  ///
  /// 화면을 벗어나면(provider dispose) in-flight 요청을 CancelToken 으로 취소한다.

  RestaurantDetailProvider call(int restaurantId) =>
      RestaurantDetailProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'restaurantDetailProvider';
}
