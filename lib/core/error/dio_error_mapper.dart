import 'package:dio/dio.dart';

import 'failure.dart';

/// DioException 을 도메인 Failure 로 변환하는 공통 매퍼.
///
/// 모든 repository 구현체는 이 함수를 재사용한다.
/// 화면/repository 마다 try-catch 분기를 따로 작성하지 않는다.
///
/// ⚠️ ServerFailure의 message 파싱 부분은 백엔드 에러 응답 포맷 확정 후 맞춘다.
Failure mapDioExceptionToFailure(DioException e) {
  // 요청 취소
  if (e.type == DioExceptionType.cancel) {
    return const Failure.cancelled();
  }

  // 연결/타임아웃 계열 → 네트워크 문제
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const Failure.network();
    case DioExceptionType.badCertificate:
      return const Failure.network();
    case DioExceptionType.cancel:
      return const Failure.cancelled();
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      break; // 아래에서 statusCode로 세분화
  }

  final statusCode = e.response?.statusCode;

  // 백엔드 에러 응답에서 메시지 추출 (포맷 확정 전 임시 처리)
  // 예: { "message": "...", "code": "..." } 형태라고 가정
  String? serverMessage;
  final data = e.response?.data;
  if (data is Map<String, dynamic>) {
    serverMessage = data['message'] as String?;
  }

  if (statusCode == null) {
    return Failure.unknown(message: serverMessage);
  }

  return switch (statusCode) {
    401 => const Failure.unauthorized(),
    403 => const Failure.unauthorized(),
    404 => const Failure.notFound(),
    >= 400 && < 600 => Failure.server(
        statusCode: statusCode,
        message: serverMessage,
      ),
    _ => Failure.unknown(message: serverMessage),
  };
}
