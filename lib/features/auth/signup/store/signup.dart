class AuthResponseModel {
  final bool success;
  final String message;
  final AuthData? data;

  AuthResponseModel({required this.success, required this.message, this.data});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
    );
  }
}

class AuthData {
  final String token;

  AuthData({required this.token});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(token: json['token'] ?? '');
  }
}

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool verified;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.verified,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      verified: json['verified'] ?? false,
    );
  }
}
