import 'package:flutter/material.dart';
import 'package:mobile/components/navigation.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  bool isHomeRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == '/home';
  }

  bool isLoginRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == '/login';
  }

  bool isRegisterRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == '/register';
  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: isHomeRoute(context) ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
            onPressed: () {
              pushAndRemoveUntil('/home', context);
            },
          ),
          IconButton(
            icon: isLoginRoute(context) ? const Icon(Icons.login) : const Icon(Icons.login_outlined),
            onPressed: () {
              pushAndRemoveUntil('/login', context);
            },
          ),
          IconButton(
            icon: isRegisterRoute(context) ? const Icon(Icons.app_registration) : const Icon(Icons.app_registration_outlined),
            onPressed: () {
              pushAndRemoveUntil('/register', context);
            },
          ),
        ],
      ),
    );
  }
}
