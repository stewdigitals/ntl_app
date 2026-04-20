// appointment_provider.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:ntl_app/features/fetchService/app_logger.dart';
import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:ntl_app/features/fetchService/fetchServiceProvider.dart';
import 'package:ntl_app/features/service/booking/state/booking_state.dart';
import 'package:ntl_app/features/service/booking/store/booking.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

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
      final res = await api.get(
        "/user/my-appointments",
        auth: true,
        query: {"page": 1, "limit": 10},
      );

      debugPrint("🔥 FULL RESPONSE:");
      debugPrint(res['data'].toString());

      debugPrint("🔥 SLOTS LIST:");
      debugPrint(res['data'].toString());

      final appointments = (res['data']['data'] as List?) ?? [];

      store.setAppointments(appointments);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint("❌ ERROR: $e");

      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchSlots(String serviceId, String date) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await api.get(
        "/user/services/$serviceId/slots",
        auth: true,
        query: {"date": date},
      );

      final slots = (res['data'] as List?) ?? [];
      store.setSlots(slots);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ✅ Fetch detail
  Future<void> fetchDetail(String id, BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    AppSnackbar.show(context, "Loading details...", type: SnackType.info);

    try {
      final res = await api.get("/user/my-appointments/$id", auth: true);

      store.setAppointmentDetail(res['data']);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ✅ Create Appointment
  Future<void> createAppointment({
    required String serviceId,
    required String jewelleryType,
    required String date,
    required String slotTime,
    required String approxWeight,
    required String description,
    required List<File> files,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final formData = FormData();

      // ✅ fields
      formData.fields.addAll([
        MapEntry("serviceId", serviceId),
        MapEntry("jewelleryType", jewelleryType),
        MapEntry("appointmentDate", date),
        MapEntry("slotTime", slotTime),
        MapEntry("approxWeight", approxWeight),
        MapEntry("description", description),
      ]);

      // 🚨 IMPORTANT: REMOVE ALL PREVIOUS FILE LOGIC FIRST

      if (files.isNotEmpty) {
        final file = files.first;

        formData.files.add(
          MapEntry(
            "image", // 👈 THIS FIXES EVERYTHING
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }

      await api.postMultipart(
        "/user/appointments",
        formData: formData,
        auth: true,
      );

      // 🔄 refresh list
      await fetchAppointments();

      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint("❌ ERROR: $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> downloadReport(String id, BuildContext context) async {
    try {
      final res = await api.get(
        "/user/my-appointments/$id/download-report",
        auth: true,
      );

      final data = res['data'];
      final url = data['reportUrl'];

      if (url == null || url.toString().isEmpty) {
        AppSnackbar.show(context, "No report found ❌", type: SnackType.error);
        return;
      }

      // 🧠 Extract extension dynamically
      final uri = Uri.parse(url);
      String fileName = uri.pathSegments.last;

      if (!fileName.contains(".")) {
        fileName = "report_$id";
      }

      // ✅ ADD THIS (permission)
      if (Platform.isAndroid) {
        PermissionStatus status;

        if (await Permission.manageExternalStorage.isGranted) {
          status = PermissionStatus.granted;
        } else {
          status = await Permission.manageExternalStorage.request();
        }

        if (!status.isGranted) {
          AppSnackbar.show(
            context,
            "Storage permission denied ❌",
            type: SnackType.error,
          );
          return;
        }
      }

      final dirPath = "/storage/emulated/0/Pictures/ntl_app";
      await Directory(dirPath).create(recursive: true);

      final filePath = "$dirPath/$fileName";

      double progress = 0;
      late void Function(void Function()) dialogSetState;

      // 🎯 Progress Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) {
            dialogSetState = setState;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.download_rounded,
                    size: 40,
                    color: Colors.primary,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Downloading File...",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),

                  LinearProgressIndicator(value: progress, minHeight: 6),

                  const SizedBox(height: 10),

                  Text("${(progress * 100).toInt()}%"),
                ],
              ),
            );
          },
        ),
      );

      final dio = Dio();

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            dialogSetState(() {
              progress = received / total;
            });
          }
        },
      );

      await MediaScanner.loadMedia(path: filePath);

      Navigator.pop(context);

      final result = await OpenFilex.open(filePath);

      if (result.type != ResultType.done) {
        AppSnackbar.show(
          context,
          "File downloaded but cannot open",
          type: SnackType.error,
        );
      } else {
        AppSnackbar.show(
          context,
          "Saved to Downloads ✅\n$fileName",
          type: SnackType.success,
        );
      }
    } catch (e) {
      Navigator.pop(context);

      AppSnackbar.show(context, "Download failed ❌", type: SnackType.error);
    }
  }

  Future<void> cancelAppointment(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await api.patch("/user/my-appointments/$id/cancel", auth: true);

      // 🔄 refresh list after cancel
      await fetchAppointments();

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
