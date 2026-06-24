// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RestaurantDetailRepository 주입 provider.
///
/// 레퍼런스: `restaurant_finder/presentation/providers/restaurant_finder_repository_provider.dart`
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantDetailRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation 은 이 provider 만 watch 하고 구현체를 모른다.

@ProviderFor(restaurantDetailRepository)
const restaurantDetailRepositoryProvider =
    RestaurantDetailRepositoryProvider._();

/// RestaurantDetailRepository 주입 provider.
///
/// 레퍼런스: `restaurant_finder/presentation/providers/restaurant_finder_repository_provider.dart`
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantDetailRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation 은 이 provider 만 watch 하고 구현체를 모른다.

final class RestaurantDetailRepositoryProvider
    extends
        $FunctionalProvider<
          RestaurantDetailRepository,
          RestaurantDetailRepository,
          RestaurantDetailRepository
        >
    with $Provider<RestaurantDetailRepository> {
  /// RestaurantDetailRepository 주입 provider.
  ///
  /// 레퍼런스: `restaurant_finder/presentation/providers/restaurant_finder_repository_provider.dart`
  ///
  /// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
  /// - 반환 타입은 추상(RestaurantDetailRepository) 으로 노출한다 (의존성 역전 유지).
  /// - presentation 은 이 provider 만 watch 하고 구현체를 모른다.
  const RestaurantDetailRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantDetailRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantDetailRepositoryHash();

  @$internal
  @override
  $ProviderElement<RestaurantDetailRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantDetailRepository create(Ref ref) {
    return restaurantDetailRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantDetailRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantDetailRepository>(value),
    );
  }
}

String _$restaurantDetailRepositoryHash() =>
    r'3fdec45757e6061bf40f48f2d45ed1fec16e3915';
