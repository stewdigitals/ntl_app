import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message) {
    debugPrint("🧠 $message");
  }

  static void error(String message) {
    debugPrint("❌ $message");
  }

  static void success(String message) {
    debugPrint("✅ $message");
  }
}
