// appointment_store.dart

import 'package:flutter_riverpod/legacy.dart';

class AppointmentStoreData {
  final List<dynamic> appointments;
  final dynamic appointmentDetail;
  final List<dynamic> slots;

  const AppointmentStoreData({
    this.appointments = const [],
    this.appointmentDetail,
    this.slots = const [],
  });

  AppointmentStoreData copyWith({
    List<dynamic>? appointments,
    dynamic appointmentDetail,
    List<dynamic>? slots,
  }) {
    return AppointmentStoreData(
      appointments: appointments ?? this.appointments,
      appointmentDetail: appointmentDetail ?? this.appointmentDetail,
      slots: slots ?? this.slots,
    );
  }
}

class AppointmentStore extends StateNotifier<AppointmentStoreData> {
  AppointmentStore() : super(const AppointmentStoreData());

  // ✅ store appointments
  void setAppointments(List<dynamic> data) {
    state = state.copyWith(appointments: data);
  }

  // ✅ store detail
  void setAppointmentDetail(dynamic data) {
    state = state.copyWith(appointmentDetail: data);
  }

  // ✅ store slots
  void setSlots(List<dynamic> data) {
    state = state.copyWith(slots: data);
  }

  // ✅ clear (optional)
  void clear() {
    state = const AppointmentStoreData();
  }
}

final appointmentStoreProvider =
    StateNotifierProvider<AppointmentStore, AppointmentStoreData>(
      (ref) => AppointmentStore(),
    );
