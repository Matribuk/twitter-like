import 'package:flutter/material.dart';
import 'package:mobile/widgets/navbar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      bottomNavigationBar: const NavBar(),
      body: const Center(
          child: Text('Register screen'),
      )
    );
  }
}