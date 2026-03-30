import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
// import 'package:stew_bin_app/features/auth/provider/auth_provider.dart';

// final fetchServiceProvider = Provider<FetchService>((ref) {
//   return FetchService(
//     baseUrl: 'https://smg-server.vercel.app/api/v1',
//     tokenProvider: () async {
//       return await TokenStorage.getToken();
//     },
//   );
// });

class PriceService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.metals.live/v1"));
  Future<Map<String, double>> getPrices() async {
    try {
      final response = await _dio.get(
        "https://api.coingecko.com/api/v3/simple/price",
        queryParameters: {"ids": "gold,silver", "vs_currencies": "inr"},
      );

      debugPrint("API: ${response.data}");

      final data = response.data;

      final gold = (data["gold"]["inr"] as num).toDouble();
      final silver = (data["silver"]["inr"] as num).toDouble();

      return {"gold": gold, "silver": silver};
    } catch (e) {
      print("ERROR: $e");
      throw Exception("Failed to fetch prices");
    }
  }
}
