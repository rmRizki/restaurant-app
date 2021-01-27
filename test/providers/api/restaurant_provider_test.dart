import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/network/network_service.dart';
import 'package:restaurant_app/core/providers/providers.dart';

import '../../dummy/values.dart';

class MockNetworkService extends Mock implements NetworkService {}

main() {
  group('RestaurantApiProvider', () {
    RestaurantProvider restaurantProvider;
    NetworkService networkService;

    setUp(() {
      networkService = MockNetworkService();
      restaurantProvider = RestaurantProvider(networkService);
    });

    test('request list success', () async {
      when(networkService.get(url: 'list')).thenAnswer((_) => Future.value(
          Response(
              statusCode: 200, data: jsonDecode(DummyRestaurant.listJson))));

      expect(
          await restaurantProvider.getRestaurantList(), isA<RestaurantList>());
    });

    test('request list failed', () async {
      when(networkService.get(url: 'list'))
          .thenThrow(HttpException(DummyRestaurant.err));

      expect(restaurantProvider.getRestaurantList(), throwsException);
    });

    test('search list success', () async {
      when(networkService.get(url: 'search?q=${DummyRestaurant.query}'))
          .thenAnswer((_) => Future.value(Response(
              statusCode: 200, data: jsonDecode(DummyRestaurant.listJson))));

      expect(
          await restaurantProvider.getRestaurantSearch(
              query: DummyRestaurant.query),
          isA<RestaurantList>());
    });

    test('search list failed', () {
      when(networkService.get(url: 'search?q=${DummyRestaurant.query}'))
          .thenThrow(HttpException(DummyRestaurant.err));

      expect(
          restaurantProvider.getRestaurantSearch(query: DummyRestaurant.query),
          throwsException);
    });

    test('request detail success', () async {
      when(networkService.get(url: 'detail/${DummyRestaurant.id}')).thenAnswer(
          (_) => Future.value(Response(
              statusCode: 200, data: jsonDecode(DummyRestaurant.detailJson))));

      expect(
          await restaurantProvider.getRestaurantDetail(id: DummyRestaurant.id),
          isA<RestaurantDetail>());
    });

    test('request detail failed', () {
      when(networkService.get(url: 'detail/${DummyRestaurant.id}'))
          .thenThrow(HttpException(DummyRestaurant.err));

      expect(restaurantProvider.getRestaurantDetail(id: DummyRestaurant.id),
          throwsException);
    });
  });
}
