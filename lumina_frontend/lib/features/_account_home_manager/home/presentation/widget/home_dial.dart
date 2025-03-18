import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/dial_painter.dart';

class HomeDial extends StatelessWidget {
  final double value;
  final double? maxValue;
  final String? unit;

  const HomeDial(
      {super.key,
      required this.value,
      required this.maxValue,
      required this.unit});

  double get _portion {
    if (maxValue == null || maxValue == 0) {
      return 0;
    }
    return value / maxValue!;
  }

  @override
  Widget build(BuildContext context) {
    Widget valueDisplay;
    if (unit == null) {
      if (maxValue == null) {
        valueDisplay = Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.toString(),
              style: MainTheme.h1Black,
            ),
          ],
        );
      }
      else {
        valueDisplay = Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.toString(),
              style: MainTheme.h1Black,
            ),
            Text(
              "/${maxValue.toString()}",
              style: MainTheme.h2Black,
            )
          ],
        );
      }
    } else {
      valueDisplay = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: MainTheme.h1Black,
          ),
          Text(
            unit!,
            style: MainTheme.h3Black,
          )
        ],
      );
    }

    return Stack(children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: MainTheme.luminaLightGreen,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: valueDisplay),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: 100,
          width: 100,
          child: CustomPaint(
            painter: DialPainter(1, 45, MainTheme.luminaShadedGreen),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: 100,
          width: 100,
          child: CustomPaint(
            painter: DialPainter(_portion, 45, MainTheme.luminaBlue),
          ),
        ),
      ),
    ]);
  }
}
