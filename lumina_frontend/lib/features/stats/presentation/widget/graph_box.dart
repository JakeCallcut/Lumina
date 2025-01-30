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
                minX: 1,
                maxX: 31,
                minY: 0,
                maxY: 2.5,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  verticalInterval: 7,
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: Colors.white,
                      strokeWidth: 2,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: MainTheme.h2White,
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value == 21) {
                            return Text(
                              ("${value}st"),
                              style: MainTheme.h2White,
                            );
                          }
                          return Text(
                            ("${value}th"),
                            style: MainTheme.h2White,
                          );
                        },
                        reservedSize: 30,
                        interval: 7,
                        maxIncluded: false,
                        minIncluded: false,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
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
                      FlSpot(1, 0.1),
                      FlSpot(2, 0.2),
                      FlSpot(3, 0.3),
                      FlSpot(4, 0.4),
                      FlSpot(5, 0.5),
                      FlSpot(6, 0.6),
                      FlSpot(7, 0.75),
                      FlSpot(8, 0.8),
                      FlSpot(9, 0.85),
                      FlSpot(10, 0.9),
                      FlSpot(11, 0.75),
                      FlSpot(12, 0.8),
                      FlSpot(13, 0.85),
                      FlSpot(14, 0.9),
                      FlSpot(15, 0.95),
                      FlSpot(16, 0.5),
                      FlSpot(17, 0.6),
                      FlSpot(18, 0.7),
                      FlSpot(19, 1.25),
                      FlSpot(20, 1.2),
                      FlSpot(21, 1),
                      FlSpot(22, 1.1),
                      FlSpot(23, 1.2),
                      FlSpot(24, 1.3),
                      FlSpot(25, 1.4),
                      FlSpot(26, 1.35),
                      FlSpot(27, 1.25),
                      FlSpot(28, 1.3),
                      FlSpot(29, 0.75),
                      FlSpot(30, 0.85),
                      FlSpot(31, 1),
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