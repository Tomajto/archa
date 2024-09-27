import 'package:flutter/material.dart';
import 'auth_screen.dart';  // Import the AuthScreen for navigation

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
            onPressed: () {
              // Navigate to Sign Up / Sign In screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to the Main Screen'),
      ),
    );
  }
}
