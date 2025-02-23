import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/widget/name_box.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: Container(
        padding: const EdgeInsets.all(36.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 50.0), // White color
          borderRadius: BorderRadius.circular(10), // Rounded edges        ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your Homes',
                    style: MainTheme.h1Black,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: NameBox(name: '1 Lumina Care'),
            ),
            // Add more content here
          ],
        ),
      ),
    );
  }
}
