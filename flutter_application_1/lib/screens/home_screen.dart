import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled22/bloc/todo_bloc.dart';
import 'package:untitled22/bloc/todo_event.dart';
import 'package:untitled22/bloc/todo_state.dart';
import 'package:untitled22/components/dialog_box.dart';
import 'package:untitled22/models/todo_model.dart';

import '../components/todo_tile.dart';


class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});
  final TextEditingController controller=TextEditingController();

  void onCancel(BuildContext context){
    controller.clear();
    Navigator.of(context).pop();
  }

  void onSave(BuildContext context){
    final newTodo = TodoModel(taskName: controller.text, isCompleted: false);
    context.read<TodoBloc>().add(AddTodo(newTodo));
    controller.clear();
    Navigator.of(context).pop();
  }

  void createNewTask(BuildContext context){
    showDialog(context: context, builder: (context){
      return DialogBox(controller: controller, onSave: () => onSave(context), onCancel: () => onCancel(context),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Todo App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: ()=>createNewTask(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        body:  BlocBuilder<TodoBloc,TodoState>(builder: (context,state){
          if(state is TodoLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if (state is TodoLoaded){
            return ListView.builder(
                itemCount: state.todoList.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    taskName: state.todoList[index].taskName,
                    isCompleted: state.todoList[index].isCompleted,
                    onChanged: (value) {
                      context.read<TodoBloc>().add(ToggleTodo(index));
                    },
                    onDelete: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Delete Task'),
                            content: Text('Are you sure you want to delete this task?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<TodoBloc>().add(DeleteTodo(index));
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                });
          }else{
            return Center(child: Text('No Todos!'),);
          }
        })
  );

  }
}
