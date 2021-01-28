import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/repositories/repositories.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  RestaurantRepository _restaurantRepository;

  DetailBloc() : super(DetailInitial()) {
    _restaurantRepository = RestaurantRepository();
  }

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailRequested) {
      yield* _mapRequestedDetailToState(event.id);
    }
  }

  Stream<DetailState> _mapRequestedDetailToState(String id) async* {
    yield DetailLoadInProgress();
    try {
      final RestaurantDetail restaurantDetail =
          await _restaurantRepository.getRestaurantDetail(id: id);
      yield DetailLoadSuccess(restaurantDetail: restaurantDetail);
    } catch (err) {
      print(err);
      yield DetailLoadFailure(err: err);
    }
  }
}
