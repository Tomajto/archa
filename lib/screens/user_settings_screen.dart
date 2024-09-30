import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // Import the login screen to navigate after logout

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  String _selectedLanguage = 'English'; // Default language
  final List<String> _languages = ['English', 'Czech'];

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser?.email ?? 'No email available';

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Logged in as: $email',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Modern styled dropdown menu for language selection with flags
            Text(
              'Select language:',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButton<String>(
                value: _selectedLanguage,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                dropdownColor: Colors.white,
                isExpanded: true,
                underline: Container(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                items: _languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Row(
                      children: [
                        // Add flags based on the language
                        if (language == 'English')
                          Image.asset(
                            'assets/vlajka_uk.png', // Path to the UK flag
                            width: 24,
                            height: 24,
                          ),
                        if (language == 'Czech')
                          Image.asset(
                            'assets/vlajka_cr.png', // Path to the Czech flag
                            width: 24,
                            height: 24,
                          ),
                        const SizedBox(width: 10),
                        Text(language),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Additional settings or UI components
            // ...
          ],
        ),
      ),
    );
  }
}
