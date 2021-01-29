import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';

import '../dummy/values.dart';

class MockFavoriteBloc extends MockBloc<FavoriteState> implements FavoriteBloc {
}

main() {
  group('FavoriteBloc', () {
    FavoriteBloc favoriteBloc;

    setUp(() {
      favoriteBloc = MockFavoriteBloc();
      whenListen(
          favoriteBloc,
          Stream.fromIterable([
            FavoriteInitial(),
            FavoriteLoadInProgress(),
            FavoriteLoadSuccess(restaurantList: DummyRestaurant.list),
          ]));
    });

    tearDown(() => favoriteBloc.close());

    blocTest(
      'test bloc, event and state',
      build: () => favoriteBloc,
      act: (FavoriteBloc bloc) => bloc
        ..add(FavoriteBoxStarted())
        ..add(FavoriteAdded(restaurant: DummyRestaurant.restaurants))
        ..add(FavoriteRemoved(id: DummyRestaurant.id)),
      expect: [
        FavoriteInitial(),
        FavoriteLoadInProgress(),
        FavoriteLoadSuccess(restaurantList: DummyRestaurant.list),
      ],
      verify: (FavoriteBloc bloc) {
        verify(bloc.add(FavoriteBoxStarted())).called(1);
        verify(bloc.add(FavoriteAdded(restaurant: DummyRestaurant.restaurants)))
            .called(1);
        verify(bloc.add(FavoriteRemoved(id: DummyRestaurant.id))).called(1);
        verify(bloc.close()).called(1);
      },
    );
  });
}
