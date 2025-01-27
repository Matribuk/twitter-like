import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/components/api.dart';
import 'package:mobile/components/token.dart';
import 'package:mobile/models/home.dart';
import 'package:mobile/widgets/entryField.dart';
import 'package:mobile/widgets/home/chat.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/widgets/submit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController chatController = TextEditingController();
  bool loadManual = false;

  Future<bool> handleChat(List<String> params) async {
    final userChat = params[0];

    final requestData = ChatSendRequest(message: userChat);
    final apiUrl = dotenv.env['API_URL'] ?? '';
    final apiEndpointLogin = dotenv.env['API_ENDPOINT_CHAT_SEND'] ?? '';
    final apiUrlWithEndpoint = apiUrl + apiEndpointLogin;
    String? token = await getToken();
    if (token == null) return false;
    final response = await sendData(requestData.toJson(), apiUrlWithEndpoint, token: token);

    if (response.$1 == 200) {
      try {
        setState(() {
          chatController.clear();
          loadManual = true;
        });
        return true;
      } catch (e) {
        if (kDebugMode) print('Error parsing response: $e');
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      bottomNavigationBar: const NavBar(),
      body: Center(
        child: Column(
          children: [
            const Text('Home screen'),
            ChatWidget(loadManual: loadManual),
            EntryField(
              label: 'Chat',
              placeholder: 'Enter your message',
              controller: chatController,
              obscureText: false,
              prefixIcon: const Icon(Icons.chat),
            ),
            SubmitButton(
              handleAction: handleChat,
              paramsController: [chatController],
            ),
          ],
        ),
      ),
    );
  }
}