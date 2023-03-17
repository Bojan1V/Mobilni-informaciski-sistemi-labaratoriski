import 'package:flutter/material.dart';
import 'package:lab3/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LoginScreen extends StatelessWidget {
  final Function(String username, String password) onLogin;

  LoginScreen({super.key, required this.onLogin});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExamsList(
                            title: 'Add new exam',
                            flutterLocalNotificationsPlugin:
                                FlutterLocalNotificationsPlugin(),
                          )),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
