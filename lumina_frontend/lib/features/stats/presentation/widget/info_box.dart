import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/dial_painter.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final double valueMoney;
  final double valueUnit;

  const InfoBox(
      {super.key,
      required this.title,
      required this.valueMoney,
      required this.valueUnit});
      
        @override
        Widget build(BuildContext context) {
          return Stack(children: [
            Container(
                    height: 175,
                    width: 250,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title, style: MainTheme.h2White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(valueMoney.toString(), style: MainTheme.h1White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("($valueUnit)", style: MainTheme.h2White),
                          ],
                        ),
                      ],
                    ),
                   )
          ]);
        }
}