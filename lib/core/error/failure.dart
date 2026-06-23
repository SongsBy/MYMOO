import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// 앱 전역 에러 타입.
///
/// repository에서 DioException 등 raw 예외를 이 타입으로 변환해 throw 한다.
/// presentation에서는 AsyncValue.error 로 잡아 .when() 으로 분기한다.
///
/// ⚠️ server 에러의 실제 JSON 포맷(message, code 등)은 백엔드 팀원과 합의 후 맞춘다.
@freezed
sealed class Failure with _$Failure {
  /// 인터넷 연결 없음 / 타임아웃 등 네트워크 자체 문제
  const factory Failure.network() = NetworkFailure;

  /// 서버가 4xx/5xx 응답 (statusCode, message는 백엔드 포맷에 맞춰 채움)
  const factory Failure.server({
    int? statusCode,
    String? message,
  }) = ServerFailure;

  /// 401: 인증 실패. refresh 도 실패한 최종 상태 (→ 로그아웃 유도)
  const factory Failure.unauthorized() = UnauthorizedFailure;

  /// 404: 리소스 없음
  const factory Failure.notFound() = NotFoundFailure;

  /// 요청이 취소됨 (CancelToken). UI에서 보통 무시한다.
  const factory Failure.cancelled() = CancelledFailure;

  /// 그 외 알 수 없는 에러
  const factory Failure.unknown({String? message}) = UnknownFailure;
}

/// 사용자에게 보여줄 한국어 메시지로 변환.
/// (UI에서 Failure를 직접 보여주지 말고 이 확장으로 변환해 쓴다)
extension FailureMessage on Failure {
  String get userMessage => switch (this) {
        NetworkFailure() => '인터넷 연결을 확인해 주세요.',
        ServerFailure(:final message) =>
          message ?? '일시적인 오류가 발생했어요. 잠시 후 다시 시도해 주세요.',
        UnauthorizedFailure() => '로그인이 필요해요.',
        NotFoundFailure() => '요청하신 정보를 찾을 수 없어요.',
        CancelledFailure() => '요청이 취소되었어요.',
        UnknownFailure(:final message) =>
          message ?? '알 수 없는 오류가 발생했어요.',
      };
}
