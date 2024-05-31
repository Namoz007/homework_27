import 'package:flutter/material.dart';
import 'package:homework/models/todo.dart';

class EditTodo extends StatelessWidget {
  EditTodo({super.key});
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime? date = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Rejani tahrirlash!"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            TextFormField(
              controller: title,
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Iltimos reja nomini togri kiriting';
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rejaning yangi nomini kiriting'
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: description,
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Iltimos reja tavsifini togri kiriting';
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rejaning yangi tavsifini kiriting'
              ),
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
              date = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030),);
              print(date);
            }, child: Text("Rejaning yangi tanlash"))
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Bekor qilish")),

        ElevatedButton(onPressed: (){
          if(formKey.currentState!.validate()){
            Map<String,dynamic> mp = {
              'title':title.text,
              'description':description.text,
              'date':date,
              'isComplete':false,
            };
            Navigator.of(context).pop(mp);
          }
        }, child: Text("Saqlash")),

      ],
    );
  }
}
