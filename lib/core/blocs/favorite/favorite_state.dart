part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoadSuccess extends FavoriteState {
  final RestaurantList restaurantList;

  const FavoriteLoadSuccess({@required this.restaurantList})
      : assert(restaurantList != null);

  @override
  List<Object> get props => [restaurantList];
}
