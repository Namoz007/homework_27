import 'dart:convert';
import 'package:homework/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoHttpServices{
  Future<List<Todo>> getTodos() async{
    List<Todo> todos = [];

    Uri url = Uri.parse('https://lesson46-9d83b-default-rtdb.firebaseio.com/todos.json');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    print(data);

    if(data != null){
      data.forEach((key,value){
        Todo todo = Todo.fromJson(value);
        todo.id = key;
        todos.add(todo);
      });
    }

    return todos;
  }

  Future<Todo> newTodo(String title,String description,DateTime date, bool isComplete) async{
    final Uri urll = Uri.parse('https://lesson46-9d83b-default-rtdb.firebaseio.com/todos.json');
    Todo todo = Todo(title: title, description: description, date: date, isComplete: isComplete);
    final response = await http.post(
      urll,
      body: jsonEncode(todo),
    );

    return Todo(id: jsonDecode(response.body)['name'] ,title: title, description: description, date: date, isComplete: isComplete);
  }

  Future<void> editTodo(String id,String title,String description,DateTime date) async {
    var url = Uri.parse(
        'https://lesson46-9d83b-default-rtdb.firebaseio.com/todos/$id.json');

    final data = {
      'title': title,
      'description': description,
      'date': date.toString()
    };

    var response = await http.patch(
      url,
      body: jsonEncode(data),
    );
  }

  Future<void> isComplete(String id,bool isComplete) async {
    var url = Uri.parse(
        'https://lesson46-9d83b-default-rtdb.firebaseio.com/todos/$id.json');

    final data = {
      'isComplete':isComplete
    };

    var response = await http.patch(
      url,
      body: jsonEncode(data),
    );
  }

  Future<void> deleteTodo(String id) async{
    var url = Uri.parse(
        'https://lesson46-9d83b-default-rtdb.firebaseio.com/todos/$id.json');

    final response = await http.delete(url);
  }
}