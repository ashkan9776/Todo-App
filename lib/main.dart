import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/constant/box_name.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/view/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            onPrimary: Colors.black,
            background: Colors.white,
            primary: Colors.amber),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
