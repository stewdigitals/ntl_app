import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final Color bgColor;
  final Color titleColor;
  final Color subtitleColor;

  final Color iconColor;
  final Color iconBgColor;

  final Color borderColor;

  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.bgColor = Colors.white,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.grey,
    this.iconColor = Colors.black,
    this.borderColor = Colors.transparent,
    this.iconBgColor = Colors.transparent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔴 ICON BOX
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 25),
          ),

          const SizedBox(height: 10),

          // 📝 TITLE
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          // 📄 SUBTITLE
          Text(
            subtitle,
            style: TextStyle(color: subtitleColor, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );

    // 👇 OPTIONAL CLICK WRAP
    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: card,
        ),
      );
    }

    return card;
  }
}
