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
