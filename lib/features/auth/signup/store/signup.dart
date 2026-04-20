import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:ntl_app/features/fetchService/fetchServiceProvider.dart';

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

class SupportResponseModel {
  final bool success;
  final String message;

  SupportResponseModel({required this.success, required this.message});

  factory SupportResponseModel.fromJson(Map<String, dynamic> json) {
    return SupportResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}

final supportStoreProvider = Provider<SupportStore>((ref) {
  final fetch = ref.read(fetchServiceProvider);
  return SupportStore(fetch);
});

class SupportStore {
  final FetchService _fetch;

  SupportStore(this._fetch);

  Future<SupportResponseModel> sendSupport({
    required String name,
    required String phone,
    required String email,
    required String message,
    required String service,
  }) async {
    final response = await _fetch.post(
      "/user/save/support",
      body: {
        "name": name,
        "phone": phone,
        "email": email,
        "message": message,
        "service": service,
      },
      auth: true,
    );

    return SupportResponseModel.fromJson(response);
  }
}
