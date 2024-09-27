import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
            onPressed: () {
              // Optional action to navigate to profile or logout
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Main Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
