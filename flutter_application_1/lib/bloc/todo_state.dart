import 'package:untitled22/models/todo_model.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todoList;
  TodoLoaded(this.todoList);
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}
