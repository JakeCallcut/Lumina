import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

//Dropdownlist widget structure for devicelist page

class Devicedroplist extends StatelessWidget {
  const Devicedroplist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: MainTheme.luminaLightGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButton<String>(
        value: "All Devices",
        isExpanded: true,
        underline: Container(),
        items: const [
          DropdownMenuItem(
            value: "All Devices",
            child: Text("All Devices"),
            ),
        ],
        onChanged: (String? newValue){
          //
        },
        ),
    );
  }
}