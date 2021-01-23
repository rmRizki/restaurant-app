import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/repositories/repositories.dart';

part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  RestaurantRepository _restaurantRepository;

  RestaurantListBloc() : super(RestaurantListInitial()) {
    _restaurantRepository = RestaurantRepository();
  }

  @override
  Stream<RestaurantListState> mapEventToState(
      RestaurantListEvent event) async* {
    if (event is RestaurantListRequested) {
      yield* _mapRestaurantListRequestedToState();
    } else if (event is RestaurantListSearched) {
      yield* _mapRestaurantListSearchedToState(event.query);
    }
  }

  Stream<RestaurantListState> _mapRestaurantListRequestedToState() async* {
    yield RestaurantListLoadInProgress();
    try {
      final RestaurantList restaurantList =
          await _restaurantRepository.getRestaurantList();
      yield RestaurantListLoadSuccess(restaurantList: restaurantList);
    } catch (err) {
      print(err);
      yield RestaurantListLoadFailure(err: err);
    }
  }

  Stream<RestaurantListState> _mapRestaurantListSearchedToState(
      String query) async* {
    yield RestaurantListLoadInProgress();
    try {
      final RestaurantList restaurantList =
          await _restaurantRepository.getRestaurantSearch(query: query);
      yield RestaurantListLoadSuccess(restaurantList: restaurantList);
    } catch (err) {
      print(err);
      yield RestaurantListLoadFailure(err: err);
    }
  }
}
