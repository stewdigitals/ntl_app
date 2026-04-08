// ignore_for_file: unused_local_variable, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:stew_bin_app/features/auth/provider/auth_provider.dart';

typedef TokenProvider = Future<String?> Function();

class FetchService {
  final Dio _dio;
  final TokenProvider? _getToken;

  FetchService({required String baseUrl, TokenProvider? tokenProvider})
    : _getToken = tokenProvider,
      _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Future<dynamic> _request(
    String method,
    String path, {
    bool auth = false,
    dynamic body,
    Map<String, dynamic>? query,
    bool showSuccessToast = false,
  }) async {
    try {
      final headers = <String, String>{};

      if (auth) {
        if (_getToken == null) {
          throw Exception('Auth required but no token provider set');
        }

        final token = await _getToken();
        if (token == null || token.isEmpty) {
          throw Exception('Auth token missing');
        }
        debugPrint('🔑 TOKEN USED: $token');

        headers['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.request(
        path,
        data: body,
        queryParameters: query,
        options: Options(
          method: method,
          headers: headers.isNotEmpty ? headers : null,
        ),
      );

      final data = _handleSuccess(response);

      debugPrint('[$method] $path → RESPONSE: $data');

      return data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      debugPrint('❌ API ERROR [$method $path]');
      debugPrint('TYPE: ${e.type}');
      debugPrint('MESSAGE: ${e.message}');
      debugPrint('Status: $statusCode');
      debugPrint('Data: $data');

      if (e.type == DioExceptionType.connectionError) {
        throw ApiException(message: "Cannot connect to server");
      }

      if (statusCode == null) {
        throw ApiException(message: "No response from server");
      }

      final error = _handleError(e);
      throw error;
    }
  }

  // =========================
  // PUBLIC METHODS
  // =========================
  Future<dynamic> get(
    String path, {
    bool auth = false,
    Map<String, dynamic>? query,
  }) => _request('GET', path, auth: auth, query: query);

  Future<dynamic> post(
    String path, {
    bool auth = false,
    dynamic body,
    bool showSuccessToast = false,
  }) => _request(
    'POST',
    path,
    auth: auth,
    body: body,
    showSuccessToast: showSuccessToast,
  );

  Future<dynamic> put(
    String path, {
    bool auth = false,
    dynamic body,
    bool showSuccessToast = false,
  }) => _request(
    'PUT',
    path,
    auth: auth,
    body: body,
    showSuccessToast: showSuccessToast,
  );

  Future<dynamic> delete(
    String path, {
    bool auth = false,
    dynamic body,
    bool showSuccessToast = false,
  }) => _request(
    'DELETE',
    path,
    auth: auth,
    body: body,
    showSuccessToast: showSuccessToast,
  );

  // =========================
  // SUCCESS HANDLER
  // =========================
  dynamic _handleSuccess(Response response) {
    final status = response.statusCode ?? 0;

    if (status >= 200 && status < 300) {
      return response.data;
    }

    throw Exception('Unexpected status code: $status');
  }

  // =========================
  // ERROR HANDLER
  // =========================
  ApiException _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    String message = 'Request failed';

    if (data is Map && data['message'] != null) {
      message = data['message'].toString();
    }

    return ApiException(statusCode: statusCode, message: message);
  }
}

class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException({this.statusCode, required this.message});

  @override
  String toString() => message;
}
