import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Main Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),  // MainScreen is the starting screen of the app
    );
  }
}
