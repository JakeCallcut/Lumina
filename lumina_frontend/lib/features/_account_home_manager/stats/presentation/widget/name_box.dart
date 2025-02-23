import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class NameBox extends StatelessWidget {
  final String name;

  const NameBox({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Rounded edges
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        name,
        style: MainTheme.h1Black,

      ),
    );
  }
}