import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignIn ? 'Sign In' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Handle authentication logic here
                String email = _emailController.text;
                String password = _passwordController.text;

                print(isSignIn
                    ? 'Signing in with Email: $email and Password: $password'
                    : 'Signing up with Email: $email and Password: $password');
              },
              child: Text(isSignIn ? 'Sign In' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignIn = !isSignIn;
                });
              },
              child: Text(
                isSignIn ? 'Don\'t have an account? Sign Up' : 'Already have an account? Sign In',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
