import 'package:flutter/material.dart';
import 'package:mobile/components/register.dart';
import 'package:mobile/widgets/entryField.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/widgets/submit.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController urlImageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      bottomNavigationBar: const NavBar(),
      body: Center(
        child: Column(
          children: [
            EntryField(
              label: 'Pseudo',
              placeholder: 'Enter your pseudo',
              controller: nicknameController,
              obscureText: false,
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            EntryField(
              label: 'Url Image',
              placeholder: 'Enter your url image',
              controller: urlImageController,
              obscureText: false,
              prefixIcon: const Icon(Icons.image),
            ),
            const SizedBox(height: 24),
            SubmitButton(
              handleAction: handleRegister,
              paramsController: [emailController, passwordController, nicknameController, urlImageController],
              allowedEmpty: const [3],
            ),
          ],
        ),
      ),
    );
  }
}