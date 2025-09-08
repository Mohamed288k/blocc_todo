import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled22/bloc/todo_event.dart';
import 'package:untitled22/bloc/todo_state.dart';
import 'package:untitled22/models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{

  final List<TodoModel> todoList=[];

  TodoBloc() : super(TodoInitial()){
    on<LoadTodos>((event, emit){
      emit(TodoLoading());
      emit(TodoLoaded(List.from(todoList)));
    });

    on<AddTodo>((event, emit){
      todoList.add(event.todoModel);
      emit(TodoLoaded(List.from(todoList)));
    });

    on<ToggleTodo>((event, emit) {
      todoList[event.index].isCompleted = !todoList[event.index].isCompleted;
      emit(TodoLoaded(List.from(todoList)));
    });

    on<DeleteTodo>((event, emit) {
      todoList.removeAt(event.index);
      emit(TodoLoaded(List.from(todoList)));
    });
  }
}