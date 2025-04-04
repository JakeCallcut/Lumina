import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/widget/graph_box.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/widget/drop_down.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/providers/providers.dart';

class ManagerStatsPage extends StatefulWidget {
  final String? name;

  ManagerStatsPage({super.key, this.name});

  @override
  // ignore: library_private_types_in_public_api
  _ManagerStatsPageState createState() => _ManagerStatsPageState();
}

class _ManagerStatsPageState extends State<ManagerStatsPage> {
  bool _isDropDownOpen = false;
  OverlayEntry? _overlayEntry;
  var instance = Integration();
  String? _name;

  void initState() {
    super.initState();
    final house = Provider.of<homeProvider>(context, listen: false);
    _name = widget.name ?? house.houseHolds[0].homeDetails["address"];
  }

  OverlayEntry _createOverlayEntry(String tlhID) {
    return OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => _toggleDropDown(tlhID),
                child: Container(
                  color: Colors.black54, // Semi-transparent background
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                      20.0), // Adjust the padding as needed
                  child: Stack(
                    children: [
                      DropDown(
                          onToggleDropDown: () => _toggleDropDown(tlhID),
                          tlhID: tlhID),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_drop_up,
                              size: 40, color: Colors.black),
                          onPressed: () => _toggleDropDown(tlhID),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropDown(String tlhID) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(tlhID);
      Overlay.of(context).insert(_overlayEntry!);
      if (mounted) {
        setState(() {
          _isDropDownOpen = true;
        });
      }
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() {
          _isDropDownOpen = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final house = Provider.of<homeProvider>(context, listen: false);
    
    final List<FlSpot> energyUsage = [
      FlSpot(1, Random().nextDouble() * 2.5),
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

    return FutureBuilder<TopLevelHome>(
      future: Future.value(house.topLevelHome),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No top level homes found.'));
        } else {
          return Scaffold(
            body: Stack(children: [
              SingleChildScrollView(
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
                          _name ?? '',
                          style: MainTheme.h1Black,
                        ),
                        const Spacer(),
                        if (!_isDropDownOpen)
                          IconButton(
                            icon: const Icon(Icons.arrow_drop_down,
                                size: 40, color: Colors.black),
                            onPressed: () => _toggleDropDown(house.topLevelHome.id),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
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
                                borderRadius:
                                    BorderRadius.circular(10), // Rounded edges
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
                                borderRadius:
                                    BorderRadius.circular(10), // Rounded edges
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
              if (_isDropDownOpen)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
            ]),
            bottomNavigationBar: Navbar(
              selectedPage: NavPage.stats,
              isBlurred: _isDropDownOpen,
            ),
          );
        }
      },
    );
  }
}
