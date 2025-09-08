import 'package:untitled22/models/todo_model.dart';

abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final TodoModel todoModel;
  AddTodo(this.todoModel);
}

class ToggleTodo extends TodoEvent {
  final int index;
  ToggleTodo(this.index);
}

class DeleteTodo extends TodoEvent {
  final int index;
  DeleteTodo(this.index);
}