import 'package:flutter/material.dart';

enum CardLayoutType { horizontal, vertical }

class SelectableCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final bool isSelected;
  final VoidCallback? onTap;

  final CardLayoutType layout;

  final Color iconColor;
  final Color? iconBg;

  const SelectableCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    this.onTap,
    this.layout = CardLayoutType.horizontal,
    this.iconColor = Colors.primary,
    this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.primary.withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            layout == CardLayoutType.horizontal
                ? _horizontalLayout()
                : _verticalLayout(),

            // ✅ CHECK ICON
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                isSelected
                    ? Icons.check_circle_outline
                    : Icons.radio_button_unchecked,
                color: isSelected ? Colors.primary : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 HORIZONTAL
  Widget _horizontalLayout() {
    return Row(
      children: [
        _iconBox(),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
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
      ],
    );
  }

  // 🔹 VERTICAL
  Widget _verticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconBox(),
        const SizedBox(height: 12),

        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),

        const SizedBox(height: 6),

        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  // 🔹 ICON BOX
  Widget _iconBox() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: iconBg ?? iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}
