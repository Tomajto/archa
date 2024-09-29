import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart'; // Import the main screen from lib/main_screen.dart
import 'register_screen.dart'; // Import the register screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to the main screen after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()), // Main screen
      );
    } catch (e) {
      print("Login Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Light grey background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock, // Lock icon at the top
              size: 100,
              color: Colors.black,
            ),
            const SizedBox(height: 15), // Space between the lock and text
            const Text(
              'Přihlas se!', // Text under lock icon
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 15), // Add space between lock and fields
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white, // White inside the box
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing between text fields
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white, // White inside the box
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30), // Spacing before the button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Black background for the button
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Adjust button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _login,
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white), // White text
              ),
            ),
            const SizedBox(height: 20),
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                // Navigate to the register screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Register', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
