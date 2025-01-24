class ChatData {
  final String name;
  final String message;
  final String time;

  ChatData({required this.name, required this.message, required this.time});
}

class ChatHome {
  List<ChatData> chatData;
  int requestIndex;

  ChatHome({this.chatData = const [], this.requestIndex = 0});
}

class ChatRequest {
  int requestIndex;

  ChatRequest({required this.requestIndex});

  Map<String, dynamic> toJson() {
    return {
      'requestIndex': requestIndex,
    };
  }
}

class ChatHomeResponse {
  final ChatHome chatData;

  ChatHomeResponse({required this.chatData});

  factory ChatHomeResponse.fromJson(Map<String, dynamic> json) {
    List<ChatData> chatList = [];
    if (json['chatData'] != null && json['chatData'] is List) {
      chatList = (json['chatData'] as List).map((chatData) {
        return ChatData(
          name: chatData['name'] ?? '',
          message: chatData['message'] ?? '',
          time: chatData['time'] ?? '',
        );
      }).toList();
    }
    return ChatHomeResponse(
      chatData: ChatHome(
        chatData: chatList,
        requestIndex: json['requestIndex'] ?? 0
      ),
    );
  }
}