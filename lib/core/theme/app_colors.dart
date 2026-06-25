import 'package:flutter/material.dart';

/// 앱 전역 색상 시스템.
///
/// 디자인 팀이 확정한 색상 토큰 모음이다.
/// CLAUDE.md §4 규칙: 위젯에서 `Color(0xFF...)` 를 직접 쓰지 말고,
/// 반드시 `AppColors.textPrimary` 형태로 이 상수들을 참조한다.
abstract final class AppColors {
  // 인스턴스화 방지.
  const AppColors._();

  // ── Brand ──
  /// 브랜드 기본 색상 (핵심 강조)
  static const Color brandPrimary = Color(0xFFFF7D0C);

  /// 브랜드 보조 색상
  static const Color brandSecondary = Color(0xFFFFA546);

  /// 브랜드 3차 색상
  static const Color brandTertiary = Color(0xFFF9C69A);

  /// 브랜드 배경 색상
  static const Color brandBackground = Color(0xFFFFEED5);

  // ── Text ──
  /// 기본 본문 텍스트
  static const Color textPrimary = Color(0xFF111111);

  /// 보조 텍스트
  static const Color textSecondary = Color(0xFF505050);

  /// 3차 텍스트 (부가 정보)
  static const Color textTertiary = Color(0xFF767676);

  /// 반전 텍스트 (어두운 배경 위)
  static const Color textInverse = Color(0xFFFFFFFF);

  /// 비활성 텍스트
  static const Color textDisable = Color(0xFF999999);

  // ── Icon ──
  /// 브랜드 아이콘
  static const Color iconBrand = Color(0xFFFF7D0C);

  /// 기본 아이콘
  static const Color iconPrimary = Color(0xFF111111);

  /// 보조 아이콘
  static const Color iconSecondary = Color(0xFF767676);

  /// 반전 아이콘 (어두운 배경 위)
  static const Color iconInverse = Color(0xFFFFFFFF);

  /// 비활성 아이콘
  static const Color iconDisable = Color(0xFFAFB2B4);

  // ── Background ──
  /// 기본 배경
  static const Color bgPrimary = Color(0xFFF7F7F7);

  /// 보조 배경
  static const Color bgSecondary = Color(0xFFF3F4F6);

  /// 반전 배경 (카드/시트 등)
  static const Color bgInverse = Color(0xFFFFFFFF);

  /// QR 스캐너 등 카메라 풀스크린 배경 (거의 검정)
  static const Color scanDark = Color(0xFF111111);

  // ── Opacity ──
  /// 검정 12% (그림자)
  static const Color opacity12 = Color(0x1F000000);

  /// 검정 20% (딤/오버레이)
  static const Color opacity20 = Color(0x33000000);

  /// 검정 40% (딤/오버레이)
  static const Color opacity40 = Color(0x66000000);

  /// 검정 60% (딤/오버레이)
  static const Color opacity60 = Color(0x99000000);

  // ── Border ──
  /// 기본 보더
  static const Color borderPrimary = Color(0xFFE5E5EC);

  /// 보조 보더
  static const Color borderSecondary = Color(0xFFF3F4F6);

  /// 3차 보더
  static const Color borderTertiary = Color(0xFFDADAE4);

  // ── Accent ──
  /// 성공/긍정 (초록)
  static const Color accentGreen = Color(0xFF1D9E75);

  /// 경고/오류 (빨강)
  static const Color accentRed = Color(0xFFF63737);

  /// 정보/링크 (파랑)
  static const Color accentBlue = Color(0xFF4E83FF);

  /// 강조 배경 (하늘)
  static const Color accentSky = Color(0xFFECF8FF);
}
