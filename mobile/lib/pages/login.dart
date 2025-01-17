import 'package:flutter/material.dart';
import 'package:mobile/widgets/navbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      bottomNavigationBar: const NavBar(),
      body: const Center(
          child: Text('Login screen'),
      ),
    );
  }
}