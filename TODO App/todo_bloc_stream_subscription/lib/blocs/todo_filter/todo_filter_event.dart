part of 'todo_filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends TodoFilterEvent {
  final Filter newFilter;
  ChangeFilterEvent({
    required this.newFilter,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [newFilter];
}
