import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'adddevice_page.dart';
import '../../domain/entities/devicelist_entiti.dart';

class ManageDevicesPage extends StatefulWidget {
  const ManageDevicesPage({Key? key}) : super(key: key);

  @override
  State<ManageDevicesPage> createState() => _ManageDevicesPageState();
}

class _ManageDevicesPageState extends State<ManageDevicesPage> {
  String selectedFilter = 'All Devices';
  //Static list of device types until linked with backend database
  final List<String> filterOptions = ['All Devices', 'Lighting', 'Robot', 'Cleaning', 'Display', 'Vehicle','Charging'];

  final List<DeviceItem> devices = [
    DeviceItem(name: 'Philips Iris', species:'Lighting', room: 'Kitchen', icon: Icons.desktop_windows, activity:false),
    DeviceItem(name: 'EduBot', species:'Robot', room: 'Kitchen', icon: Icons.smart_toy, activity:false),
    DeviceItem(name: 'Roomba', species:'Cleaning', room: 'Kitchen', icon: Icons.radar, activity:false),
    DeviceItem(name: 'TIM Assistant', species:'Robot', room: 'Kitchen', icon: Icons.support_agent, activity:false),
    DeviceItem(name: 'Main Light', species:'Lighting', room: 'Kitchen', icon: Icons.light, activity:false),
    DeviceItem(name: 'Samsung TV', species:'Display', room: 'Kitchen', icon: Icons.tv, activity:false),
    DeviceItem(name: 'Dassault Falcon 7X', species:'Vehicle', room: 'Kitchen', icon: Icons.airplanemode_active, activity:false),
    DeviceItem(name: 'Barbarian Mixo 2', species:'Culinary', room: 'Kitchen', icon: Icons.blender, activity:false),
  ];

void navigateToAddDevice() async {
  // Navigate to the AddDevice page and wait for a result
  final DeviceItem? newDevice = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddDevicePage()),
  );
  
  // If a new device was returned, add it to the list
  if (newDevice != null) {
    setState(() {
      devices.add(newDevice);
    });
  }
}

  @override
  Widget build(BuildContext context) {
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
                    child: Icon(
                      Icons.dashboard_customize,
                      color: MainTheme.luminaShadedWhite,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Manage Your Devices',
                    style: TextStyle(
                      fontSize: 18,
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
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: MainTheme.luminaBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(
                          devices[index].icon,
                          color: MainTheme.luminaShadedWhite,
                        ),
                        title: Text(
                          devices[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: devices[index].activity,
                              onChanged: (value) {
                                setState(() {
                                  devices[index] = DeviceItem(
                                    name: devices[index].name,
                                    species: devices[index].species,
                                    room: devices[index].species,
                                    icon: devices[index].icon,
                                    activity: value,
                                  );
                                });
                              },
                              activeColor: MainTheme.luminaShadedWhite,
                              activeTrackColor: MainTheme.luminaShadedWhite.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //Device Add button
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
                    backgroundColor: MainTheme.luminaLightGrey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: navigateToAddDevice,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Usage example:
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: MainTheme.luminaShadedWhite,
      ),
      home: const ManageDevicesPage(),
    );
  }
}

void main() {
  runApp(const MyApp());
}