import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // Import the login screen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // After successful registration, navigate to login screen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print("Registration Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Light grey background
      body: SingleChildScrollView( // Use SingleChildScrollView for scrolling if needed
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100), // Space above the logo

              // Display the logo (Replacing the lock icon)
              Image.asset(
                'assets/logo.png', // Path to your logo image in the assets folder
                height: 120, // Adjust the height as needed
              ),

              const SizedBox(height: 50), // Space between logo and text

              const Text(
                'Registruj se!', // Text under the logo
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              
              const SizedBox(height: 20), // Add space between text and fields
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
                  labelText: 'Heslo',
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
                onPressed: _register,
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),

              const SizedBox(height: 20),
              const Text("Už účet máš? Přihlaš se!"),
              TextButton(
                onPressed: () {
                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Login', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
