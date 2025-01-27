import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/components/api.dart';
import 'package:mobile/components/token.dart';
import 'package:mobile/models/home.dart';

Future<ChatHome> loadChat(ChatHome loadedChat) async {
  int actualIndex = loadedChat.requestIndex;

  final requestData = ChatRequest(requestIndex: actualIndex);
  final apiUrl = dotenv.env['API_URL'] ?? '';
  final apiEndpointLogin = dotenv.env['API_ENDPOINT_CHAT_GET'] ?? '';
  final apiUrlWithEndpoint = apiUrl + apiEndpointLogin;
  String? token = await getToken();
  if (token == null) return loadedChat;
  if (kDebugMode) print("apiurl$apiUrlWithEndpoint");
  if (kDebugMode) print("token$token");
  final response = await sendData(requestData.toJson(), apiUrlWithEndpoint, token: token);

  if (response.$1 == 200) {
    try {
      List<dynamic> jsonList = jsonDecode(response.$2);

      List<ChatAnwser> chatList = jsonList.map((item) {
        return ChatAnwser.fromJson(item as Map<String, dynamic>);
      }).toList();

      List<ChatData> chats = chatList.map((chatAnwser) {
        return ChatData(
          name: chatAnwser.userId.toString(),
          message: chatAnwser.message,
          time: chatAnwser.createdAt,
          urlImage: chatAnwser.urlImage,
          userName: chatAnwser.userName,
        );
      }).toList();

      return ChatHome(chatData: chats, requestIndex: actualIndex + 1);
    } catch (e) {
      if (kDebugMode) print('Error parsing response: $e');
      return loadedChat;
    }
  }
  return loadedChat;
}