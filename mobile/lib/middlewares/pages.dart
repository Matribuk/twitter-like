import 'package:mobile/components/token.dart';

Future<bool> clientSideAuthorization() async {
  String? token = await getToken();
  if (token != null) return true;
  return false;
}

Future<bool> tryAccessRoute(String routeName) async {
  if (routeName == '/login' || routeName == '/register') return true;
  return await clientSideAuthorization();
}