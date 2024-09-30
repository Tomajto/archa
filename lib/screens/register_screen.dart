import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // Import the login screen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

              const SizedBox(height: 100), // Adjust the spacing below the logo

              const Text(
                'Registruj se!', // Text under the logo
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontFamily: 'Archabeta', // Apply Archabeta font
                ),
              ),

              const SizedBox(height: 20), // Add space between text and fields
              TextField(
                controller: _emailController,
                style: const TextStyle(
                  color: Color(0xFFB8FF00),
                  fontFamily: 'Archabeta', // Apply Archabeta font to input text
                ),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: const TextStyle(
                    color: Color(0xFF89BF00),
                    fontFamily: 'Archabeta', // Apply Archabeta font to hint text
                  ),
                  filled: true,
                  fillColor: Colors.black, // Black inside the box
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing between text fields
              TextField(
                controller: _passwordController,
                style: const TextStyle(
                  color: Color(0xFFB8FF00),
                  fontFamily: 'Archabeta', // Apply Archabeta font to input text
                ),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Color(0xFF89BF00),
                    fontFamily: 'Archabeta', // Apply Archabeta font to hint text
                  ),
                  hintText: 'Heslo',
                  filled: true,
                  fillColor: Colors.black, // Black inside the box
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30), // Spacing before the button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Black background for the button
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15), // Adjust button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                ),
                onPressed: _register,
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Color(0xFFB8FF00),
                    fontFamily: 'Archabeta', // Apply Archabeta font to button text
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Už účet máš? Přihlaš se!",
                style: TextStyle(
                  fontFamily: 'Archabeta', // Apply Archabeta font
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Archabeta', // Apply Archabeta font to button text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
