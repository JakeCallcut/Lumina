import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/switch.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';

class DeviceWidget extends StatefulWidget {
  final String deviceName;
  final Device dv;
  const DeviceWidget({super.key, required this.deviceName, required this.dv});

  @override
  _DeviceWidgetState createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  late bool _isOn; // Initialize _isOn based on mainAction
  late StreamSubscription _socketSubscription;
  late Integration instance; // Declare instance as a class-level variable
  late homeProvider home; // Declare home as a class-level variable

  @override
  void initState() {
    super.initState();
    _isOn = widget.dv.mainAction; // Set _isOn based on the mainAction property of the Device
    instance = Integration(); // Initialize instance
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final socket = Provider.of<Sockets>(context, listen: false);
    home = Provider.of<homeProvider>(context, listen: true); // Initialize home

    // Listen to the socket stream
    _socketSubscription = socket.controller.stream.listen((data) {
      String nameDevice = data.keys.first;
      int stateDevice = data.values.first;

      if (nameDevice == widget.deviceName) {
        if (stateDevice != (_isOn ? 1 : 0)) {
          setState(() {
            _isOn = stateDevice == 1;
            widget.dv.mainAction = _isOn;
            // Keep mainAction in sync with _isOn
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
    final socket = Provider.of<Sockets>(context);
    return Container(
      height: 130,
      width: 180,
      decoration: BoxDecoration(
        color: _isOn ? MainTheme.luminaLightBlue : MainTheme.luminaBlue,
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
              const Icon(Icons.lightbulb_outline_rounded, size: 40, color: Colors.white),
              LuminaSwitch(
                initialValue: _isOn,
                onChanged: (value) {
                  setState(() {
                    _isOn = value;
                    widget.dv.mainAction = _isOn; // Update mainAction when _isOn changes
                    if (_isOn) {
                      socket.changeState(widget.deviceName, 1);
                      instance.updateDevice(widget.dv, home.houseCode.topHouseId, home.houseCode.householdId, home.curRoom.id);
                    } else {
                      socket.changeState(widget.deviceName, 0);
                      instance.updateDevice(widget.dv, home.houseCode.topHouseId, home.houseCode.householdId, home.curRoom.id);
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