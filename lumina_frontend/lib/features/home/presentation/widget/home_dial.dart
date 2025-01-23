import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class HomeDial extends StatelessWidget {

  final double value;
  final double maxValue;

  const HomeDial({super.key, required this.value, required this.maxValue});

  double get _portion => value! / maxValue!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: MainTheme.luminaLightGreen,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.toString(),
              style: MainTheme.h1,
            ),
            Text(
              "/${maxValue.toString()}",
              style: MainTheme.h2,
            )
          ],
        ),
      ),
    );
  }
}