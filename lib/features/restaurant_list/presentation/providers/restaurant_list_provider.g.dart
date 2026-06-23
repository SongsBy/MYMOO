// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 식당 리스트 페이지네이션 Notifier.
///
/// ★ 이 클래스가 "리스트 + 페이지네이션" 레퍼런스 패턴이다.
///   새 리스트 feature는 이 구조를 그대로 복사해서 모델/엔드포인트만 교체한다.
///
/// 설계 포인트:
/// - state(AsyncValue<List<T>>) 는 "현재까지 쌓인 전체 목록" 만 담는다.
/// - 페이지 커서 / 다음페이지 로딩중 / 끝 도달 같은 메타는 state 가 아니라
///   Notifier 내부 필드로 관리한다 (UI 가 알 필요 없는 내부 상태).
/// - 첫 페이지 로딩/에러 = state 자체(AsyncLoading/AsyncError) 로 표현.
/// - 다음 페이지 로딩/에러 = 별도 getter(isLoadingMore / nextPageError) 로 표현
///   → 다음 페이지 실패가 이미 쌓인 목록을 날려버리지 않게 한다.

@ProviderFor(RestaurantListNotifier)
final restaurantListProvider = RestaurantListNotifierProvider._();

/// 식당 리스트 페이지네이션 Notifier.
///
/// ★ 이 클래스가 "리스트 + 페이지네이션" 레퍼런스 패턴이다.
///   새 리스트 feature는 이 구조를 그대로 복사해서 모델/엔드포인트만 교체한다.
///
/// 설계 포인트:
/// - state(AsyncValue<List<T>>) 는 "현재까지 쌓인 전체 목록" 만 담는다.
/// - 페이지 커서 / 다음페이지 로딩중 / 끝 도달 같은 메타는 state 가 아니라
///   Notifier 내부 필드로 관리한다 (UI 가 알 필요 없는 내부 상태).
/// - 첫 페이지 로딩/에러 = state 자체(AsyncLoading/AsyncError) 로 표현.
/// - 다음 페이지 로딩/에러 = 별도 getter(isLoadingMore / nextPageError) 로 표현
///   → 다음 페이지 실패가 이미 쌓인 목록을 날려버리지 않게 한다.
final class RestaurantListNotifierProvider
    extends
        $AsyncNotifierProvider<RestaurantListNotifier, List<RestaurantModel>> {
  /// 식당 리스트 페이지네이션 Notifier.
  ///
  /// ★ 이 클래스가 "리스트 + 페이지네이션" 레퍼런스 패턴이다.
  ///   새 리스트 feature는 이 구조를 그대로 복사해서 모델/엔드포인트만 교체한다.
  ///
  /// 설계 포인트:
  /// - state(AsyncValue<List<T>>) 는 "현재까지 쌓인 전체 목록" 만 담는다.
  /// - 페이지 커서 / 다음페이지 로딩중 / 끝 도달 같은 메타는 state 가 아니라
  ///   Notifier 내부 필드로 관리한다 (UI 가 알 필요 없는 내부 상태).
  /// - 첫 페이지 로딩/에러 = state 자체(AsyncLoading/AsyncError) 로 표현.
  /// - 다음 페이지 로딩/에러 = 별도 getter(isLoadingMore / nextPageError) 로 표현
  ///   → 다음 페이지 실패가 이미 쌓인 목록을 날려버리지 않게 한다.
  RestaurantListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantListNotifierHash();

  @$internal
  @override
  RestaurantListNotifier create() => RestaurantListNotifier();
}

String _$restaurantListNotifierHash() =>
    r'9815cfcfa56ad10d8e29de4bbae1210f84c19ef3';

/// 식당 리스트 페이지네이션 Notifier.
///
/// ★ 이 클래스가 "리스트 + 페이지네이션" 레퍼런스 패턴이다.
///   새 리스트 feature는 이 구조를 그대로 복사해서 모델/엔드포인트만 교체한다.
///
/// 설계 포인트:
/// - state(AsyncValue<List<T>>) 는 "현재까지 쌓인 전체 목록" 만 담는다.
/// - 페이지 커서 / 다음페이지 로딩중 / 끝 도달 같은 메타는 state 가 아니라
///   Notifier 내부 필드로 관리한다 (UI 가 알 필요 없는 내부 상태).
/// - 첫 페이지 로딩/에러 = state 자체(AsyncLoading/AsyncError) 로 표현.
/// - 다음 페이지 로딩/에러 = 별도 getter(isLoadingMore / nextPageError) 로 표현
///   → 다음 페이지 실패가 이미 쌓인 목록을 날려버리지 않게 한다.

abstract class _$RestaurantListNotifier
    extends $AsyncNotifier<List<RestaurantModel>> {
  FutureOr<List<RestaurantModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<RestaurantModel>>, List<RestaurantModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<RestaurantModel>>,
                List<RestaurantModel>
              >,
              AsyncValue<List<RestaurantModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
