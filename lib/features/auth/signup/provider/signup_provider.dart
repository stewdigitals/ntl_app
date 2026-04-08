// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/signup/store/signup.dart';
import 'package:ntl_app/features/fetchService/app_logger.dart';
import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:ntl_app/features/fetchService/fetchServiceProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider<AuthProvider>((ref) {
  final fetch = ref.read(fetchServiceProvider);
  return AuthProvider(fetch);
});

class AuthProvider {
  final FetchService _fetch;

  AuthProvider(this._fetch);

  // =========================
  // COMMON RESPONSE CHECK
  // =========================
  AuthResponseModel _parseResponse(dynamic response) {
    if (response == null) {
      throw ApiException(message: "Empty response from server");
    }

    if (response is! Map<String, dynamic>) {
      throw ApiException(message: "Invalid response format");
    }

    return AuthResponseModel.fromJson(response);
  }

  // =========================
  // LOGIN
  // =========================
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    const path = '/auth/login';

    try {
      AppLogger.log("🔐 LOGIN START → $email");

      final response = await _fetch.post(
        path,
        body: {"email": email, "password": password},
      );

      AppLogger.log("📦 LOGIN RESPONSE → $response");

      final model = _parseResponse(response);

      AppLogger.success("✅ LOGIN SUCCESS → ${model.message}");

      return model;
    } on ApiException catch (e) {
      AppLogger.error("❌ LOGIN API ERROR → ${e.message}");
      rethrow; // 🔥 no need to wrap again
    } catch (e, stack) {
      AppLogger.error("💥 LOGIN UNKNOWN ERROR → $e");
      AppLogger.error("STACK → $stack");

      throw ApiException(message: "Login failed. Please try again.");
    }
  }

  // =========================
  // REGISTER
  // =========================
  Future<AuthResponseModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    const path = '/auth/register';

    try {
      AppLogger.log("📝 REGISTER START → $email");

      final response = await _fetch.post(
        path,
        body: {
          "email": email,
          "password": password,
          "name": name,
          "phone": phone,
        },
      );

      AppLogger.log("📦 REGISTER RESPONSE → $response");

      final model = _parseResponse(response);

      AppLogger.success("✅ REGISTER SUCCESS → ${model.message}");

      return model;
    } on ApiException catch (e) {
      AppLogger.error("❌ REGISTER API ERROR → ${e.message}");
      rethrow;
    } catch (e, stack) {
      AppLogger.error("💥 REGISTER UNKNOWN ERROR → $e");
      AppLogger.error("STACK → $stack");

      throw ApiException(message: "Registration failed. Please try again.");
    }
  }

  // =========================
  // VERIFY OTP
  // =========================
  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    const path = '/auth/verify-otp';

    try {
      AppLogger.log("🔢 VERIFY OTP → $email");

      final response = await _fetch.post(
        path,
        body: {"email": email, "otp": otp},
      );

      final model = _parseResponse(response);

      AppLogger.success("✅ OTP VERIFIED");

      return model;
    } on ApiException catch (e) {
      AppLogger.error("❌ VERIFY OTP ERROR → ${e.message}");
      rethrow;
    } catch (e) {
      AppLogger.error("💥 OTP UNKNOWN ERROR → $e");
      throw ApiException(message: "OTP verification failed");
    }
  }

  // =========================
  // FORGOT PASSWORD
  // =========================
  Future<AuthResponseModel> forgotPassword({required String email}) async {
    const path = '/auth/forgot-password';

    try {
      AppLogger.log("📩 FORGOT PASSWORD → $email");

      final response = await _fetch.post(path, body: {"email": email});

      final model = _parseResponse(response);

      AppLogger.success("✅ OTP SENT");

      return model;
    } on ApiException catch (e) {
      AppLogger.error("❌ FORGOT PASSWORD ERROR → ${e.message}");
      rethrow;
    } catch (e) {
      AppLogger.error("💥 UNKNOWN ERROR → $e");
      throw ApiException(message: "Failed to send OTP");
    }
  }

  // =========================
  // RESET PASSWORD
  // =========================
  Future<AuthResponseModel> resetPassword({
    required String email,
    required String newPassword,
    required BuildContext context,
  }) async {
    const path = '/auth/reset-password';

    try {
      AppLogger.log("🔁 RESET PASSWORD → $email");

      final response = await _fetch.post(
        path,
        body: {"email": email, "newPassword": newPassword},
      );

      final model = _parseResponse(response);

      AppLogger.success("✅ PASSWORD RESET SUCCESS");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );

      return model;
    } on ApiException catch (e) {
      AppLogger.error("❌ RESET PASSWORD ERROR → ${e.message}");
      rethrow;
    } catch (e) {
      AppLogger.error("💥 UNKNOWN ERROR → $e");
      throw ApiException(message: "Password reset failed");
    }
  }

  // =========================
  // RESEND OTP
  // =========================
  Future<AuthResponseModel> resendOtp({required String email}) async {
    const path = '/auth/resend-otp';

    try {
      AppLogger.log("🔄 RESEND OTP → $email");

      final response = await _fetch.post(path, body: {"email": email});

      final model = _parseResponse(response);

      AppLogger.success("✅ OTP RESENT");

      return model;
    } on ApiException catch (e) {
      AppLogger.error("❌ RESEND OTP ERROR → ${e.message}");
      rethrow;
    } catch (e) {
      AppLogger.error("💥 UNKNOWN ERROR → $e");
      throw ApiException(message: "Failed to resend OTP");
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('auth_token');

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }
}
