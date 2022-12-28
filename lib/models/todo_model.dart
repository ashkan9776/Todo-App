import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo {
  Todo(this.text);

  @HiveField(0)
  String? text;
}
