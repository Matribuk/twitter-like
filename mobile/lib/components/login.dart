import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/components/api.dart';
import 'package:mobile/components/token.dart';
import 'package:mobile/models/login.dart';

Future<bool> handleLogin(String userMail, String userPassword) async {
  final loginData = Login(userMail: userMail, userPassword: userPassword);
  final apiUrl = dotenv.env['API_URL'] ?? '';
  final apiEndpointLogin = dotenv.env['API_ENDPOINT_LOGIN'] ?? '';
  final apiUrlWithEndpoint = apiUrl + apiEndpointLogin;
  final response = await sendData(loginData.toJson(), apiUrlWithEndpoint);

  if (response.$1 == 200) {
    try {
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.$2));
      return writeToken(loginResponse.token);
    } catch (e) {
      if (kDebugMode) print('Error parsing response: $e');
      return false;
    }
  }
  return false;
}