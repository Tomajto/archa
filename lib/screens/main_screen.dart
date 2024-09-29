import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen

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
              child: Icon(Icons.person), // Profile icon
            ),
            onPressed: () {
              // Navigate to user settings screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Main Screen!'),
      ),
    );
  }
}
