part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final RestaurantList restaurantList;

  const SearchLoadSuccess({@required this.restaurantList})
      : assert(restaurantList != null);

  @override
  List<Object> get props => [restaurantList];
}

class SearchLoadFailure extends SearchState {
  final dynamic err;

  SearchLoadFailure({@required this.err});

  List<Object> get props => [err];
}
