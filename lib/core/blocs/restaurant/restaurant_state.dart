part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoadInProgress extends RestaurantState {}

class RestaurantListLoadSuccess extends RestaurantState {
  final RestaurantList restaurantList;

  const RestaurantListLoadSuccess({@required this.restaurantList})
      : assert(restaurantList != null);

  @override
  List<Object> get props => [restaurantList];
}

class RestaurantDetailLoadSuccess extends RestaurantState {
  final RestaurantDetail restaurantDetail;

  const RestaurantDetailLoadSuccess({@required this.restaurantDetail})
      : assert(restaurantDetail != null);

  @override
  List<Object> get props => [restaurantDetail];
}

class RestaurantLoadFailure extends RestaurantState {
  final dynamic err;

  RestaurantLoadFailure({@required this.err});

  List<Object> get props => [err];
}
