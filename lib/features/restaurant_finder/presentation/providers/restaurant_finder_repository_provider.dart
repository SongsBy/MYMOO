import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/restaurant_finder_api.dart';
import '../../data/repositories/restaurant_finder_repository_impl.dart';
import '../../domain/repositories/restaurant_finder_repository.dart';

part 'restaurant_finder_repository_provider.g.dart';

/// RestaurantFinderRepository 주입 provider.
///
/// 레퍼런스: `restaurant_list/presentation/providers/restaurant_repository_provider.dart`
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantFinderRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.
@riverpod
RestaurantFinderRepository restaurantFinderRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  final api = RestaurantFinderApi(dio);
  return RestaurantFinderRepositoryImpl(api);
}
