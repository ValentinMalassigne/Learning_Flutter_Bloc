// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class SetSearchTermEvent extends TodoSearchEvent {
  final String newSearchTerm;
  SetSearchTermEvent({
    required this.newSearchTerm,
  });

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [newSearchTerm];
}
