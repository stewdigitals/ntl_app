// ignore_for_file: unnecessary_import, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ntl_app/features/auth/login/ui/login_page.dart';
import 'package:ntl_app/features/auth/signup/provider/signup_provider.dart';
import 'package:ntl_app/features/auth/signup/state/signup_state.dart';
import 'package:ntl_app/features/auth/signup/store/signup.dart';

import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState<AuthResponseModel>>((ref) {
      final auth = ref.read(authProvider);
      return AuthNotifier(auth);
    });

class AuthNotifier extends StateNotifier<AuthState<AuthResponseModel>> {
  final AuthProvider _authProvider;

  AuthNotifier(this._authProvider) : super(AuthState<AuthResponseModel>());

  void clearState() {
    state = AuthState<AuthResponseModel>();
  }

  bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final Map<String, dynamic> data = jsonDecode(payload);

      final exp = data['exp']; // expiry timestamp
      final now = DateTime.now().millisecondsSinceEpoch / 1000;

      return now > exp;
    } catch (e) {
      return true;
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      return false;
    }

    // OPTIONAL: check expiry if JWT
    if (isTokenExpired(token)) {
      await prefs.remove('auth_token');
      return false;
    }

    return true;
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _authProvider.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        context: context,
      );

      state = state.copyWith(isLoading: false, data: res, action: "register");
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Something went wrong");
    }
  }

  Future<void> resendOtp({
    required String email,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _authProvider.resendOtp(email: email, context: context);

      state = state.copyWith(isLoading: false, data: res, action: "resendOtp");
      debugPrint("Resend OTP 🎉");
      debugPrint("Resend OTP ${state.data?.data?.token}");
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Resend OTP failed");
    }
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _authProvider.resetPassword(
        email: email,
        newPassword: newPassword,
        context: context,
      );

      state = state.copyWith(
        isLoading: false,
        data: res,
        action: "resetPassword",
      );
      debugPrint("Reset Password 🎉");
      debugPrint("Reset Password ${state.data?.data?.token}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Reset Password failed");
    }
  }

  Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _authProvider.forgotPassword(
        email: email,
        context: context,
      );

      state = state.copyWith(
        isLoading: false,
        data: res,
        action: "forgotPassword",
      );
      debugPrint("Forgot Password 🎉");
      debugPrint("Forgot Password ${state.data?.data?.token}");
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Forgot Password failed");
    }
  }

  Future<void> verifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _authProvider.verifyOtp(
        email: email,
        otp: otp,
        context: context,
      );

      state = state.copyWith(isLoading: false, data: res, action: "verifyOtp");
      debugPrint("OTP Verified 🎉");
      debugPrint("OTP Verified ${state.data?.data?.token}");
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "OTP verification failed",
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _authProvider.login(
        email: email,
        password: password,
        context: context,
      );

      final token = res.data?.token;

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      debugPrint("💾 TOKEN SAVED: $token");

      state = state.copyWith(isLoading: false, data: res, action: "login");
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Login failed");
    }
  }
}
