import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/components/api.dart';
import 'package:mobile/components/token.dart';
import 'package:mobile/models/register.dart';

Future<bool> handleRegister(List<String> params) async {
  final userMail = params[0];
  final userPassword = params[1];
  final userNickname = params[2];
  final userUrlImage = params[3];

  final registerData = Register(userMail: userMail, userPassword: userPassword, userNickname: userNickname, urlImage: userUrlImage);
  final apiUrl = dotenv.env['API_URL'] ?? '';
  final apiEndpointRegister = dotenv.env['API_ENDPOINT_REGISTER'] ?? '';
  final apiUrlWithEndpoint = apiUrl + apiEndpointRegister;
  if (kDebugMode) print(apiUrlWithEndpoint);
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