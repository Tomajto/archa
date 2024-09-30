import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart'; // Import the main screen from lib/main_screen.dart
import 'register_screen.dart'; // Import the register screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => const MainScreen()), // Main screen
      );
    } catch (e) {
      print("Login Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8FF00), // Light grey background
      body: SingleChildScrollView( // Add SingleChildScrollView for scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align to the top
            children: [
              const SizedBox(height: 50), // Space above the logo

              // Display the logo (Replacing the lock icon)
              Image.asset(
                'assets/logo.png', // Path to your logo image in the assets folder
                height: 250, // Adjust the height as needed
              ),

              const SizedBox(height: 100), // Space between logo and text

              const Text(
                'Přihlas se!', // Text under the logo
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),

              const SizedBox(height: 20), // Add space between text and fields
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Color(0xFFB8FF00)),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Color(0xFF89BF00)),
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.black, // White inside the box
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing between text fields
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Color(0xFFB8FF00)),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Color(0xFF89BF00)),
                  hintText: 'Heslo',
                  filled: true,
                  fillColor: Colors.black, // White inside the box
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30), // Spacing before the button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Black background for the button
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15), // Adjust button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  'Login',
                  style: TextStyle(color: Color(0xFFB8FF00)), // White text
                ),
              ),
              const SizedBox(height: 20),
              const Text("Nemáš účet? Udělej si ho!"),
              TextButton(
                onPressed: () {
                  // Navigate to the register screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text('Registrace',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
