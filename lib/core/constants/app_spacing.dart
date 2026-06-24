import 'package:flutter/widgets.dart';

/// 앱 전역 간격(여백/거터) 토큰.
///
/// CLAUDE.md §4 규칙: 매직 넘버 대신 이 상수를 사용한다.
/// 위젯에서 `SizedBox(height: 16)` 처럼 숫자를 직접 쓰지 말고
/// `SizedBox(height: AppSpacing.lg)` 형태로 참조한다.
abstract final class AppSpacing {
  const AppSpacing._();

  /// 2 — 아주 촘촘한 라벨/수치 간격.
  static const double xxs = 2;

  /// 4 — 인접 텍스트 줄 간격.
  static const double xs = 4;

  /// 6 — 소형 컴포넌트 내부 간격.
  static const double xs6 = 6;

  /// 8 — 기본 작은 간격.
  static const double sm = 8;

  /// 12 — 카드/리스트 아이템 간격.
  static const double md = 12;

  /// 16 — 섹션 내부 기본 간격.
  static const double lg = 16;

  /// 20 — 화면 좌우 기본 패딩 / 섹션 패딩.
  static const double xl = 20;

  /// 24 — 큰 섹션 간격.
  static const double xxl = 24;
}

/// 앱 전역 모서리 둥글기(radius) 토큰.
abstract final class AppRadius {
  const AppRadius._();

  /// 8 — 소형 요소.
  static const double sm = 8;

  /// 16 — 카드/배너 기본.
  static const double md = 16;

  /// 999 — 완전 둥글게(알약/원형 칩).
  static const double full = 999;
}

/// 가로 화면 기본 좌우 패딩.
const EdgeInsets kScreenHorizontalPadding =
    EdgeInsets.symmetric(horizontal: AppSpacing.xl);
