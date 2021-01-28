part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoadInProgress extends DetailState {}

class DetailLoadSuccess extends DetailState {
  final RestaurantDetail restaurantDetail;

  const DetailLoadSuccess({@required this.restaurantDetail})
      : assert(restaurantDetail != null);

  @override
  List<Object> get props => [restaurantDetail];
}

class DetailLoadFailure extends DetailState {
  final dynamic err;

  DetailLoadFailure({@required this.err});

  List<Object> get props => [err];
}
