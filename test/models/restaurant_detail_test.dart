import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/core/models/models.dart';

import '../dummy/values.dart';

main() {
  group('RestaurantDetail', () {
    test('restaurantDetail is correctly parsed', () {
      Map<String, dynamic> json = jsonDecode(DummyRestaurantJson.detail);
      print('restaurantDetail Raw JSON value 1 : $json');
      RestaurantDetail restaurantDetail = RestaurantDetail.fromJson(json);

      expect(restaurantDetail, isA<RestaurantDetail>());
      expect(restaurantDetail.error, json['error']);
      expect(restaurantDetail.message, json['message']);
      expect(restaurantDetail.restaurant, isA<Restaurant>());
      expect(restaurantDetail.restaurant.name, json['restaurant']['name']);
      expect(restaurantDetail.restaurant.city, json['restaurant']['city']);
    });

    test('restaurantDetail parsing empty json', () {
      Map<String, dynamic> json = jsonDecode('{}');
      print('restaurantDetail Raw JSON value 2 : $json');
      RestaurantDetail restaurantDetail = RestaurantDetail.fromJson(json);

      expect(restaurantDetail, isA<RestaurantDetail>());
      expect(restaurantDetail.error, null);
      expect(restaurantDetail.message, null);
      expect(restaurantDetail.restaurant, null);
      expect(restaurantDetail.restaurant?.name, null);
      expect(restaurantDetail.restaurant?.city, null);
    });

    test('restaurantDetail parsing null', () {
      expect(() => RestaurantDetail.fromJson(null),
          throwsA(isInstanceOf<Error>()));
    });
  });
}
