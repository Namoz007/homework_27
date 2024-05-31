import 'package:flutter/material.dart';
import 'package:homework/controllers/todos_controller.dart';
import 'package:homework/models/todo.dart';
import 'package:homework/views/widgets/date_picker.dart';
import 'package:homework/views/widgets/edit_todo.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todosController = TodosController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            Todo data = await showDialog(context: context, builder: (ctx){
              return DatePicker();
            });

            if(data != null){
              todosController.addNewTodo(data.title,data.description,data.date,data.isComplete);
              setState(() {});
            }else{
              print(null);
            }
          }, icon: Icon(Icons.add))
        ]
      ),
      body: FutureBuilder(
          future: todosController.getTodos(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("Rejalar mavjud emas"),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("kechirasiz malumot olishda hatolik ketdi"),
              );
            }

            final todos = snapshot.data;

            return ListView.builder(
              itemCount: todos!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green,width: 5),
                        color: Colors.grey.shade300),
                    child: ListTile(
                      subtitle: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${todos[index].description}",style: TextStyle(fontSize: 14),),
                            Text('${todos[index].date.day}/${todos[index].date.month}/${todos[index].date.year}')
                          ],
                        ),
                      ),
                        title: Text("${todos[index].title}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                onTap: () {
                                  todosController.isComplete(todos[index].id.toString(),!todos[index].isComplete);
                                  setState(() {});
                                },
                                child: todos[index].isComplete
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      )),
                            SizedBox(width: 10,),
                            InkWell(onTap: (){
                              todosController.deleteTodo(todos[index].id.toString());
                              setState(() {});
                            }, child: Icon(Icons.delete,color: Colors.red,)),
                            SizedBox(width: 10,),
                            InkWell(onTap: () async {
                              Map<String,dynamic> data = await showDialog(context: context, builder: (ctx){
                                return EditTodo();
                              });
                              if(data != null){
                                todosController.editTodo(todos[index].id.toString(), data['title'], data['description'], data['date']);
                                setState(() {});
                              }
                            },child: Icon(Icons.edit),)
                          ],
                        )),
                  ),
                );
              },
            );
          }),
    );
  }
}
