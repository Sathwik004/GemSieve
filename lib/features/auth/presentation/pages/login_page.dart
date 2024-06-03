import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text('Google auth'),
          ),
        ]),
      ),
    );
  }
}
