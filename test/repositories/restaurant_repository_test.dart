import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/repositories/repositories.dart';

import '../dummy/values.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

main() {
  group('RestaurantRepository', () {
    RestaurantRepository restaurantRepository;

    setUp(() {
      restaurantRepository = MockRestaurantRepository();

      when(restaurantRepository.getRestaurantList())
          .thenAnswer((_) => Future.value(DummyRestaurant.list));

      when(restaurantRepository.getRestaurantSearch(
              query: DummyRestaurant.query))
          .thenAnswer((_) => Future.value(DummyRestaurant.list));

      when(restaurantRepository.getRestaurantDetail(id: DummyRestaurant.id))
          .thenAnswer((_) => Future.value(DummyRestaurant.detail));
    });

    test('get restaurant list', () async {
      RestaurantList restaurantList =
          await restaurantRepository.getRestaurantList();
      expect(restaurantList, DummyRestaurant.list);
      expect(restaurantList, isA<RestaurantList>());
      expect(restaurantList.message, DummyRestaurant.list.message);
      expect(restaurantList.error, DummyRestaurant.list.error);
      expect(restaurantList.restaurants, isA<List<Restaurants>>());
    });

    test('search restaurant list', () async {
      RestaurantList restaurantList = await restaurantRepository
          .getRestaurantSearch(query: DummyRestaurant.query);
      expect(restaurantList, DummyRestaurant.list);
      expect(restaurantList, isA<RestaurantList>());
      expect(restaurantList.message, DummyRestaurant.list.message);
      expect(restaurantList.error, DummyRestaurant.list.error);
      expect(restaurantList.restaurants, isA<List<Restaurants>>());
    });

    test('get restaurant detail', () async {
      RestaurantDetail restaurantDetail = await restaurantRepository
          .getRestaurantDetail(id: DummyRestaurant.id);
      expect(restaurantDetail, DummyRestaurant.detail);
      expect(restaurantDetail, isA<RestaurantDetail>());
      expect(restaurantDetail.message, DummyRestaurant.detail.message);
      expect(restaurantDetail.error, DummyRestaurant.detail.error);
      expect(restaurantDetail.restaurant, isA<Restaurant>());
    });
  });
}
