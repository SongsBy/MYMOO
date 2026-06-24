import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root_tab_index_provider.g.dart';

/// 루트 탭 인덱스 상수.
///
/// [RootBottomNav] 항목 순서 및 RootTabScreen 의 탭 화면 순서와 일치해야 한다.
/// 매직 넘버 대신 이 상수를 사용한다(CLAUDE.md §4).
abstract final class RootTabs {
  const RootTabs._();

  static const int home = 0;

  /// 주변밥집(밥집 찾기) 탭.
  static const int nearby = 1;

  /// 찜 탭.
  static const int favorites = 2;

  /// 내정보 탭.
  static const int myInfo = 3;
}

/// 현재 선택된 루트 탭 인덱스.
///
/// 셸 내부의 휘발성 UI 상태였지만, 홈의 "밥집 찾기" 처럼 셸 바깥(자식 화면)에서도
/// 탭 전환을 트리거해야 하므로 (RootTabScreen 주석대로) @riverpod Notifier 로 승격했다.
@riverpod
class RootTabIndex extends _$RootTabIndex {
  @override
  int build() => RootTabs.home;

  /// 탭 전환. 같은 인덱스면 무시한다.
  void select(int index) {
    if (state != index) state = index;
  }
}
