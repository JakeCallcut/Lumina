import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/model/models.dart';
import 'adddevice_page.dart';
import 'variablelight_page.dart';
import 'devicefunctions_page.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/core/utils/switch.dart';

class ManageDevicesPage extends StatefulWidget {
  const ManageDevicesPage({Key? key}) : super(key: key);

  @override
  State<ManageDevicesPage> createState() => _ManageDevicesPageState();
}

class _ManageDevicesPageState extends State<ManageDevicesPage> {
  late Integration instance;
  String selectedFilter = 'All Devices';
  final List<String> filterOptions = [
    'All Devices',
    'Lighting',
    'Robot',
    'Cleaning',
    'Display',
    'Vehicle',
    'Charging'
  ];
  HashMap<Room, List<Device>> devices = HashMap<Room, List<Device>>();
  List<Device> allDevices = [];

  @override
  void initState() {
    super.initState(); // Initialize instance
  }

  @override
  Widget build(BuildContext context) {
    instance = Integration();
    final home = Provider.of<homeProvider>(context);
    devices = home.allDevices;
    allDevices = devices.values.expand((deviceList) => deviceList).toList();
    String? roomId;

    return Scaffold(
      backgroundColor: MainTheme.luminaShadedWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header with logo and title
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MainTheme.luminaBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("assets/images/logo64.png"),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Manage Your Devices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Filter dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: MainTheme.luminaLightGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: filterOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedFilter = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Device list
              Expanded(
                child: ListView.builder(
                  itemCount: allDevices.length,
                  itemBuilder: (context, index) {
                    devices.forEach((room, deviceList) {
                      if (deviceList.contains(allDevices[index])) {
                        roomId = room
                            .id; // Assuming `room.id` is the unique identifier for the room
                      }
                    });
                    // Only show devices matching the filter
                    if (selectedFilter != 'All Devices' &&
                        allDevices[index].typeName != selectedFilter) {
                      return const SizedBox.shrink(); // Skip this device
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: MainTheme.luminaBlue,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () =>
                              navigateToDeviceControlPage(allDevices[index]),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                // Device icon
                                Icon(
                                  Icons.lightbulb,
                                  color: MainTheme.luminaShadedWhite,
                                ),
                                const SizedBox(width: 16),
                                // Device name
                                Expanded(
                                  child: Text(
                                    allDevices[index].deviceName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Switch (wrapped in GestureDetector to prevent navigation)
                                GestureDetector(
                                  onTap: () {},
                                  behavior: HitTestBehavior.opaque,
                                  child: LuminaSwitch(
                                    initialValue: allDevices[index].mainAction,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          allDevices[index].mainAction = value;

                                          // Find the room containing the device
                                          devices.forEach((room, deviceList) {
                                            if (deviceList
                                                .contains(allDevices[index])) {
                                              roomId = room
                                                  .id; // Assuming `room.id` is the unique identifier for the room
                                            }
                                          });

                                          // Update the device using the Integration instance
                                          instance.updateDevice(
                                            allDevices[index],
                                            home.houseCode.topHouseId,
                                            home.houseCode.householdId,
                                            roomId, // Pass the room ID
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Device Add button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, color: Colors.black54),
                  label: const Text(
                    'Add device',
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainTheme.luminaLightGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    home.setRoomID(roomId);
                    navigateToAddDevice();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedPage: NavPage.devices,
      ),
    );
  }

  void navigateToAddDevice() async {
    Device? newDevice = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDevicePage()),
    );

    if (newDevice != null) {
    setState(() {; // Add the new device to the list
      devices = Provider.of<homeProvider>(context, listen: false).allDevices;
    });
  }
  }

  void navigateToDeviceControlPage(Device device) async {
    if (device.typeName == 'Lighting') {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VariableLightPage(device: device),
        ),
      );

      if (result != null && result is Map && result['action'] == 'delete') {
        String deviceIdToDelete = result['deviceId'];
        setState(() {
          allDevices.removeWhere((d) => d.deviceName == deviceIdToDelete);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$deviceIdToDelete has been deleted'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeviceFunctionsPage(device: device),
        ),
      );

      if (result != null && result is Map) {
        if (result['action'] == 'delete') {
          String deviceIdToDelete = result['deviceId'];
          setState(() {
            allDevices.removeWhere((d) => d.deviceName == deviceIdToDelete);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$deviceIdToDelete has been deleted'),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (result['action'] == 'update' && result['device'] != null) {
          Device updatedDevice = result['device'];
          setState(() {
            final int index =
                allDevices.indexWhere((d) => d.deviceName == device.deviceName);
            if (index != -1) {
              allDevices[index] = updatedDevice;
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${updatedDevice.deviceName} has been updated'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }
}
