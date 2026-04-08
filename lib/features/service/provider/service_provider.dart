import 'package:ntl_app/features/fetchService/fetchService.dart';
import 'package:ntl_app/features/service/store/service.dart';

class ServicesStore {
  final FetchService _api;

  ServicesStore(this._api);

  Future<List<ServiceModel>> fetchServices() async {
    final res = await _api.get('/services', auth: true);

    final list = res['data']['data'] as List;

    return list
        .map((e) => ServiceModel.fromJson(e))
        .take(4) // ✅ LIMIT HERE
        .toList();
  }
}
