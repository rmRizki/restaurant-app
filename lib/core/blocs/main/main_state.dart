part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoadInProgress extends MainState {}

class MainLoadSuccess extends MainState {
  final RestaurantList restaurantList;

  const MainLoadSuccess({@required this.restaurantList})
      : assert(restaurantList != null);

  @override
  List<Object> get props => [restaurantList];
}

class MainLoadFailure extends MainState {
  final dynamic err;

  MainLoadFailure({@required this.err});

  List<Object> get props => [err];
}
