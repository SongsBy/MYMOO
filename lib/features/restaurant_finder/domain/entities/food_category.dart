import 'package:json_annotation/json_annotation.dart';

/// 밥집 찾기 화면의 카테고리(메뉴 분류).
///
/// 순수 도메인 값이라 domain 레이어에 둔다.
/// (json_annotation 은 순수 Dart 패키지라 domain 에서 import 해도 무방하다.)
///
/// - [all] 은 "필터 없음"을 뜻하는 UI 전용 값이다.
///   API 요청 시에는 [query] 가 null 이므로 category 파라미터를 보내지 않는다.
/// - 나머지 값은 백엔드 카테고리 코드([query])와 1:1 로 매핑한다.
///
/// ⚠️ 실제 카테고리 코드 값(query)·종류는 **백엔드 팀원과 합의 필요**.
enum FoodCategory {
  all('전체', null),
  @JsonValue('baekban')
  baekban('백반', 'baekban'),
  @JsonValue('soup')
  soup('국/찌개', 'soup'),
  @JsonValue('korean')
  korean('한식', 'korean'),
  @JsonValue('bunsik')
  bunsik('분식', 'bunsik');

  const FoodCategory(this.label, this.query);

  /// 칩에 표시할 한글 라벨.
  final String label;

  /// API 쿼리 파라미터로 보낼 코드. [all] 은 null(전체).
  final String? query;
}
