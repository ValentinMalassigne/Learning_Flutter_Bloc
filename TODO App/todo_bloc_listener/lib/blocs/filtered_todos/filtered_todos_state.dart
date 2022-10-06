part of 'filtered_todos_bloc.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(filteredTodos: []);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [filteredTodos];

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
