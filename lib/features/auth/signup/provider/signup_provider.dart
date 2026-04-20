// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/signup/state/signup_state.dart';
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
    required BuildContext context,
  }) async {
    const path = '/auth/login';

    try {
      AppSnackbar.show(context, "🔐 LOGIN START → $email");

      final response = await _fetch.post(
        path,
        body: {"email": email, "password": password},
      );

      AppSnackbar.show(context, "📦 LOGIN RESPONSE → $response");

      final model = _parseResponse(response);

      final token = model.data?.token;

      if (token == null || token.isEmpty) {
        AppSnackbar.show(
          context,
          "❌ Token missing in response",
          type: SnackType.error,
        );
        throw ApiException(message: "Token not found");
      }

      AppSnackbar.show(context, "Login Success");

      return model;
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        "❌ LOGIN API ERROR → ${e.message}",
        type: SnackType.error,
      );
      rethrow; // 🔥 no need to wrap again
    } catch (e, stack) {
      AppSnackbar.show(
        context,
        "💥 LOGIN UNKNOWN ERROR → $e",
        type: SnackType.error,
      );
      AppSnackbar.show(context, "STACK → $stack", type: SnackType.error);

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
    required BuildContext context,
  }) async {
    const path = '/auth/register';

    try {
      AppSnackbar.show(context, "📝 REGISTER START → $email");

      final response = await _fetch.post(
        path,
        body: {
          "email": email,
          "password": password,
          "name": name,
          "phone": phone,
        },
      );

      AppSnackbar.show(context, "📦 REGISTER RESPONSE → $response");

      final model = _parseResponse(response);

      AppSnackbar.show(context, "✅ REGISTER SUCCESS → ${model.message}");

      return model;
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        "❌ REGISTER API ERROR → ${e.message}",
        type: SnackType.error,
      );
      rethrow;
    } catch (e, stack) {
      AppSnackbar.show(
        context,
        "💥 REGISTER UNKNOWN ERROR → $e",
        type: SnackType.error,
      );
      AppSnackbar.show(context, "STACK → $stack", type: SnackType.error);

      throw ApiException(message: "Registration failed. Please try again.");
    }
  }

  // =========================
  // VERIFY OTP
  // =========================
  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    const path = '/auth/verify-otp';

    try {
      AppSnackbar.show(context, "🔢 VERIFY OTP → $email");

      final response = await _fetch.post(
        path,
        body: {"email": email, "otp": otp},
      );

      final model = _parseResponse(response);

      AppSnackbar.show(context, "✅ OTP VERIFIED");

      return model;
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        "❌ VERIFY OTP ERROR → ${e.message}",
        type: SnackType.error,
      );
      rethrow;
    } catch (e) {
      AppSnackbar.show(
        context,
        "💥 OTP UNKNOWN ERROR → $e",
        type: SnackType.error,
      );
      throw ApiException(message: "OTP verification failed");
    }
  }

  // =========================
  // FORGOT PASSWORD
  // =========================
  Future<AuthResponseModel> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    const path = '/auth/forgot-password';

    try {
      AppSnackbar.show(context, "📩 FORGOT PASSWORD → $email");

      final response = await _fetch.post(path, body: {"email": email});

      final model = _parseResponse(response);

      AppSnackbar.show(context, "✅ OTP SENT");

      return model;
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        "❌ FORGOT PASSWORD ERROR → ${e.message}",
        type: SnackType.error,
      );
      rethrow;
    } catch (e) {
      AppSnackbar.show(context, "💥 UNKNOWN ERROR → $e", type: SnackType.error);
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
      AppSnackbar.show(context, "🔁 RESET PASSWORD → $email");

      final response = await _fetch.post(
        path,
        body: {"email": email, "newPassword": newPassword},
      );

      final model = _parseResponse(response);

      AppSnackbar.show(context, "✅ PASSWORD RESET SUCCESS");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );

      return model;
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        "❌ RESET PASSWORD ERROR → ${e.message}",
        type: SnackType.error,
      );
      rethrow;
    } catch (e) {
      AppSnackbar.show(context, "💥 UNKNOWN ERROR → $e", type: SnackType.error);
      throw ApiException(message: "Password reset failed");
    }
  }

  // =========================
  // RESEND OTP
  // =========================
  Future<AuthResponseModel> resendOtp({
    required String email,
    required BuildContext context,
  }) async {
    const path = '/auth/resend-otp';

    try {
      AppSnackbar.show(context, "🔄 RESEND OTP → $email");

      final response = await _fetch.post(path, body: {"email": email});

      final model = _parseResponse(response);

      AppSnackbar.show(context, "✅ OTP RESENT");

      return model;
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        "❌ RESEND OTP ERROR → ${e.message}",
        type: SnackType.error,
      );
      rethrow;
    } catch (e) {
      AppSnackbar.show(context, "💥 UNKNOWN ERROR → $e", type: SnackType.error);
      throw ApiException(message: "Failed to resend OTP");
    }
  }

  Future<ProfileModel?> fetchProfile() async {
    try {
      final res = await _fetch.get("/auth/profile", auth: true);

      final profile = ProfileModel.fromJson(res['data']);

      debugPrint("👤 PROFILE → ${profile.name}");

      return profile;
    } catch (e) {
      debugPrint("❌ PROFILE ERROR: $e");
      return null;
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
    AppSnackbar.show(context, "LOGOUT SUCCESS");
  }
}

final supportProvider = StateNotifierProvider<SupportNotifier, SupportState>((
  ref,
) {
  final store = ref.read(supportStoreProvider);
  return SupportNotifier(store);
});

class SupportNotifier extends StateNotifier<SupportState> {
  final SupportStore _store;

  SupportNotifier(this._store) : super(const SupportState());

  Future<void> submitSupport({
    required String name,
    required String phone,
    required String email,
    required String message,
    required String service,
  }) async {
    state = state.copyWith(isLoading: true, isSuccess: false, error: null);

    try {
      final res = await _store.sendSupport(
        name: name,
        phone: phone,
        email: email,
        message: message,
        service: service,
      );

      state = state.copyWith(isLoading: false, isSuccess: true, data: res);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const SupportState();
  }
}
