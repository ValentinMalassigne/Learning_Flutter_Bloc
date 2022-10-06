// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class CalculateFilteredTodosEvent extends FilteredTodosEvent {
  final List<Todo> filteredTodos;
  CalculateFilteredTodosEvent({
    required this.filteredTodos,
  });

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [filteredTodos];
}
