import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/lottie/todo_list.json',
              onLoaded: (p0) {
                Future.delayed(
                  Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  ),
                );
              },
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
