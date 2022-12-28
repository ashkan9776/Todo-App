import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final TextEditingController _controller = TextEditingController();
  bool showEnterName = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.all(30),
          color: Colors.yellow,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "اسمت رو بگو",
                  style: GoogleFonts.lalezar(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lalezar(),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        if (_controller.text == "" || _controller.text == " ") {
                          showEnterName = true;
                        } else {
                          _sendDataToSecondScreen(context);
                        }
                      },
                    );
                  },
                  child: const Text("Click"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = _controller.text;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          text: textToSend,
        ),
      ),
    );
  }
}
