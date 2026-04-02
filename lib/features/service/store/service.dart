import 'package:flutter/material.dart';

class TagItem {
  final String text;
  final Color textColor;
  final Color color;
  final Color borderColor;

  const TagItem({
    required this.text,
    required this.textColor,
    required this.color,
    required this.borderColor,
  });
}

class BenefitItem {
  final IconData icon;
  final String title;
  final String desc;

  const BenefitItem({
    required this.icon,
    required this.title,
    required this.desc,
  });
}

class StepItem {
  final String title;
  final String desc;

  const StepItem({required this.title, required this.desc});
}

class AnalysisItem {
  final String name;
  final double value;
  final Color color;

  const AnalysisItem({
    required this.name,
    required this.value,
    required this.color,
  });
}
