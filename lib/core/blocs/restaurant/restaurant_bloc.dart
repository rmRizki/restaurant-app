import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/repositories/repositories.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantRepository _restaurantRepository;

  RestaurantBloc() : super(RestaurantInitial()) {
    _restaurantRepository = RestaurantRepository();
  }

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is RestaurantListRequested) {
      yield* _mapRestaurantListRequestedToState();
    } else if (event is RestaurantListSearched) {
      yield* _mapRestaurantListSearchedToState(event.query);
    } else if (event is RestaurantDetailRequested) {
      yield* _mapRestaurantDetailRequestedToState(event.id);
    }
  }

  Stream<RestaurantState> _mapRestaurantListRequestedToState() async* {
    yield RestaurantLoadInProgress();
    try {
      final RestaurantList restaurantList =
          await _restaurantRepository.getRestaurantList();
      yield RestaurantListLoadSuccess(restaurantList: restaurantList);
    } catch (err) {
      print(err);
      yield RestaurantLoadFailure(err: err);
    }
  }

  Stream<RestaurantState> _mapRestaurantListSearchedToState(
      String query) async* {
    yield RestaurantLoadInProgress();
    try {
      final RestaurantList restaurantList =
          await _restaurantRepository.getRestaurantSearch(query: query);
      yield RestaurantListLoadSuccess(restaurantList: restaurantList);
    } catch (err) {
      print(err);
      yield RestaurantLoadFailure(err: err);
    }
  }

  Stream<RestaurantState> _mapRestaurantDetailRequestedToState(
      String id) async* {
    yield RestaurantLoadInProgress();
    try {
      final RestaurantDetail restaurantDetail =
          await _restaurantRepository.getRestaurantDetail(id: id);
      yield RestaurantDetailLoadSuccess(restaurantDetail: restaurantDetail);
    } catch (err) {
      print(err);
      yield RestaurantLoadFailure(err: err);
    }
  }
}
