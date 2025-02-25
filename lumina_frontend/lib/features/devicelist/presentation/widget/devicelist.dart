import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/devicelist/presentation/widget/devicelisttile.dart';

class Devicelist extends StatelessWidget {
  //final List<DeviceItem> devices = [
  //  DeviceItem( name: "LogoStandIn", Image.asset("assets/images/logo64.png"))
  //];
  Devicelist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: DeviceListTile(),
        );
      },
    );
  }
}
