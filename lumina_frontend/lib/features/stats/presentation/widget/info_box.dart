import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final double valueMoney;
  final double valueUnit;
  final Color boxColor;
  final List<TextStyle> textStyle;

  const InfoBox(
      {super.key,
      required this.title,
      required this.valueMoney,
      required this.valueUnit,
      required this.boxColor,
      required this.textStyle,});
      
        @override
        Widget build(BuildContext context) {
          return Stack(children: [
            Container(
                    height: 175,
                    width: 250,
                    decoration: BoxDecoration(
                    color: boxColor,
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
                            Text(title, style: textStyle[1]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("\$$valueMoney", style: textStyle[0]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("($valueUnit kWh)", style: textStyle[1]),
                          ],
                        ),
                      ],
                    ),
                   )
          ]);
        }
}