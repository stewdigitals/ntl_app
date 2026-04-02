import 'package:flutter_riverpod/legacy.dart';

class BookingState {
  final String? branch;
  final String? service;
  final String? date;
  final String? time;

  BookingState({this.branch, this.service, this.date, this.time});

  BookingState copyWith({
    String? branch,
    String? service,
    String? date,
    String? time,
  }) {
    return BookingState(
      branch: branch ?? this.branch,
      service: service ?? this.service,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}

// ✅ PROVIDER
final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>(
  (ref) => BookingNotifier(),
);

// ✅ NOTIFIER
class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(BookingState());

  void setBranch(String branch) {
    state = state.copyWith(branch: branch);
  }

  void setService(String service) {
    state = state.copyWith(service: service);
  }
}
