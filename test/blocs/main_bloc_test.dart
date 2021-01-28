import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';

import '../dummy/values.dart';

class MockMainBloc extends MockBloc<MainState>
    implements MainBloc {}

main() {
  group('MainBloc', () {
    MainBloc mainBloc;

    setUp(() {
      mainBloc = MockMainBloc();
      whenListen(
          mainBloc,
          Stream.fromIterable([
            MainInitial(),
            MainLoadInProgress(),
            MainLoadSuccess(restaurantList: DummyRestaurant.list),
            MainLoadFailure(err: DummyRestaurant.err),
          ]));
    });

    tearDown(() => mainBloc.close());

    blocTest(
      'test bloc, event and state',
      build: () => mainBloc,
      act: (MainBloc bloc) => bloc.add(MainRequested()),
      expect: [
        MainInitial(),
        MainLoadInProgress(),
        MainLoadSuccess(restaurantList: DummyRestaurant.list),
        MainLoadFailure(err: DummyRestaurant.err),
      ],
      verify: (MainBloc bloc) {
        verify(bloc.add(MainRequested())).called(1);
        verify(bloc.close()).called(1);
      },
    );
  });
}
