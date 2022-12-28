import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen(
      {Key? key, required this.type, required this.index, required this.text})
      : super(key: key);

  final String type;
  final int index;
  final String text;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (type == 'update') {
      controller.text = text;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          type == 'add' ? 'اضافه کردن فعالیت جدید' : 'بروز رسانی فعالیت',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                labelText:
                    type == 'add' ? 'اضافه کردن' : 'بروز رسانی',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                onButtonPressed(controller.text);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                fixedSize: MaterialStateProperty.all(
                  const Size(150.0, 50.0),
                ),
              ),
              child: Text(
                type == 'add' ? 'اضافه کردن' : 'بروز رسانی',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onButtonPressed(String text) {
    if (type == 'add') {
      add(text);
    } else {
      update(text);
    }
  }

  add(String text) async {
    var box = await Hive.openBox('todo');
    Todo todo = Todo(text);
    int result = await box.add(todo);
  }

  update(String text) async {
    var box = await Hive.openBox('todo');
    Todo todo = Todo(text);
    box.putAt(index, todo);
  }
}
