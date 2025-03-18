import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/home/presentation/widget/device_widget.dart';
import 'package:lumina_frontend/features/_account_home_manager/home/presentation/widget/home_dial.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/providers/providers.dart';
import 'package:lumina_frontend/model/models.dart';


class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  final String _address = "Lumina Care";
  List<Household> households = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  _address,
                  style: MainTheme.h1Black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const HomeDial(
                      value: 70,
                      maxValue: 100,
                      unit: "kWh",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Usage",
                      style: MainTheme.h4Black,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const HomeDial(
                      value: 12,
                      maxValue: 30,
                      unit: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Homes Connected",
                      style: MainTheme.h4Black,
                    )
                  ],
                ),
              ],
            ),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DeviceWidget(
                        homeName: '1 Lumina Care',
                        homeUsage: 0.40,
                      ),
                      DeviceWidget(
                        homeName: '2 Lumina Care',
                        homeUsage: 0.80,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DeviceWidget(
                        homeName: '3 Lumina Care',
                        homeUsage: 0.76,
                      ),
                      DeviceWidget(
                        homeName: '4 Lumina Care',
                        homeUsage: 0.60,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DeviceWidget(
                        homeName: '5 Lumina Care',
                        homeUsage: 0.76,
                      ),
                      DeviceWidget(
                        homeName: '6 Lumina Care',
                        homeUsage: 0.60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedPage: NavPage.home,
      ),
    );
  }
  void getData() async{
    final house = Provider.of<homeProvider>(context, listen: false);
    households = house.houseHolds;
    print("Energy Usage: ${house.energyUsage[0].householdId}");
  }
}
