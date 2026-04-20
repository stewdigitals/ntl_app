import 'package:ntl_app/features/auth/signup/store/signup.dart';

class AuthState<T> {
  final bool isLoading;
  final T? data;
  final String? error;
  final String? action; // 👈 ADD THIS

  AuthState({this.isLoading = false, this.data, this.error, this.action});

  AuthState<T> copyWith({
    bool? isLoading,
    T? data,
    String? error,
    String? action,
  }) {
    return AuthState<T>(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
      action: action ?? this.action,
    );
  }
}

class SupportState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final SupportResponseModel? data;

  const SupportState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.data,
  });

  SupportState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    SupportResponseModel? data,
  }) {
    return SupportState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      data: data ?? this.data,
    );
  }
}
