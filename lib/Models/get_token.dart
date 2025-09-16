class GetToken {
  String? message;
  String? token;

  GetToken({this.message, this.token});

  factory GetToken.fromJson(Map<String, dynamic> json) {
    return GetToken(
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
  };
}
