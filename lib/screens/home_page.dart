import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String text;
  const HomePage({super.key, required this.text});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  int _selectedIndex = 0; //New

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           isDarkMode = !isDarkMode;
          //         });
          //       },
          //       icon: Icon(isDarkMode ? Icons.sunny : Icons.mode_night),
          //       color: isDarkMode ? Colors.white : Colors.grey),
          //   centerTitle: true,
          //   title: Text("سلام ${widget.text}",
          //       style: GoogleFonts.lalezar(
          //           fontSize: 20,
          //           color: isDarkMode ? Colors.white : Colors.grey)),
          //   elevation: 0,
          //   shadowColor: Colors.white,
          //   backgroundColor: Colors.transparent,
          // ),
          body: Container(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        },
                        icon: Icon(isDarkMode ? Icons.sunny : Icons.mode_night),
                        color: isDarkMode ? Colors.white : Colors.grey),
                    Text(
                      "سلام ${widget.text}",
                      style: GoogleFonts.lalezar(
                          fontSize: 20,
                          color: isDarkMode ? Colors.white : Colors.grey),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.02),
                  child: Text(
                    "لیست کارهای پیش رو",
                    style: GoogleFonts.lalezar(),
                  ),
                ),
              ),
              
            ],
          )),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.share),
                          title: const Text('Share'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.copy),
                          title: const Text('Copy Link'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.edit),
                          title: const Text('Edit'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.add,
              )),
        ),
      ),
    );
  }
}
