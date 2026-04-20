import 'package:flutter/material.dart';

class MenuItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final VoidCallback onTap;

  MenuItemData(this.title, this.subtitle, this.icon, this.iconBg, this.onTap);
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });
}
