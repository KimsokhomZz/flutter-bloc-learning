import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_bloc/model/todolist_model.dart';

class TodoCubit extends Cubit<List<TodoListModel>> {
  TodoCubit() : super([]);

  void addTodo(TodoListModel todo) {
    emit([...state, todo]);
  }

  void removeTodo(String id) {
    emit(state.where((element) => element.id != id).toList());
  }

  void updateTodo(TodoListModel updatedTodo) {
    emit(
      state
          .map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo)
          .toList(),
    );
  }

  void toggleIsDone(String id) {
    emit(
      state.map((todo) {
        if (todo.id == id) {
          return TodoListModel(
            id: todo.id,
            title: todo.title,
            description: todo.description,
            isDone: !todo.isDone, // Toggle the value
            createdAt: todo.createdAt,
          );
        }
        return todo;
      }).toList(),
    );
  }
}
