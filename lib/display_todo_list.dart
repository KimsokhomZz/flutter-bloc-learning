import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_bloc/cubit/todo_cubit.dart';
import 'package:learning_flutter_bloc/model/todolist_model.dart';
import 'package:learning_flutter_bloc/todo_list_add.dart';

class DisplayTodoList extends StatelessWidget {
  const DisplayTodoList({super.key});

  void removeTodo(BuildContext context, String id) {
    BlocProvider.of<TodoCubit>(context).removeTodo(id);
  }

  void updateTodo(BuildContext context, TodoListModel todo) {
    // navigate to edit form
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoListAdd(todo: todo)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: BlocBuilder<TodoCubit, List<TodoListModel>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('No todos yet! Add some.'));
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (value) {
                    BlocProvider.of<TodoCubit>(context).toggleIsDone(todo.id);
                  },
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle:
                    todo.description != null ? Text(todo.description!) : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        updateTodo(context, todo);
                      },
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeTodo(context, todo.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoListAdd()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
