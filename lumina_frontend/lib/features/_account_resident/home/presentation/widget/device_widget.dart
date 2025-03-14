import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/switch.dart';

class DeviceWidget extends StatefulWidget {
  @override
  _DeviceWidgetState createState() => _DeviceWidgetState();
  final String deviceName;

  const DeviceWidget({super.key, required this.deviceName});
}

class _DeviceWidgetState extends State<DeviceWidget> {
  bool _isOn = false; //TODO: change this to a value from the backend, false for now

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.lightbulb_outline_rounded, size: 40, color: Colors.white,),
                LuminaSwitch(
                  initialValue: _isOn, // Pass the current state to the switch as the initial value
                  onChanged: (value) {
                    setState(() {
                      _isOn = value; // Update the state and rebuild the widget
                    });
                  },
                ),
              ],
            ),
            Text(
              widget.deviceName,
              style: MainTheme.h3White,
            ),
          ],
        ),
      ),
    );
  }
}