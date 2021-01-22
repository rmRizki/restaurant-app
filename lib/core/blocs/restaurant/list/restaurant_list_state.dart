part of 'restaurant_list_bloc.dart';

abstract class RestaurantListState extends Equatable {
  const RestaurantListState();

  @override
  List<Object> get props => [];
}

class RestaurantListInitial extends RestaurantListState {}

class RestaurantListLoadInProgress extends RestaurantListState {}

class RestaurantListLoadSuccess extends RestaurantListState {
  final RestaurantList restaurantList;

  const RestaurantListLoadSuccess({@required this.restaurantList})
      : assert(restaurantList != null);

  @override
  List<Object> get props => [restaurantList];
}

class RestaurantListLoadFailure extends RestaurantListState {
  final dynamic err;

  RestaurantListLoadFailure({@required this.err});

  List<Object> get props => [err];
}
