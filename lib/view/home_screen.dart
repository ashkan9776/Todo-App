import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/constant/box_name.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/view/info_screen.dart';

import 'edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> searchKeyword = ValueNotifier("");
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(boxName);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => InfoScreen()));
            },
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
          ),
        ],
        title: const Text(
          "ToDo   List",
          style: TextStyle(fontFamily: 'yekan'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              onChanged: (value) {
                searchKeyword.value = controller.text;
              },
              controller: controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: "Search",
                hintStyle: TextStyle(fontFamily: 'yekan'),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: searchKeyword,
                builder: (context, value, child) {
                  return ValueListenableBuilder<Box<Task>>(
                    valueListenable: box.listenable(),
                    builder: (context, box, child) {
                      final List<Task> items;
                      if (controller.text.isEmpty) {
                        items = box.values.toList();
                      } else {
                        items = box.values
                            .where(
                                (Task) => Task.name.contains(controller.text))
                            .toList();
                      }
                      if (items.isNotEmpty) {
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final Task task = items[index];
                            return TaskEntity(task: task);
                          },
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "No Any Task For Now",
                                style: TextStyle(
                                    fontFamily: 'yekan', fontSize: 15),
                              ),
                              Lottie.asset('assets/lottie/emptystate.json'),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                task: TaskEntity(
                  task: Task(),
                ),
              ),
            ),
          );
        },
        label: const Text(
          "Add New Task",
          style: TextStyle(fontFamily: 'yekan'),
        ),
      ),
    );
  }
}

class MyCheckBox extends StatelessWidget {
  final bool value;
  final Function() ontap;
  const MyCheckBox({Key? key, required this.value, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: !value ? Border.all(color: Colors.grey) : null,
            color: value ? Colors.yellow : null),
        child: value ? const Icon(Icons.check, size: 15) : null,
      ),
    );
  }
}

class TaskEntity extends StatefulWidget {
  const TaskEntity({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskEntity> createState() => _TaskEntityState();
}

class _TaskEntityState extends State<TaskEntity> {
  @override
  Widget build(BuildContext context) {
    final Color priorityColor;

    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = Colors.cyan;
        break;
      case Priority.normal:
        priorityColor = Colors.orange;
        break;
      case Priority.high:
        priorityColor = Colors.deepPurple;
        break;
    }
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onLongPress: () {
        widget.task.delete();
      },
      onTap: () {
        // setState(() {
        //   widget.task.isCompleted = !widget.task.isCompleted;
        // });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EditTaskScreen(task: TaskEntity(task: widget.task)),
        ));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 15, 5, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: priorityColor,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: priorityColor,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              MyCheckBox(
                value: widget.task.isCompleted,
                ontap: () {
                  setState(() {
                    widget.task.isCompleted = !widget.task.isCompleted;
                  });
                },
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  widget.task.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'yekan',
                      fontSize: 24,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
