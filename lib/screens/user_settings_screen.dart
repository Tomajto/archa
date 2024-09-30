// ignore: unused_import
import 'package:archa/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Import the login screen to navigate after logout

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();

  // Language selector variables
  String _selectedLanguage = 'English'; // Default language

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load username from SharedPreferences
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _selectedLanguage =
          prefs.getString('language') ?? 'English'; // Load saved language
    });
  }

  // Save username and language to SharedPreferences
  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString(
        'language', _selectedLanguage); // Save the selected language
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Settings saved!',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Color(0xFFFF4C00),
      ),
    );
  }

  // Logout user and navigate to login screen
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USER SETTINGS'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Username input field with white text
            Theme(
              data: Theme.of(context).copyWith(
                  textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xFFFF4C00), // Cursor color
                selectionColor: Color(0xFFFF4C00), // Selection highlight color
                selectionHandleColor: Color(0xFFFF4C00),
              )),
              child: TextField(
                cursorColor: const Color(0xFFFF4C00),
                controller: _usernameController,
                style: const TextStyle(
                    color: Colors.white), // White text inside username input
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  labelStyle:
                      const TextStyle(color: Colors.white), // Label in white
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF4C00))),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors
                      .grey[900], // Set background color for the input field
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFFF4C00), // Black text
                ),
                onPressed: _saveSettings,
                child: const Text(
                  'Save Settings',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.82),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFFF4C00), // Black text
                ),
                onPressed: _logout,
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
            ]
                // Save button with orange background and black text
                )
          ],
        ),
      ),
    );
  }
}
