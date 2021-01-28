part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailRequested extends DetailEvent {
  final String id;

  DetailRequested({@required this.id});
}
