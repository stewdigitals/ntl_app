// appointment_provider.dart

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:ntl_app/features/fetchService/fetchServiceProvider.dart';
import 'package:ntl_app/features/service/booking/state/booking_state.dart';
import 'package:ntl_app/features/service/booking/store/booking.dart';

final appointmentControllerProvider =
    StateNotifierProvider<AppointmentController, AppointmentState>((ref) {
      final api = ref.read(fetchServiceProvider);
      final store = ref.read(appointmentStoreProvider.notifier);

      return AppointmentController(api, store);
    });

class AppointmentController extends StateNotifier<AppointmentState> {
  final FetchService api;
  final AppointmentStore store;

  AppointmentController(this.api, this.store)
    : super(AppointmentState.initial());

  Future<void> fetchAppointments() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await api.get("/user/my-appointments", auth: true);

      debugPrint("🔥 FULL RESPONSE:");
      debugPrint(res);

      debugPrint("🔥 SLOTS LIST:");
      debugPrint(res['data'].toString());

      store.setAppointments(res['data'] ?? []);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint("❌ ERROR: $e");

      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ✅ Fetch slots
  Future<void> fetchSlots(String serviceId, String date) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await api.get(
        "/user/services/$serviceId/slots",
        auth: true,
        query: {"date": date},
      );

      store.setSlots(res['data'] ?? []);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ✅ Fetch detail
  Future<void> fetchDetail(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await api.get("/user/my-appointments/$id", auth: true);

      store.setAppointmentDetail(res['data']);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ✅ Create Appointment
  Future<void> createAppointment(Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await api.post("/user/appointments", auth: true, body: body);

      // optional: refresh list after create
      // store.setAppointments([...]);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
