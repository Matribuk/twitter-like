import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/login.dart';
import 'package:mobile/widgets/loginRegister/entryField.dart';
import 'package:mobile/widgets/navbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      bottomNavigationBar: const NavBar(),
      body: Center(
          child: Column(
            children: [
              EntryField(
                label: 'Email Address',
                placeholder: 'Enter your email',
                controller: emailController,
                inputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 16),
              EntryField(
                label: 'Password',
                placeholder: 'Enter your password',
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  if (kDebugMode) print(handleLogin(email, password));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
          //child: Text('Login screen'),

      ),
    );
  }
}
