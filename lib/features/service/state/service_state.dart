import 'package:ntl_app/features/service/store/service.dart';

class ServicesState {
  final bool isLoading;
  final List<ServiceModel> data;
  final String? error;

  ServicesState({this.isLoading = false, this.data = const [], this.error});

  ServicesState copyWith({
    bool? isLoading,
    List<ServiceModel>? data,
    String? error,
  }) {
    return ServicesState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}
