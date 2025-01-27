import 'package:flutter/material.dart';
import 'package:mobile/middlewares/pages.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/register.dart';

Route _createRoute(String routeName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      if (routeName == '/home') {
        return HomePage();
      } else if (routeName == '/login') {
        return LoginPage();
      } else if (routeName == '/register') {
        return RegisterPage();
      } else {
        return LoginPage();
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

Future<void> pushAndRemoveUntil(String routeName, BuildContext context) async {
  bool isAllowed = await tryAccessRoute(routeName);
  if (isAllowed && context.mounted) Navigator.pushAndRemoveUntil(context, _createRoute(routeName), (Route<dynamic> route) => false);
}