// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RestaurantRepository 주입 provider.
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.

@ProviderFor(restaurantRepository)
const restaurantRepositoryProvider = RestaurantRepositoryProvider._();

/// RestaurantRepository 주입 provider.
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.

final class RestaurantRepositoryProvider
    extends
        $FunctionalProvider<
          RestaurantRepository,
          RestaurantRepository,
          RestaurantRepository
        >
    with $Provider<RestaurantRepository> {
  /// RestaurantRepository 주입 provider.
  ///
  /// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
  /// - 반환 타입은 추상(RestaurantRepository) 으로 노출한다 (의존성 역전 유지).
  /// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.
  const RestaurantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantRepositoryHash();

  @$internal
  @override
  $ProviderElement<RestaurantRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantRepository create(Ref ref) {
    return restaurantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantRepository>(value),
    );
  }
}

String _$restaurantRepositoryHash() =>
    r'9d25e6e887220eefdb42188d552493466b345fc7';
