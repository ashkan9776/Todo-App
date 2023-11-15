import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/view/home_screen.dart';
import '../constant/box_name.dart';
import '../data/data.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskEntity task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    late final TextEditingController _controller =
        TextEditingController(text: widget.task.task.name);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Task",
          style: TextStyle(fontFamily: 'yekan'),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.task.task.name = _controller.text;
          widget.task.task.priority = widget.task.task.priority;
          if (widget.task.task.isInBox) {
            widget.task.task.save();
          } else {
            final Box<Task> box = Hive.box(boxName);
            box.add(widget.task.task);
          }
          Navigator.of(context).pop();
        },
        label: const Row(
          children: [
            Text(
              "Save",
              style: TextStyle(fontFamily: 'yekan'),
            ),
            SizedBox(width: 5),
            Icon(Icons.check),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: PriorityCheck(
                    label: 'high',
                    color: Colors.deepPurple,
                    isSelect: widget.task.task.priority == Priority.high,
                    callback: () {
                      setState(() {
                        widget.task.task.priority = Priority.high;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheck(
                    label: 'normal',
                    color: Colors.orange,
                    isSelect: widget.task.task.priority == Priority.normal,
                    callback: () {
                      setState(() {
                        widget.task.task.priority = Priority.normal;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheck(
                    label: 'low',
                    color: Colors.cyan,
                    isSelect: widget.task.task.priority == Priority.low,
                    callback: () {
                      setState(() {
                        widget.task.task.priority = Priority.low;
                      });
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                label: Text(
                  "Add a task for today",
                  style: TextStyle(fontFamily: 'yekan', color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCheck extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelect;
  final GestureTapCallback callback;

  const PriorityCheck(
      {super.key,
      required this.label,
      required this.color,
      required this.isSelect,
      required this.callback});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.grey.shade200),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(label),
            )),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: PriorityCheckBox(value: isSelect, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCheckBox extends StatelessWidget {
  final bool value;
  final Color color;

  const PriorityCheckBox({Key? key, required this.value, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color),
        child: value
            ? const Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
