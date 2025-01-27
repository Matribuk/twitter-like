class ChatData {
  final String name;
  final String message;
  final String time;
  final String urlImage;
  final String userName;

  ChatData({required this.name, required this.message, required this.time, required this.urlImage, required this.userName});
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

class ChatSendRequest {
  final String message;

  ChatSendRequest({required this.message});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

class ChatAnwser {
  final int userId;
  final String message;
  final String createdAt;
  final String urlImage;
  final String userName;


  ChatAnwser({required this.userId, required this.message, required this.createdAt, required this.urlImage, required this.userName});

  factory ChatAnwser.fromJson(Map<String, dynamic> json) {
    return ChatAnwser(
      userId: json['user_id'] as int,
      message: json['message'] as String,
      createdAt: json['create_at'] as String,
      urlImage: json['url_image'] as String,
      userName: json['user_name'] as String,
    );
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
          urlImage: chatData['urlImage'] ?? '',
          userName: chatData['userName'] ?? '',
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