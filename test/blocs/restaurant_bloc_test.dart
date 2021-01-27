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
            RestaurantLoadFailure(err: DummyRestaurant.err),
          ]));
    });

    tearDown(() => restaurantBloc.close());

    blocTest(
      'test bloc, event and state',
      build: () => restaurantBloc,
      act: (RestaurantBloc bloc) {
        bloc.add(RestaurantListRequested());
        bloc.add(RestaurantListSearched(query: DummyRestaurant.query));
        bloc.add(RestaurantDetailRequested(id: DummyRestaurant.id));
      },
      expect: [
        RestaurantInitial(),
        RestaurantLoadInProgress(),
        RestaurantListLoadSuccess(restaurantList: DummyRestaurant.list),
        RestaurantDetailLoadSuccess(restaurantDetail: DummyRestaurant.detail),
        RestaurantLoadFailure(err: DummyRestaurant.err),
      ],
      verify: (RestaurantBloc bloc) {
        verify(bloc.add(RestaurantListRequested())).called(1);
        verify(bloc.add(RestaurantListSearched(query: DummyRestaurant.query)))
            .called(1);
        verify(bloc.add(RestaurantDetailRequested(id: DummyRestaurant.id)));
        verify(bloc.close()).called(1);
      },
    );
  });
}
