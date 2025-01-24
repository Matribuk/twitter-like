import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<(int, String)> sendData<T>(T data, String apiUrl) async {
  final url = Uri.parse(apiUrl);
  final headers = {'Content-Type': 'application/json'};

  try {
    final body = json.encode(data);
    if (kDebugMode) print('Body : $body');
    if (kDebugMode) print('Headers : $headers');
    if (kDebugMode) print('URL : $url');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return (response.statusCode, response.body);
    } else {
      if (kDebugMode) print('Erreur : ${response.statusCode}');
      return (response.statusCode, "");
    }
  } catch (e) {
    if (kDebugMode) print('Une erreur s\'est produite : $e');
    return (500, "");
  }
}
