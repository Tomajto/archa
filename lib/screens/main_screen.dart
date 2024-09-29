import 'package:flutter/material.dart';
import 'user_settings_screen.dart'; // Import the user settings screen

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Hlavní strana', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              child: Icon(Icons.person), // Profile icon
            ),
            onPressed: () {
              // Navigate to user settings screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Vítej!'),
      ),
    );
  }
}
