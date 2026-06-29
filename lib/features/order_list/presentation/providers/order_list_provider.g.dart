// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 주문 내역 데이터 provider.
///
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다(CLAUDE.md §5).
///
/// ⚠️ 현재는 더미 데이터를 반환하는 **placeholder** 다.
/// TODO(backend): 주문 내역 API 가 확정되면
///   1) `data/datasources/` 에 retrofit API 정의
///   2) `domain/repositories/` 인터페이스 + `data/repositories/` 구현체 추가
///   3) 아래 본문을 `ref.watch(orderListRepositoryProvider).fetch(...)` 로 교체
/// 한다. (페이지 키/응답 포맷은 백엔드 팀원과 합의 필요)

@ProviderFor(orderList)
const orderListProvider = OrderListProvider._();

/// 주문 내역 데이터 provider.
///
/// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다(CLAUDE.md §5).
///
/// ⚠️ 현재는 더미 데이터를 반환하는 **placeholder** 다.
/// TODO(backend): 주문 내역 API 가 확정되면
///   1) `data/datasources/` 에 retrofit API 정의
///   2) `domain/repositories/` 인터페이스 + `data/repositories/` 구현체 추가
///   3) 아래 본문을 `ref.watch(orderListRepositoryProvider).fetch(...)` 로 교체
/// 한다. (페이지 키/응답 포맷은 백엔드 팀원과 합의 필요)

final class OrderListProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrderListData>,
          OrderListData,
          FutureOr<OrderListData>
        >
    with $FutureModifier<OrderListData>, $FutureProvider<OrderListData> {
  /// 주문 내역 데이터 provider.
  ///
  /// 화면은 `AsyncValue.when` 으로 로딩/에러/데이터를 분기한다(CLAUDE.md §5).
  ///
  /// ⚠️ 현재는 더미 데이터를 반환하는 **placeholder** 다.
  /// TODO(backend): 주문 내역 API 가 확정되면
  ///   1) `data/datasources/` 에 retrofit API 정의
  ///   2) `domain/repositories/` 인터페이스 + `data/repositories/` 구현체 추가
  ///   3) 아래 본문을 `ref.watch(orderListRepositoryProvider).fetch(...)` 로 교체
  /// 한다. (페이지 키/응답 포맷은 백엔드 팀원과 합의 필요)
  const OrderListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderListHash();

  @$internal
  @override
  $FutureProviderElement<OrderListData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OrderListData> create(Ref ref) {
    return orderList(ref);
  }
}

String _$orderListHash() => r'3fc379d6c011e226b31e8024b17e4faaf20168dc';
