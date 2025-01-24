import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/components/api.dart';
import 'package:mobile/models/home.dart';

Future<ChatHome> loadChat(ChatHome loadedChat) async {
  int actualIndex = loadedChat.requestIndex;


  final requestData = ChatRequest(requestIndex: actualIndex);
  final apiUrl = dotenv.env['API_URL'] ?? '';
  final apiEndpointLogin = dotenv.env['API_ENDPOINT_HOME'] ?? '';
  final apiUrlWithEndpoint = apiUrl + apiEndpointLogin;
  final response = await sendData(requestData.toJson(), apiUrlWithEndpoint);

  if (response.$1 == 200) {
    try {
      ChatHomeResponse loginResponse = ChatHomeResponse.fromJson(jsonDecode(response.$2));
      if (kDebugMode) print(loginResponse);
      return ChatHome();
    } catch (e) {
      if (kDebugMode) print('Error parsing response: $e');
      return ChatHome();
    }
  }
  return loadedChat;
}