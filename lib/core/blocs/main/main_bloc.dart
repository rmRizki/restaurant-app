import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/repositories/repositories.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> with HydratedMixin {
  RestaurantRepository _restaurantRepository;

  MainBloc() : super(MainInitial()) {
    _restaurantRepository = RestaurantRepository();
    hydrate();
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainRequested) {
      yield* _mapRestaurantListRequestedToState();
    }
  }

  Stream<MainState> _mapRestaurantListRequestedToState() async* {
    yield MainLoadInProgress();
    try {
      final RestaurantList restaurantList =
          await _restaurantRepository.getRestaurantList();
      yield MainLoadSuccess(restaurantList: restaurantList);
    } catch (err) {
      yield MainLoadFailure(err: err);
    }
  }

  @override
  MainState fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      return MainLoadSuccess(restaurantList: RestaurantList.fromJson(json));
    } else {
      return MainInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(MainState state) {
    if (state is MainLoadSuccess) {
      return state.restaurantList != null
          ? state.restaurantList.toJson()
          : null;
    } else {
      return null;
    }
  }
}
