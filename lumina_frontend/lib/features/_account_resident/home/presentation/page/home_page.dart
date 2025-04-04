import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_resident/home/presentation/widget/device_widget.dart';
import 'package:lumina_frontend/features/_account_resident/home/presentation/widget/home_dial.dart';
import 'package:lumina_frontend/features/_account_resident/home/presentation/widget/room_list.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/features/_account_resident/devicelist/presentation/page/devicelistpages.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';

class ResidentHomePage extends StatefulWidget {
  const ResidentHomePage({super.key});
  @override
  _ResidentHomePageState createState() => _ResidentHomePageState();
}

class _ResidentHomePageState extends State<ResidentHomePage> {
  String? address;
  Household household = Household("", {}, {});
  List<Device> devices = [];
  int usage = 0;
  late StreamSubscription _socketSubscription;

  @override
  void initState() {
    super.initState();
    getData();

    final socket = Provider.of<Sockets>(context, listen: false);
    _socketSubscription = socket.controller.stream.listen((data) {
      if (data.keys.first == "rtusage") {
        setState(() {
          usage = data.values.first;
        });
      }
    });
  }

  @override
  void dispose() {
    _socketSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final home = context.watch<homeProvider>();
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
                  address ?? '',
                  style: MainTheme.h1Black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    HomeDial(
                      value: usage.toDouble(),
                      maxValue: 1000,
                      unit: "W",
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
            Container(
              color: MainTheme.luminaShadedWhite,
              child: Consumer<homeProvider>(
                builder: (context, home, child) {
                  final home = Provider.of<homeProvider>(context, listen: true);
                  List<Device> devices = home.devices;
                  if (devices.isEmpty) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("No devices found", style: MainTheme.h4Black),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              navigateToAddDevice();
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: devices.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        Device device = devices[index];
                        return SizedBox(
                          height: 40, // Set the height of the wrapper
                          child: Center(
                            child: DeviceWidget(
                              deviceName: device.deviceName,
                              dv: device,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedPage: NavPage.home,
      ),
    );
  }

  void getData() async {
    final house = Provider.of<homeProvider>(context, listen: false);
    household = house.houseHold;
    address = house.houseHold.homeDetails["address"];
  }

  void navigateToAddDevice() async {
    // Navigate to the AddDevice page and wait for a result
    final Device newDevice = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDevicePage()),
    );

    // If a new device was returned, add it to the list
    setState(() {
      devices.add(newDevice);
    });
  }
}
