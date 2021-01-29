part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteAdded extends FavoriteEvent {
  final Restaurants restaurant;

  FavoriteAdded({@required this.restaurant});
}

class FavoriteRemoved extends FavoriteEvent {
  final Restaurants restaurant;

  FavoriteRemoved({@required this.restaurant});
}

class FavoriteBoxStarted extends FavoriteEvent {}
