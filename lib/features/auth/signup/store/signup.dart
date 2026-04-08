class AuthResponseModel {
  final String message;
  final String? token;

  AuthResponseModel({required this.message, this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: json['message'] ?? 'No message',
      token: json['data']?['token'],
    );
  }
}
