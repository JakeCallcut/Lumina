import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphBox extends StatelessWidget{
  final List<FlSpot> spots;
  final Color lineColor;
  final Color borderColor;
  final TextStyle textStyle;
  final double minY;
  final double maxY;
  
  const GraphBox(
    {super.key,
    required this.spots,
    required this.lineColor,
    required this.textStyle,
    required this.minY,
    required this.maxY,
    required this.borderColor,});

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
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  verticalInterval: 7,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: borderColor.withAlpha(64),
                      strokeWidth: 2,
                      dashArray: [5,5],
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
                      reservedSize: 40,
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
                  border: Border(
                    top: const BorderSide(color: Colors.transparent, width: 2),
                    left: BorderSide(color: borderColor, width: 2),
                    right:  const BorderSide(color: Colors.transparent, width: 2),
                    bottom: BorderSide(color: borderColor, width: 2),
                  ),),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: false,
                    shadow: Shadow(
                      color: borderColor.withAlpha(64),
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