import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/repositories/repositories.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  RestaurantRepository _restaurantRepository;

  SearchBloc() : super(SearchInitial()) {
    _restaurantRepository = RestaurantRepository();
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchRequested) {
      yield* _mapRequestedSearchToState(event.query);
    }
  }

  Stream<SearchState> _mapRequestedSearchToState(
      String query) async* {
    yield SearchLoadInProgress();
    try {
      final RestaurantList restaurantList =
          await _restaurantRepository.getRestaurantSearch(query: query);
      yield SearchLoadSuccess(restaurantList: restaurantList);
    } catch (err) {
      print(err);
      yield SearchLoadFailure(err: err);
    }
  }
}
