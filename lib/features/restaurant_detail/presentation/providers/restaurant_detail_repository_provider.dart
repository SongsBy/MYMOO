import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/restaurant_detail_api.dart';
import '../../data/repositories/restaurant_detail_repository_impl.dart';
import '../../domain/repositories/restaurant_detail_repository.dart';

part 'restaurant_detail_repository_provider.g.dart';

/// RestaurantDetailRepository 주입 provider.
///
/// 레퍼런스: `restaurant_finder/presentation/providers/restaurant_finder_repository_provider.dart`
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantDetailRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation 은 이 provider 만 watch 하고 구현체를 모른다.
@riverpod
RestaurantDetailRepository restaurantDetailRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  final api = RestaurantDetailApi(dio);
  return RestaurantDetailRepositoryImpl(api);
}
