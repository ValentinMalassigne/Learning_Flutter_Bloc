import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';
import '../blocs.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription todoListSubsription;

  final TodoListBloc todoListBloc;
  final int initialActiveTodoCount;
  ActiveTodoCountBloc({
    required this.todoListBloc,
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubsription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      print("todoListState: $todoListState");

      final int currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;

      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentActiveTodoCount));
    });
    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubsription.cancel();
    return super.close();
  }
}
