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
          color: Colors.white.withValues(alpha: 50.0),
          borderRadius: BorderRadius.circular(10), // Rounded edges
        ),
        child: Row(
          children: [
            Expanded(
              flex: 85, // Take up 85% of the space
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Your Homes',
                          style: MainTheme.h1Black,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: NameBox(name: '1 Lumina Care'),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: NameBox(name: '2 Lumina Care'),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: NameBox(name: '3 Lumina Care'),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: NameBox(name: '4 Lumina Care'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 15, // Take up 15% of the space
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
