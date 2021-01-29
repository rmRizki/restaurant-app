import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurant_app/core/models/models.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState>
    with HydratedMixin {
  FavoriteBloc() : super(FavoriteInitial()) {
    hydrate();
  }

  RestaurantList _restaurantList;

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FavoriteBoxStarted) {
      _restaurantList = RestaurantList(
        count: 0,
        error: false,
        founded: 0,
        message: 'Success',
        restaurants: [],
      );
    } else if (event is FavoriteAdded) {
      _restaurantList
        ..count += 1
        ..founded += 1
        ..restaurants.add(event.restaurant);
    } else if (event is FavoriteRemoved) {
      _restaurantList
        ..count -= 1
        ..founded -= 1
        ..restaurants.removeWhere((item) => item.id == event.restaurant.id);
    }

    yield FavoriteLoadSuccess(restaurantList: _restaurantList);
  }

  @override
  FavoriteState fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      _restaurantList = RestaurantList.fromJson(json);
      return FavoriteLoadSuccess(restaurantList: _restaurantList);
    } else {
      return FavoriteInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(FavoriteState state) {
    if (state is FavoriteLoadSuccess) {
      return state.restaurantList != null
          ? state.restaurantList.toJson()
          : null;
    } else {
      return null;
    }
  }
}
