import 'package:flutter/material.dart';

Widget buildTitle(String title, Color color) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      const SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ],
  );
}
