import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';


class DeviceListTile extends StatelessWidget{
  final DeviceItem device;
  const DeviceListTile({
    required this.device,
    Key? key,
  }) : super( key: key);

@override
Widget build(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: MainTheme.luminaLightGrey,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.asset("assets/images/logo64.png"),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              device.name,
              style: const TextStyle(color: MainTheme.luminaRed,
              fontSize: 16,
              ),
            ),
          ),
          Switch(
            value : true,
            onChanged: (bool value){

            },
          ),
          Button(
            Image.asset("assets/images/logo64.png")
            onPressed: (){

            },
          ),
        ],
      ),
    ),
  );
}
}