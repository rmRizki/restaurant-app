import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';

import '../dummy/values.dart';

class MockDetailBloc extends MockBloc<DetailState>
    implements DetailBloc {}

main() {
  group('DetailBloc', () {
    DetailBloc mainBloc;

    setUp(() {
      mainBloc = MockDetailBloc();
      whenListen(
          mainBloc,
          Stream.fromIterable([
            DetailInitial(),
            DetailLoadInProgress(),
            DetailLoadSuccess(restaurantDetail: DummyRestaurant.detail),
            DetailLoadFailure(err: DummyRestaurant.err),
          ]));
    });

    tearDown(() => mainBloc.close());

    blocTest(
      'test bloc, event and state',
      build: () => mainBloc,
      act: (DetailBloc bloc) => bloc.add(DetailRequested(id: DummyRestaurant.id)),
      expect: [
        DetailInitial(),
        DetailLoadInProgress(),
        DetailLoadSuccess(restaurantDetail: DummyRestaurant.detail),
        DetailLoadFailure(err: DummyRestaurant.err),
      ],
      verify: (DetailBloc bloc) {
        verify(bloc.add(DetailRequested(id: DummyRestaurant.id))).called(1);
        verify(bloc.close()).called(1);
      },
    );
  });
}
