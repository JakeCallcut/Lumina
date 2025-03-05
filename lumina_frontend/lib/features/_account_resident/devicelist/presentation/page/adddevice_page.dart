// main.dart
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import '../../domain/entities/devicelist_entiti.dart';
class AddDevicePage extends StatefulWidget {
  const AddDevicePage({Key? key}) : super(key: key);

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  String? selectedDeviceType;
  String? selectedRoom;
  final TextEditingController nameController = TextEditingController();
// currently a pre existing list of catagories is used, hence static list
// when back and front end integrated the list of available locations and types will be alterable
  final List<String> species = ['Lighting', 'Robot', 'Cleaning', 'Display', 'Vehicle','Charging'];
  final List<String> rooms = ['Lounge', 'Kitchen', 'Bathroom'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaLightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Add a Device',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Name section
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: MainTheme.luminaShadedWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Device Type section
              const Text(
                'Device Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: MainTheme.luminaShadedWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedDeviceType ?? species[0],
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: species.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDeviceType = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Room section
              const Text(
                'Room',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: MainTheme.luminaShadedWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedRoom ?? rooms[0],
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: rooms.map((String room) {
                      return DropdownMenuItem<String>(
                        value: room,
                        child: Text(room),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRoom = newValue;
                      });
                    },
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Add Device button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.check_circle_outline, color: MainTheme.luminaShadedWhite),
                  label: Text(
                    'Add Device',
                    style: TextStyle(color: MainTheme.luminaShadedWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainTheme.luminaBlue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
  // Get form values (assuming you have TextEditingController instances for your input fields)
  final deviceName = nameController.text.trim();
  final deviceSpecies = selectedDeviceType ?? 'Smart Lamp';
  final location = selectedRoom ?? 'Lounge';
  
  // Check if device name is provided
  if (deviceName.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Device name required'),
        backgroundColor: MainTheme.luminaShadedGreen,
      ),
    );
    return;
  }
  
  // Create a new device object
  final newDevice = DeviceItem(
    //Name is up to user
    name: deviceName,
    //Type picked from a list
    species: deviceSpecies,
    //Location picked from a list
    room: location,
    // Icon based on device type
    icon: Icons.radar,
    // Any new device starts as off
    activity: false, 
  );
  
  Navigator.pop(context, newDevice);
  
  //Adding new device works
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$deviceName Set Up'),
      backgroundColor: MainTheme.luminaLightGreen,
    ),
  );
},

// Helper function to determine the icon based on device type

                ),
              ),
              
              // Scan Network button
              Container(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon:  Icon(Icons.wifi, color: MainTheme.luminaShadedWhite),
                  label:  Text(
                    'Scan Network',
                    style: TextStyle(color: MainTheme.luminaShadedWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainTheme.luminaBlue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Scan network logic would go here
                  },
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
      home: const AddDevicePage(),
    );
  }
}

void main() {
  runApp(const MyApp());
}