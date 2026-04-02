import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? iconBg;
  final Gradient? iconGradient;
  final Color iconColor;

  final VoidCallback? onTap;
  final bool showArrow;
  final bool? showBorder;
  final Color? borderColor;

  final bool showIconShadow;
  final bool showCardShadow;
  final List<BoxShadow>? cardShadows;
  final List<BoxShadow>? iconShadows;

  const HorizontalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconBg,
    this.iconGradient,
    required this.iconColor,
    this.onTap,
    this.showArrow = true,
    this.showIconShadow = true,
    this.showCardShadow = true,
    this.iconShadows,
    this.cardShadows,
    this.showBorder = true,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isClickable = onTap != null;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: showBorder == true
              ? Border.all(color: borderColor ?? Colors.grey.shade300)
              : null,
          boxShadow: showCardShadow
              ? (cardShadows ??
                    [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ])
              : null,
        ),
        child: Row(
          children: [
            // 🔶 ICON BOX
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: iconGradient == null ? iconBg : null,
                gradient: iconGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: showIconShadow
                    ? (iconShadows ??
                          [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ])
                    : null,
              ),
              child: Icon(icon, color: iconColor),
            ),

            const SizedBox(width: 14),

            // 📝 TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // ➡️ ARROW (ONLY WHEN NEEDED)
            if (showArrow && isClickable)
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
