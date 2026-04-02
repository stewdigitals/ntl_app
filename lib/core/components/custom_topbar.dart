import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  final IconData? rightIcon;
  final VoidCallback? onRightTap;

  final bool showRightIcon;
  final bool showBackBg;
  final bool showRightBg;

  const CustomTopAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.rightIcon,
    this.onRightTap,
    this.showRightIcon = false,
    this.showBackBg = false,
    this.showRightBg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Row(
          children: [
            // 🔙 BACK BUTTON
            if (showBack)
              _iconWrapper(
                icon: Icons.arrow_back,
                onTap: onBack ?? () => Navigator.pop(context),
                showBg: showBackBg,
              ),

            if (showBack) const SizedBox(width: 12),

            // 📝 TITLE
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // 🔔 RIGHT ICON
            if (showRightIcon && rightIcon != null)
              _iconWrapper(
                icon: rightIcon!,
                onTap: onRightTap,
                showBg: showRightBg,
              ),
          ],
        ),
      ),
    );
  }

  Widget _iconWrapper({
    required IconData icon,
    VoidCallback? onTap,
    required bool showBg,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: showBg ? Colors.grey.shade200 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
