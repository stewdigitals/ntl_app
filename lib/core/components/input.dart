import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  // Styling controls
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;

  final bool showLabel;
  final EdgeInsetsGeometry? labelPadding;

  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? fillColor;

  final Widget? suffix;
  final Widget? prefix;

  const CustomInputField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,

    this.width,
    this.height,
    this.padding,
    this.contentPadding,

    this.showLabel = true,
    this.labelPadding,

    this.borderRadius,
    this.borderColor,
    this.fillColor,

    this.suffix,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      borderSide: BorderSide(
        color: borderColor ?? Colors.red.shade200,
        width: 1,
      ),
    );

    return Container(
      width: width ?? double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel && label != null)
            Padding(
              padding: labelPadding ?? const EdgeInsets.only(bottom: 6),
              child: Text(
                label!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),

          SizedBox(
            height: height,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              enabled: enabled,
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.white,

                contentPadding:
                    contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

                border: border,
                enabledBorder: border,
                focusedBorder: border,

                suffixIcon: suffix,
                prefixIcon: prefix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
