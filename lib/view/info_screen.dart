import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Hold   the  box  until  it  clears :)",
          style: TextStyle(fontFamily: 'yekan', fontSize: 20),
        ),
      ),
    );
  }
}
