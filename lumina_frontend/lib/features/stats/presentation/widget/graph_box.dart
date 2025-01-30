import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class GraphBox extends StatelessWidget{
  const GraphBox({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 268,
          width: 500,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(1, 1),
                    FlSpot(2, 2),
                    FlSpot(3, 3),
                    FlSpot(4, 4),
                    FlSpot(5, 5),
                    FlSpot(6, 6),
                    FlSpot(7, 7),
                    FlSpot(8, 8),
                    FlSpot(9, 9),
                    FlSpot(10, 10),
                  ],
                  isCurved: true,
                  color: MainTheme.luminaBlue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }
}