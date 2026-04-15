import 'package:flutter/material.dart';

enum SnackType { success, error, warning, info }

class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    SnackType type = SnackType.info,
  }) {
    final config = _getConfig(type);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),

            // 🌈 gradient background
            gradient: LinearGradient(
              colors: config.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            // ✨ soft glow
            boxShadow: [
              BoxShadow(
                color: config.colors.first.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Row(
            children: [
              Icon(config.icon, color: Colors.white, size: 22),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static _SnackConfig _getConfig(SnackType type) {
    switch (type) {
      case SnackType.success:
        return _SnackConfig(
          icon: Icons.check_circle,
          colors: [Colors.green, Colors.green.shade600],
        );
      case SnackType.error:
        return _SnackConfig(
          icon: Icons.cancel,
          colors: [Colors.red, Colors.red.shade600],
        );
      case SnackType.warning:
        return _SnackConfig(
          icon: Icons.warning,
          colors: [Colors.orange, Colors.deepOrange],
        );
      default:
        return _SnackConfig(
          icon: Icons.info,
          colors: [Colors.blue, Colors.blueAccent],
        );
    }
  }
}

class _SnackConfig {
  final IconData icon;
  final List<Color> colors;

  _SnackConfig({required this.icon, required this.colors});
}
