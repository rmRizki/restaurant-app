part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class RestaurantListRequested extends RestaurantEvent {}

class RestaurantListSearched extends RestaurantEvent {
  final String query;

  RestaurantListSearched({this.query});
}

class RestaurantDetailRequested extends RestaurantEvent {
  final String id;

  RestaurantDetailRequested({this.id});
}
