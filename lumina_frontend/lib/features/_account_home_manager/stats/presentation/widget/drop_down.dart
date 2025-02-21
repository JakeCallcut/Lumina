import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: MainTheme.luminaBlue,
        borderRadius: BorderRadius.circular(10), // Rounded edges
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Dropdown Content',
            style: MainTheme.h2White,
          ),
          // Add more content here
        ],
      ),
    );
  }
}