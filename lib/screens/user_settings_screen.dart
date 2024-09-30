import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Import the login screen to navigate after logout

class UserSettingsScreen extends StatefulWidget {
  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();

  // Language selector variables
  String _selectedLanguage = 'English'; // Default language
  final List<String> _languages = ['English', 'Czech'];

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
      _selectedLanguage = prefs.getString('language') ?? 'English'; // Load saved language
    });
  }

  // Save username and language to SharedPreferences
  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('language', _selectedLanguage); // Save the selected language
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Username input field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            
            // Language selection dropdown
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

            // Save button
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
