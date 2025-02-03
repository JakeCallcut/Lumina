import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class GraphBox extends StatelessWidget{
  final List<FlSpot> spots;
  final Color lineColor;
  final TextStyle textStyle;
  
  const GraphBox(
    {super.key,
    required this.spots,
    required this.lineColor,
    required this.textStyle,});

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
                          style: textStyle,
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
                              style: textStyle,
                            );
                          }
                          return Text(
                            ("${value}th"),
                            style: textStyle,
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
                  border: const Border(
                    top: BorderSide(color: Colors.transparent, width: 2),
                    left: BorderSide(color: Colors.white, width: 2),
                    right: BorderSide(color: Colors.transparent, width: 2),
                    bottom: BorderSide(color: Colors.white, width: 2),
                  ),),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: false,
                    shadow: Shadow(
                      color: MainTheme.luminaBlue,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                    color: lineColor,
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