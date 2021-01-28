part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRequested extends SearchEvent {
  final String query;

  SearchRequested({@required this.query});
}
