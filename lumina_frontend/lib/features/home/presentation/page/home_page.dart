import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/home/presentation/widget/device_widget.dart';
import 'package:lumina_frontend/features/home/presentation/widget/home_dial.dart';
import 'package:lumina_frontend/features/home/presentation/widget/room_list.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class HomePage extends StatelessWidget {
  //Dummy values
  final String _address = "11/15 Kingfisher Street";

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Navbar(
          selectedPage: NavPage.home,
        )
      ],
    );
  }
}
