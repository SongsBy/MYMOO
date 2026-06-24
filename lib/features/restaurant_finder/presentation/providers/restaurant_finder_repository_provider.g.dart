// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_finder_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RestaurantFinderRepository 주입 provider.
///
/// 레퍼런스: `restaurant_list/presentation/providers/restaurant_repository_provider.dart`
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantFinderRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.

@ProviderFor(restaurantFinderRepository)
const restaurantFinderRepositoryProvider =
    RestaurantFinderRepositoryProvider._();

/// RestaurantFinderRepository 주입 provider.
///
/// 레퍼런스: `restaurant_list/presentation/providers/restaurant_repository_provider.dart`
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantFinderRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.

final class RestaurantFinderRepositoryProvider
    extends
        $FunctionalProvider<
          RestaurantFinderRepository,
          RestaurantFinderRepository,
          RestaurantFinderRepository
        >
    with $Provider<RestaurantFinderRepository> {
  /// RestaurantFinderRepository 주입 provider.
  ///
  /// 레퍼런스: `restaurant_list/presentation/providers/restaurant_repository_provider.dart`
  ///
  /// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
  /// - 반환 타입은 추상(RestaurantFinderRepository) 으로 노출한다 (의존성 역전 유지).
  /// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.
  const RestaurantFinderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantFinderRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantFinderRepositoryHash();

  @$internal
  @override
  $ProviderElement<RestaurantFinderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantFinderRepository create(Ref ref) {
    return restaurantFinderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantFinderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantFinderRepository>(value),
    );
  }
}

String _$restaurantFinderRepositoryHash() =>
    r'7140a1c7eff795dc17f754e71fc4c2cb7873fa3b';
