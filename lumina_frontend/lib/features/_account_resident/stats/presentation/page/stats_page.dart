import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_resident/stats/presentation/widget/graph_box.dart';
import 'package:lumina_frontend/features/_account_resident/stats/presentation/widget/info_box.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

import 'package:lumina_frontend/services/integration_Funcs.dart';

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:lumina_frontend/model/models.dart' as models;

class ResidentStatsPage extends StatelessWidget {
  const ResidentStatsPage({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    final usageValues = generateUsageValues();
    final generationValues = generateGenerationValues();

    final results = await Future.wait([usageValues, generationValues]);

    return {
      'usage': results[0],
      'generation': results[1],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            final usageData = snapshot.data!['usage'];
            final generationData = snapshot.data!['generation'];

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                              valueMoney: usageData['mostRecentValue'] * 0.27,
                              valueUnit: usageData['mostRecentValue'],
                              boxColor: MainTheme.luminaBlue,
                              textStyle: [MainTheme.h1White, MainTheme.h2White],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            InfoBox(
                              title: "You've saved",
                              valueMoney: generationData['mostRecentValue'] * 0.27,
                              valueUnit: generationData['mostRecentValue'],
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
                              spots: usageData['points'],
                              lineColor: MainTheme.luminaLightGreen,
                              textStyle: MainTheme.h2White,
                              borderColor: Colors.white,
                              minY: usageData['minY'],
                              maxY: usageData['maxY'],
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
                              spots: generationData['points'],
                              lineColor: MainTheme.luminaBlue,
                              textStyle: MainTheme.h2Black,
                              borderColor: Colors.black,
                              minY: generationData['minY'],
                              maxY: generationData['maxY'],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Navbar(
        selectedPage: NavPage.stats,
      ),
    );
  }

  Future<Map<String, dynamic>> generateUsageValues() async {
    var instance = Integration();

    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    String loginId = user!.uid;
    models.User user_db = await instance.getUserByLogin(loginId);
    models.HouseCode house_db = await instance.getHouseCodeById(user_db.houseCodeId);
    models.EnergyUsage energy_db = await instance.getEnergyUsageByHouseId(house_db.householdId);

    Map<String, dynamic> energyUsage = energy_db.monthEnergyOut;
    List<FlSpot> points = energyUsage.entries.map((entry) {
      return FlSpot(double.parse(entry.key), (entry.value as num).toDouble());
    }).toList();

    double minY = points.map((point) => point.y).reduce((a, b) => a < b ? a : b);
    double maxY = points.map((point) => point.y).reduce((a, b) => a > b ? a : b);
    double mostRecentValue = points.isNotEmpty ? points.last.y : 0;

    return {'points': points, 'minY': minY, 'maxY': maxY, 'mostRecentValue': mostRecentValue};
  }

  Future<Map<String, dynamic>> generateGenerationValues() async {
    var instance = Integration();

    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    String loginId = user!.uid;
    models.User user_db = await instance.getUserByLogin(loginId);
    models.HouseCode house_db = await instance.getHouseCodeById(user_db.houseCodeId);
    models.EnergyUsage energy_db = await instance.getEnergyUsageByHouseId(house_db.householdId);

    Map<String, dynamic> energyUsage = energy_db.monthEnergyIn;
    List<FlSpot> points = energyUsage.entries.map((entry) {
      return FlSpot(double.parse(entry.key), (entry.value as num).toDouble());
    }).toList();

    double minY = points.map((point) => point.y).reduce((a, b) => a < b ? a : b);
    double maxY = points.map((point) => point.y).reduce((a, b) => a > b ? a : b);
    double mostRecentValue = points.isNotEmpty ? points.last.y : 0;

    return {'points': points, 'minY': minY, 'maxY': maxY, 'mostRecentValue': mostRecentValue};
  }
}