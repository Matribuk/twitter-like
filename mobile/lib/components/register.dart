import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/components/api.dart';
import 'package:mobile/components/token.dart';
import 'package:mobile/models/register.dart';

Future<bool> handleRegister(String userMail, String userPassword, String userNickname) async {
  final registerData = Register(userMail: userMail, userPassword: userPassword, userNickname: userNickname);
  final apiUrl = dotenv.env['API_URL'] ?? '';
  final apiEndpointRegister = dotenv.env['API_ENDPOINT_REGISTER'] ?? '';
  final apiUrlWithEndpoint = apiUrl + apiEndpointRegister;
  final response = await sendData(registerData.toJson(), apiUrlWithEndpoint);

  if (response.$1 == 200) {
    try {
      RegisterResponse registerResponse = RegisterResponse.fromJson(jsonDecode(response.$2));
      return writeToken(registerResponse.token);
    } catch (e) {
      if (kDebugMode) print('Error parsing response: $e');
      return false;
    }
  }
  return false;
}