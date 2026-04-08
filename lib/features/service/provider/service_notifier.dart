import 'package:flutter_riverpod/legacy.dart';
import 'package:ntl_app/features/fetchService/fetchServiceProvider.dart';
import 'package:ntl_app/features/service/provider/service_provider.dart';
import 'package:ntl_app/features/service/state/service_state.dart';

final servicesProvider = StateNotifierProvider<ServicesNotifier, ServicesState>(
  (ref) {
    final api = ref.read(fetchServiceProvider);
    final store = ServicesStore(api);
    return ServicesNotifier(store);
  },
);

class ServicesNotifier extends StateNotifier<ServicesState> {
  final ServicesStore _store;

  ServicesNotifier(this._store) : super(ServicesState());

  Future<void> fetchServices() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await _store.fetchServices();

      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
