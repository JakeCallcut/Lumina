import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/stats/presentation/widget/graph_box.dart';
import 'package:lumina_frontend/features/stats/presentation/widget/info_box.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> energyUsage = [
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
    ];

    final List<FlSpot> energyGeneration = [
      FlSpot(1, 0.1),
      FlSpot(2, 0.3),
      FlSpot(3, 0.4),
      FlSpot(4, 0.2),
      FlSpot(5, 0.5),
      FlSpot(6, 0.6),
      FlSpot(7, 0.9),
      FlSpot(8, 0.9),
      FlSpot(9, 1.3),
      FlSpot(10, 1.2),
      FlSpot(11, 1.5),
      FlSpot(12, 0.9),
      FlSpot(13, 0.8),
      FlSpot(14, 0.8),
      FlSpot(15, 0.9),
      FlSpot(16, 0.7),
      FlSpot(17, 0.6),
      FlSpot(18, 1.2),
      FlSpot(19, 0.3),
      FlSpot(20, 0.4),
      FlSpot(21, 0.4),
      FlSpot(22, 0.6),
      FlSpot(23, 0.3),
      FlSpot(24, 1.2),
      FlSpot(25, 0.9),
      FlSpot(26, 0.8),
      FlSpot(27, 0.8),
      FlSpot(28, 0.6),
      FlSpot(29, 0.5),
      FlSpot(30, 0.4),
      FlSpot(31, 0.4),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Stats")
      //   ),
        body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/logo64.png"),
                ),
                Text(
                  "Usage and stats",
                  style: MainTheme.h1Black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Today",
                    style: MainTheme.h1Black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(padding: EdgeInsets.all(16.0)),
                Expanded(
                  child: Column(
                    children: [
                      InfoBox(
                      title: "You've used",
                      valueMoney: 2.67,
                      valueUnit: 4.7,
                      boxColor: MainTheme.luminaBlue,
                      textStyle: [MainTheme.h1White, MainTheme.h2White],
                      ),
                    ]
                  ) 
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      InfoBox(
                        title: "You've saved",
                        valueMoney: 0.89,
                        valueUnit: 2.14,
                        boxColor: MainTheme.luminaLightGreen,
                        textStyle: [MainTheme.h1Black, MainTheme.h2Black],
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(16.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Energy Usage (kWh)",
                    style: MainTheme.h2Black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
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
                      child: GraphBox(
                        spots: energyUsage,
                        lineColor: MainTheme.luminaLightGreen,
                        textStyle: MainTheme.h2White,
                        borderColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Energy Generation (kWh)",
                    style: MainTheme.h2Black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: MainTheme.luminaLightGreen,
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
                      child: GraphBox(
                        spots: energyGeneration,
                        lineColor: MainTheme.luminaBlue,
                        textStyle: MainTheme.h2Black,
                        borderColor: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
          ),
        ),
        bottomNavigationBar: Navbar(
        selectedPage: NavPage.stats,
      ),
    );
  }
}