import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/switch.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';
import 'package:provider/provider.dart';

class DeviceWidget extends StatefulWidget {
  final String deviceName;
  const DeviceWidget({super.key, required this.deviceName,});

  _DeviceWidgetState createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    final socket = Provider.of<Sockets>(context);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.lightbulb_outline_rounded, size: 40, color: Colors.white,),
              LuminaSwitch(
                initialValue: _isOn, // Pass the current state to the switch as the initial value
                onChanged: (value) {
                  setState(() {
                    _isOn = value; // Update the state and rebuild the widget
                    if (_isOn) {
                      socket.changeState(widget.deviceName, 1);
                    }
                    else {
                      socket.changeState(widget.deviceName, 0);
                    }
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
    );
  }
}