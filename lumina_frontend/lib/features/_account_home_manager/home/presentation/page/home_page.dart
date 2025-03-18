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
  String? address;
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
                  address!,
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
                    HomeDial(
                      value: households.length.toDouble(),
                      maxValue: null,
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: households.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                Household household = households[index];
                return Center(  
                  child: DeviceWidget(
                    homeName: household.homeDetails["address"],
                    inviteCode: household.homeDetails["invitecode"],
                    homeUsage: 0.80,
                  ),
                );
              },
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
    address = house.topLevelHome.name;
  }
}
