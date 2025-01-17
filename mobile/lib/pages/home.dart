import 'package:flutter/material.dart';
import 'package:mobile/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      bottomNavigationBar: const NavBar(),
      body: const Center(
        child: Text('Home screen'),
      ),
    );
  }
}