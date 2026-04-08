// appointment_state.dart

class AppointmentState {
  final bool isLoading;
  final String? error;

  const AppointmentState({this.isLoading = false, this.error});

  AppointmentState copyWith({bool? isLoading, String? error}) {
    return AppointmentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory AppointmentState.initial() => const AppointmentState();
}
