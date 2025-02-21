import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class DeviceWidget extends StatefulWidget {
  @override
  _DeviceWidgetState createState() => _DeviceWidgetState();
  final String homeName;
  final double homeUsage;

  const DeviceWidget({super.key,
                    required this.homeName,
                    required this.homeUsage});
}

class _DeviceWidgetState extends State<DeviceWidget> {
  bool _isOn = false; //TODO: change this to a value from the backend, false for now

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 180,
      decoration: BoxDecoration(
        color: _isOn ? MainTheme.luminaLightBlue : MainTheme.luminaBlue, //chage bg color based on state
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
      ),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.homeName,
            style: MainTheme.h3White,
          ),
          Text(
            widget.homeUsage.toString(),
            style: MainTheme.h3White,
          ),
        ],
      ),
    );
  }
}