import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/restaurant_api.dart';
import '../../data/repositories/restaurant_repository_impl.dart';
import '../../domain/repositories/restaurant_repository.dart';

part 'restaurant_repository_provider.g.dart';

/// RestaurantRepository 주입 provider.
///
/// - dioProvider 에서 dio 를 받아 retrofit API 를 만들고, 구현체로 감싼다.
/// - 반환 타입은 추상(RestaurantRepository) 으로 노출한다 (의존성 역전 유지).
/// - presentation/notifier 는 이 provider 만 watch 하고 구현체를 모른다.
@riverpod
RestaurantRepository restaurantRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  // baseUrl 은 dio 의 BaseOptions(AppConfig.baseUrl) 에서 이미 설정되어 있다고 가정.
  final api = RestaurantApi(dio);
  return RestaurantRepositoryImpl(api);
}
