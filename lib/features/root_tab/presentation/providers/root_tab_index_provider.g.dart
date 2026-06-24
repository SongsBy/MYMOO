// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_tab_index_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 현재 선택된 루트 탭 인덱스.
///
/// 셸 내부의 휘발성 UI 상태였지만, 홈의 "밥집 찾기" 처럼 셸 바깥(자식 화면)에서도
/// 탭 전환을 트리거해야 하므로 (RootTabScreen 주석대로) @riverpod Notifier 로 승격했다.

@ProviderFor(RootTabIndex)
const rootTabIndexProvider = RootTabIndexProvider._();

/// 현재 선택된 루트 탭 인덱스.
///
/// 셸 내부의 휘발성 UI 상태였지만, 홈의 "밥집 찾기" 처럼 셸 바깥(자식 화면)에서도
/// 탭 전환을 트리거해야 하므로 (RootTabScreen 주석대로) @riverpod Notifier 로 승격했다.
final class RootTabIndexProvider extends $NotifierProvider<RootTabIndex, int> {
  /// 현재 선택된 루트 탭 인덱스.
  ///
  /// 셸 내부의 휘발성 UI 상태였지만, 홈의 "밥집 찾기" 처럼 셸 바깥(자식 화면)에서도
  /// 탭 전환을 트리거해야 하므로 (RootTabScreen 주석대로) @riverpod Notifier 로 승격했다.
  const RootTabIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rootTabIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rootTabIndexHash();

  @$internal
  @override
  RootTabIndex create() => RootTabIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$rootTabIndexHash() => r'847100215fce04d7e336332e1a1a26c15a7d55d0';

/// 현재 선택된 루트 탭 인덱스.
///
/// 셸 내부의 휘발성 UI 상태였지만, 홈의 "밥집 찾기" 처럼 셸 바깥(자식 화면)에서도
/// 탭 전환을 트리거해야 하므로 (RootTabScreen 주석대로) @riverpod Notifier 로 승격했다.

abstract class _$RootTabIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
