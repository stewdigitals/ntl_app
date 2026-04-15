import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ComingSoonBadge extends StatelessWidget {
  final String text;

  final Color backgroundColor;
  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Color textColor;

  final double fontSize;
  final FontWeight fontWeight;

  final EdgeInsets padding;
  final double borderRadius;

  final bool enableShimmer;

  const ComingSoonBadge({
    super.key,

    // 📝 Text
    this.text = "Coming Soon",

    // 🎨 Colors
    this.backgroundColor = const Color(0xFFFFF6DB),
    this.baseShimmerColor = const Color(0xFFD4AF35),
    this.highlightShimmerColor = const Color(0xFFFFF2C2),
    this.textColor = Colors.black,

    // 🔤 Typography
    this.fontSize = 11,
    this.fontWeight = FontWeight.w600,

    // 📦 Layout
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.borderRadius = 20,

    // ✨ Effects
    this.enableShimmer = true,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: enableShimmer
          ? Shimmer.fromColors(
              baseColor: baseShimmerColor,
              highlightColor: highlightShimmerColor,
              child: textWidget,
            )
          : textWidget,
    );
  }
}
