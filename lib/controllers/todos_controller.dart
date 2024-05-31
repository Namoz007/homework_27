import 'dart:convert';

import 'package:homework/models/todo.dart';
import 'package:homework/services/todo_http_services.dart';
import 'package:http/http.dart' as http;

class TodosController{
  final todosHttpServices = TodoHttpServices();
  List<Todo> todos = [];

  Future<List<Todo>> getTodos() async{
    if(todos.length == 0){
      todos = await todosHttpServices.getTodos();
    }else{
      final data = await todosHttpServices.getTodos();
      for(int i = 0; i < todos.length;i++){
        bool isHave = false;
        int numb = 0;
        for(int j = 0; j < data.length;j++){
          if(todos[i].id == data[j].id){
            isHave = true;
            numb = j;
            break;
          }
        }
        if(!isHave){
          todos.add(data[numb]);
        }
      }
    }
      return todos;
  }

  // Future<void> deleteTodo(int id) async{
  //   todosHttpServices.deleteTodo(id);
  // }

  Future<void> addNewTodo(String title, String description, DateTime date,bool isComplete) async{
    todos.add(await todosHttpServices.newTodo(title, description, date, isComplete));
  }

  Future<void> editTodo(String id,String title,String description,DateTime date) async{
    for(int i = 0;i < todos.length;i++){
      if(todos[i].id == id){
        print('ozgartirilyapti');
        todos[i].title = title;
        todos[i].description = description;
        todos[i].date = date;
        print('${todos[i].title} ${todos[i].description} ${todos[i].date} ${todos[i].id} ${todos[i].isComplete}');
      }
      await todosHttpServices.editTodo(id, title, description, date);
    }
  }

  Future<void> isComplete(String id,bool isComplete) async{
    for(int i = 0; i < todos.length;i++){
      if(todos[i].id == id){
        todos[i].isComplete = isComplete;
      }
    }
    todosHttpServices.isComplete(id, isComplete);
  }

  Future<void> deleteTodo(String id) async{
    todosHttpServices.deleteTodo(id);
    for(int i = 0;i < todos.length;i++){
      if(todos[i].id == id){
        todos.removeAt(i);
      }
    }
  }
}