part of 'restaurant_list_bloc.dart';

abstract class RestaurantListEvent extends Equatable {
  const RestaurantListEvent();

  @override
  List<Object> get props => [];
}

class RestaurantListRequested extends RestaurantListEvent {}

class RestaurantListSearched extends RestaurantListEvent {
  final String query;

  RestaurantListSearched({this.query});
}
