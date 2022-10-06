// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey);
      },
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_) {
            context
                .read<TodoListBloc>()
                .add(RemoveTodoEvent(todo: todos[index]));
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: ((context) {
                return AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("Do you really want to delete ?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("NO"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text("YES"),
                    ),
                  ],
                );
              }),
            );
          },
          child: TodoItem(
            todo: todos[index],
          ),
        );
      },
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool _error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text("Edit todo"),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("CANCEL"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            _error = textController.text.isEmpty ? true : false;
                            if (!_error) {
                              context.read<TodoListBloc>().add(
                                    EditTodoEvent(
                                      id: widget.todo.id,
                                      todoDesc: textController.text,
                                    ),
                                  );

                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      child: Text("EDIT"),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(
                ToggleTodoEvent(id: widget.todo.id),
              );
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
