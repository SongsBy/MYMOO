import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';        // 실제 프로젝트의 AppConfig
import 'auth_interceptor.dart';             // 실제 프로젝트의 인증 인터셉터

part 'dio_provider.g.dart';

/// 앱 전역 dio 인스턴스.
///
/// - baseUrl 은 AppConfig 에서만 가져온다 (하드코딩 금지).
/// - 인증 헤더 부착 / 401 refresh 는 AuthInterceptor 에서 처리한다.
/// - 로깅 인터셉터는 dev/staging 에서만 붙이는 것을 권장 (prod 민감정보 로깅 금지).
///
/// 이 provider 가 모든 retrofit API / repository 의 dio 주입원이다.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // 인증 인터셉터 (access token 부착 + 401 자동 refresh)
  dio.interceptors.add(AuthInterceptor(ref));

  // dev/staging 전용 로깅 (prod 에서는 추가하지 않는다)
  if (AppConfig.flavor != 'prod') {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  return dio;
}
