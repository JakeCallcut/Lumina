import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class GraphBox extends StatelessWidget{
  const GraphBox({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
              child: LineChart(
              LineChartData(
                gridData: const FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    top: BorderSide(color: MainTheme.luminaBlue, width: 2),
                    left: const BorderSide(color: Colors.white, width: 2),
                    right: BorderSide(color: MainTheme.luminaBlue, width: 2),
                    bottom: const BorderSide(color: Colors.white, width: 2),
                  ),),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 0),
                      FlSpot(1, 8),
                      FlSpot(2, 2),
                      FlSpot(3, 6),
                      FlSpot(4, 5),
                      FlSpot(5, 9),
                      FlSpot(6, 3),
                      FlSpot(7, 1),
                      FlSpot(8, 6),
                      FlSpot(9, 9),
                      FlSpot(10, 10),
                    ],
                    isCurved: false,
                    shadow: Shadow(
                      color: MainTheme.luminaBlue,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                    color: MainTheme.luminaLightGreen,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ]
              ),
            ),
          ) 
        ),
      ],
    );
  }
}