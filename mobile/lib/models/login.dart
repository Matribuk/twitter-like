class Login {
  final String userMail;
  final String userPassword;

  Login({required this.userMail, required this.userPassword});

  Map<String, dynamic> toJson() {
    return {
      'email': userMail,
      'password': userPassword,
    };
  }
}

class LoginResponse {
  final String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json['token']);
  }
}
