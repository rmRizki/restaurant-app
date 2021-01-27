import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';

import '../dummy/values.dart';

class MockRestaurantBloc extends MockBloc<RestaurantState>
    implements RestaurantBloc {}

main() {
  group('RestaurantBloc', () {
    RestaurantBloc restaurantBloc;

    setUp(() => restaurantBloc = MockRestaurantBloc());

    tearDown(() => restaurantBloc.close());

    test('bloc initial state', () async {
      whenListen(restaurantBloc, Stream.value(RestaurantInitial()));
      await expectLater(restaurantBloc, emits(RestaurantInitial()));
      expect(restaurantBloc.state, RestaurantInitial());
    });

    blocTest(
      'bloc request list',
      build: () {
        whenListen(
            restaurantBloc,
            Stream.fromIterable([
              RestaurantInitial(),
              RestaurantLoadInProgress(),
              RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
            ]));
        return restaurantBloc;
      },
      act: (RestaurantBloc bloc) {
        bloc.add(RestaurantListRequested());
      },
      expect: [
        RestaurantInitial(),
        RestaurantLoadInProgress(),
        RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
      ],
      verify: (RestaurantBloc bloc) {
        verify(bloc.add(RestaurantListRequested())).called(1);
        verify(bloc.close()).called(1);
      },
    );

    blocTest(
      'bloc search list',
      build: () {
        whenListen(
            restaurantBloc,
            Stream.fromIterable([
              RestaurantInitial(),
              RestaurantLoadInProgress(),
              RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
            ]));
        return restaurantBloc;
      },
      act: (RestaurantBloc bloc) {
        bloc.add(RestaurantListSearched(query: 'food'));
      },
      expect: [
        RestaurantInitial(),
        RestaurantLoadInProgress(),
        RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
      ],
      verify: (RestaurantBloc bloc) {
        verify(bloc.add(RestaurantListSearched(query: 'food'))).called(1);
        verify(bloc.close()).called(1);
      },
    );

    blocTest(
      'bloc request detail',
      build: () {
        whenListen(
            restaurantBloc,
            Stream.fromIterable([
              RestaurantInitial(),
              RestaurantLoadInProgress(),
              RestaurantDetailLoadSuccess(
                  restaurantDetail: DummyRestaurant.detail),
            ]));
        return restaurantBloc;
      },
      act: (RestaurantBloc bloc) {
        bloc.add(RestaurantDetailRequested(id: 'rqdv5juczeskfw1e867'));
      },
      expect: [
        RestaurantInitial(),
        RestaurantLoadInProgress(),
        RestaurantDetailLoadSuccess(restaurantDetail: DummyRestaurant.detail),
      ],
      verify: (RestaurantBloc bloc) {
        verify(bloc.add(RestaurantDetailRequested(id: 'rqdv5juczeskfw1e867')))
            .called(1);
        verify(bloc.close()).called(1);
      },
    );
  });
}
