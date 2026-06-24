/// int 표시용 포맷 확장.
extension IntFormatX on int {
  /// 천 단위 콤마 문자열. 예: 1234567 → "1,234,567".
  ///
  /// 가격/수치 표시에서 반복되던 포맷 로직을 한곳에 모은다.
  String get withThousandsSeparator {
    final negative = this < 0;
    final body = abs().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < body.length; i++) {
      if (i > 0 && (body.length - i) % 3 == 0) buffer.write(',');
      buffer.write(body[i]);
    }
    return negative ? '-$buffer' : buffer.toString();
  }
}
