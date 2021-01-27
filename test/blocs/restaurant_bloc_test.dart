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

    setUp(() {
      restaurantBloc = MockRestaurantBloc();
      whenListen(
          restaurantBloc,
          Stream.fromIterable([
            RestaurantInitial(),
            RestaurantLoadInProgress(),
            RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
            RestaurantDetailLoadSuccess(
                restaurantDetail: DummyRestaurant.detail),
            RestaurantLoadFailure(err: 'dummyError'),
          ]));
    });

    tearDown(() => restaurantBloc.close());

    blocTest(
      'test bloc, event and state',
      build: () => restaurantBloc,
      act: (RestaurantBloc bloc) {
        bloc.add(RestaurantListRequested());
        bloc.add(RestaurantListSearched(query: 'food'));
        bloc.add(RestaurantDetailRequested(id: 'rqdv5juczeskfw1e867'));
      },
      expect: [
        RestaurantInitial(),
        RestaurantLoadInProgress(),
        RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
        RestaurantDetailLoadSuccess(restaurantDetail: DummyRestaurant.detail),
        RestaurantLoadFailure(err: 'dummyError'),
      ],
      verify: (RestaurantBloc bloc) {
        verify(bloc.add(RestaurantListRequested())).called(1);
        verify(bloc.add(RestaurantListSearched(query: 'food'))).called(1);
        verify(bloc.add(RestaurantDetailRequested(id: 'rqdv5juczeskfw1e867')));
        verify(bloc.close()).called(1);
      },
    );
  });
}
