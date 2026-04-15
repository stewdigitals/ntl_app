import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Future<void> Function()? onPressed;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  bool get isDisabled => widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => scale = 0.97),
      onTapUp: isDisabled ? null : (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: isDisabled
          ? null
          : () async {
              await widget.onPressed!();
            },

      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),

        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDisabled ? 0.6 : 1,

          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),

              // 🌈 GRADIENT MAGIC
              gradient: LinearGradient(
                colors: isDisabled
                    ? [Colors.grey.shade400, Colors.grey.shade300]
                    : [Colors.primary, Colors.primary.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              // ✨ PREMIUM SHADOW STACK
              boxShadow: isDisabled
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.primary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: Colors.primary.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
            ),

            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: Colors.white.withValues(alpha: isDisabled ? 0.8 : 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
