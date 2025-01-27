class Register {
  final String userMail;
  final String userNickname;
  final String userPassword;
  final String urlImage;

  Register({
    required this.userMail,
    required this.userNickname,
    required this.userPassword,
    required this.urlImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': userMail,
      'username': userNickname,
      'password': userPassword,
      'url_image': urlImage,
    };
  }
}

class RegisterResponse {
  final String token;

  RegisterResponse({required this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(token: json['token']);
  }
}