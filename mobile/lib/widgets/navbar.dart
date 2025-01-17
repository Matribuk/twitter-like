import 'package:flutter/material.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/register.dart';

Route _createRoute(String routeName) {
  
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      if (routeName == '/') {
        return const HomePage();
      } else if (routeName == '/login') {
        return const LoginPage();
      } else if (routeName == '/register') {
        return const RegisterPage();
      } else {
        return const HomePage();
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  bool isHomeRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == '/';
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
              Navigator.pushAndRemoveUntil(context, _createRoute('/'), (Route<dynamic> route) => false);
            },
          ),
          IconButton(
            icon: isLoginRoute(context) ? const Icon(Icons.login) : const Icon(Icons.login_outlined),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, _createRoute('/login'), (Route<dynamic> route) => false);
            },
          ),
          IconButton(
            icon: isRegisterRoute(context) ? const Icon(Icons.app_registration) : const Icon(Icons.app_registration_outlined),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, _createRoute('/register'), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
 