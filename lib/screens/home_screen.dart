import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/models/todo_model.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'وقت بخیر اشکان',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          MyNavigator(context, 'add', -1, '');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(35.0),
              child: Text(
                'کارهای پیش رو',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            FutureBuilder(
              future: Hive.openBox('todo'),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ToDoList();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget ToDoList() {
    Box todoBox = Hive.box('todo');
    return ValueListenableBuilder(
      valueListenable: todoBox.listenable(),
      builder: (context, Box box, child) {
        if (box.values.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Text(
                'هیچ لیستی وجود ندارد',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: todoBox.length,
              itemBuilder: (context, index) {
                final Todo todo = box.getAt(index);
                return InkWell(
                  onTap: () =>
                      MyNavigator(context, 'update', index, todo.text!),
                  child: Card(
                    elevation: 5,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.yellow,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      hoverColor: Colors.white,
                      selectedColor: Colors.white,
                      selectedTileColor: Colors.white,
                      leading: const Icon(
                        Icons.grading_outlined,
                        color: Colors.black,
                      ),
                      title: Center(
                        child: Text(
                          todo.text!,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => remove(index),
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  MyNavigator(context, String type, int index, String text) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoScreen(
          type: type,
          index: index,
          text: text,
        ),
      ),
    );
  }

  void remove(index) {
    Box box = Hive.box('todo');
    box.deleteAt(index);
  }
}
