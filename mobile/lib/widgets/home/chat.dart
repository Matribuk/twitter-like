import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/home.dart';
import 'package:mobile/models/home.dart';

class ChatWidget extends StatefulWidget {
  final bool loadManual;
  const ChatWidget({super.key, required this.loadManual});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ChatHome chatHome = ChatHome();

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  @override
  void didUpdateWidget(covariant ChatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.loadManual != widget.loadManual) {
      _loadChatData();
    }
  }

  Future<void> _loadChatData() async {
    ChatHome loadedChat = await loadChat(chatHome);
    if (kDebugMode) {
      print(loadedChat.chatData);
    }
    for (var chat in loadedChat.chatData) {
      if (kDebugMode) {
        print(chat.message);
        print(chat.urlImage);
        print(chat.userName);
      }
    }
    setState(() {
      chatHome = loadedChat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chatHome.chatData.isEmpty ? _loadChatData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var chat in chatHome.chatData) _buildChatItem(chat),
                ],
              ),
            ),
          );
        }
      },
    );
  }



  Widget _buildChatItem(ChatData chat) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      height: 64,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            child: chat.urlImage.isEmpty
                ? const Icon(Icons.person)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      chat.urlImage,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    chat.message,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}