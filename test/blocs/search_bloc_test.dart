import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/blocs/blocs.dart';

import '../dummy/values.dart';

class MockSearchBloc extends MockBloc<SearchState> implements SearchBloc {}

main() {
  group('SearchBloc', () {
    SearchBloc searchBloc;

    setUp(() {
      searchBloc = MockSearchBloc();
      whenListen(
          searchBloc,
          Stream.fromIterable([
            SearchInitial(),
            SearchLoadInProgress(),
            SearchLoadSuccess(restaurantList: DummyRestaurant.list),
            SearchLoadFailure(err: DummyRestaurant.err),
          ]));
    });

    tearDown(() => searchBloc.close());

    blocTest(
      'test bloc, event and state',
      build: () => searchBloc,
      act: (SearchBloc bloc) =>
          bloc.add(SearchRequested(query: DummyRestaurant.query)),
      expect: [
        SearchInitial(),
        SearchLoadInProgress(),
        SearchLoadSuccess(restaurantList: DummyRestaurant.list),
        SearchLoadFailure(err: DummyRestaurant.err),
      ],
      verify: (SearchBloc bloc) {
        verify(bloc.add(SearchRequested(query: DummyRestaurant.query)))
            .called(1);
        verify(bloc.close()).called(1);
      },
    );
  });
}
