import 'package:flutter/material.dart';
import 'package:mobile/components/login.dart';
import 'package:mobile/widgets/entryField.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/widgets/submit.dart';

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
              SubmitButton(
                handleAction: handleLogin,
                paramsController: [emailController, passwordController],
              ),
            ],
          ),
          //child: Text('Login screen'),

      ),
    );
  }
}
