import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String? id = null;
  String title;
  String description;
  DateTime date;
  bool isComplete;

  Todo(
      {this.id,
        required this.title,
      required this.description,
      required this.date,
      required this.isComplete});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }


}
