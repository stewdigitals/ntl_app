// ignore_for_file: avoid_print, file_names

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:shared_preferences/shared_preferences.dart';

final fetchServiceProvider = Provider<FetchService>((ref) {
  return FetchService(
    baseUrl: 'https://ngstl-server.vercel.app/api/v1',
    tokenProvider: () async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      debugPrint("📦 FETCHED TOKEN: $token");

      return token;
    },
  );
});
