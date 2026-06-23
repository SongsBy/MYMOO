// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전역 dio 인스턴스.
///
/// - baseUrl 은 AppConfig 에서만 가져온다 (하드코딩 금지).
/// - 인증 헤더 부착 / 401 refresh 는 AuthInterceptor 에서 처리한다.
/// - 로깅 인터셉터는 dev/staging 에서만 붙이는 것을 권장 (prod 민감정보 로깅 금지).
///
/// 이 provider 가 모든 retrofit API / repository 의 dio 주입원이다.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// 앱 전역 dio 인스턴스.
///
/// - baseUrl 은 AppConfig 에서만 가져온다 (하드코딩 금지).
/// - 인증 헤더 부착 / 401 refresh 는 AuthInterceptor 에서 처리한다.
/// - 로깅 인터셉터는 dev/staging 에서만 붙이는 것을 권장 (prod 민감정보 로깅 금지).
///
/// 이 provider 가 모든 retrofit API / repository 의 dio 주입원이다.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// 앱 전역 dio 인스턴스.
  ///
  /// - baseUrl 은 AppConfig 에서만 가져온다 (하드코딩 금지).
  /// - 인증 헤더 부착 / 401 refresh 는 AuthInterceptor 에서 처리한다.
  /// - 로깅 인터셉터는 dev/staging 에서만 붙이는 것을 권장 (prod 민감정보 로깅 금지).
  ///
  /// 이 provider 가 모든 retrofit API / repository 의 dio 주입원이다.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'ffc0908b4d7f466bf4456933b5bc0dad62eec270';
