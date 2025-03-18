import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_resident/home/presentation/widget/device_widget.dart';
import 'package:lumina_frontend/features/_account_resident/home/presentation/widget/home_dial.dart';
import 'package:lumina_frontend/features/_account_resident/home/presentation/widget/room_list.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/model/models.dart';

class ResidentHomePage extends StatefulWidget {
  const ResidentHomePage({super.key});
  @override
  _ResidentHomePageState createState() => _ResidentHomePageState();
}

class _ResidentHomePageState extends State<ResidentHomePage> {
  //Dummy values
  String? address;
  Household household = Household("", {}, {});

   @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // final home = context.watch<homeProvider>();

// 
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
                    const HomeDial(
                      value: 50,
                      maxValue: 100,
                      unit: "/hr",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Generation",
                      style: MainTheme.h4Black,
                    )
                  ],
                ),
                Column(
                  children: [
                    const HomeDial(
                      value: 40,
                      maxValue: 100,
                      unit: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Devices Connected",
                      style: MainTheme.h4Black,
                    )
                  ],
                ),
              ],
            ),
            RoomList(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DeviceWidget(deviceName: 'Phillips Iris',),
                DeviceWidget(deviceName: 'Roomba',),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DeviceWidget(deviceName: 'TIM Assistant',),
                DeviceWidget(deviceName: 'GHD Straigteners',),
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
    household = house.houseHold;
    address = house.houseHold.homeDetails["address"];
  }
}
