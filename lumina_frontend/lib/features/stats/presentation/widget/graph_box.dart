import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class GraphBox extends StatelessWidget{
  final List<FlSpot> spots;
  
  const GraphBox({super.key, required this.spots});

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
                    return FlLine(
                      color: Colors.white.withAlpha(128),
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
                    spots: spots,
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