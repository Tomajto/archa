import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Import the login screen to navigate after logout

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _selectedLanguage = 'English'; // Default language
  bool _isChecking = false; // To show a loading indicator during username check

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

  // Check if the username is available in Firestore
  Future<bool> _isUsernameAvailable(String username) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isEmpty; // True if no matching username found
  }

  // Save username and language to SharedPreferences and Firestore
  Future<void> _saveSettings() async {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Username cannot be empty!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isChecking = true; // Show loading indicator
    });

    // Check if the username is available
    bool isAvailable = await _isUsernameAvailable(username);

    setState(() {
      _isChecking = false; // Hide loading indicator
    });

    if (isAvailable) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('language', _selectedLanguage);

      // Save the username in Firestore (you may have a different structure)
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'username': username,
        'language': _selectedLanguage,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Settings saved!',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Color(0xFFFF4C00),
        ),
      );
    } else {
      // Show error message if username is taken
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Username is already taken!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Logout user and navigate to login screen
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
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
                  fillColor: Colors.grey[900], // Set background color for the input field
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Show loading indicator while checking username
            if (_isChecking) const CircularProgressIndicator(),
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
            ])
          ],
        ),
      ),
    );
  }
}
