import 'package:flutter/material.dart';
import 'register_screen.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings', style: TextStyle(color: Colors.white)),  // Ensure the title is white
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,  // Log out button in red for visibility
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text('Log Out', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
