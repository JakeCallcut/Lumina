import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/switch.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';
import 'package:provider/provider.dart';

class DeviceWidget extends StatefulWidget {
  final String deviceName;
  const DeviceWidget({super.key, required this.deviceName});

  @override
  _DeviceWidgetState createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  bool _isOn = false;
  late StreamSubscription _socketSubscription;

  @override
  void initState() {
    super.initState();
    
    final socket = Provider.of<Sockets>(context, listen: false);

    // Listen to the socket stream
    _socketSubscription = socket.controller.stream.listen((data) {
      //data will be a <Map<String,int>>, so need to take the key as the device name and the value as the state
      String nameDevice = data.keys.first;
      int stateDevice = data.values.first;

      if (nameDevice == widget.deviceName) { //only updates the state if its the correct device
        if (stateDevice != (_isOn ? 1 : 0)) { //_isOn goes from bool -> int because i hate dart with a burning passion
          setState(() {
            _isOn = stateDevice == 1; //forces _isOn to have the value of stateDevice == 1, so if stateDevice is 1 (i.e device is on) then _isOn is forced into true
          });
        }
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
    final socket = Provider.of<Sockets>(context); //takes the socket generated in main
    return Container(
      height: 130,
      width: 180,
      decoration: BoxDecoration(
        color: _isOn ? MainTheme.luminaLightBlue : MainTheme.luminaBlue, //changes background colour based on state
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