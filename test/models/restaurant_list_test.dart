import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/core/models/models.dart';

import '../dummy/values.dart';

main() {
  group('RestaurantList', () {
    test('restaurantList is correctly parsed', () {
      Map<String, dynamic> json = jsonDecode(DummyRestaurantJson.list);
      print('restaurantList Raw JSON value 1 : $json');
      RestaurantList restaurantList = RestaurantList.fromJson(json);

      expect(restaurantList, isA<RestaurantList>());
      expect(restaurantList.count, json['count']);
      expect(restaurantList.error, json['error']);
      expect(restaurantList.message, json['message']);
      expect(restaurantList.restaurants, isA<List<Restaurants>>());
      expect(restaurantList.restaurants?.elementAt(0), isA<Restaurants>());
    });

    test('restaurantList parsing empty json', () {
      Map<String, dynamic> json = jsonDecode('{}');
      print('restaurantList Raw JSON value 2 : $json');
      RestaurantList restaurantList = RestaurantList.fromJson(json);

      expect(restaurantList, isA<RestaurantList>());
      expect(restaurantList.count, null);
      expect(restaurantList.error, null);
      expect(restaurantList.message, null);
      expect(restaurantList.restaurants, null);
      expect(restaurantList.restaurants?.elementAt(0), null);
    });

    test('restaurantList parsing null', () {
      expect(
          () => RestaurantList.fromJson(null), throwsA(isInstanceOf<Error>()));
    });
  });
}
