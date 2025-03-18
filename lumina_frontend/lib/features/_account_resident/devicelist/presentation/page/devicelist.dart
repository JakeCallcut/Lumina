import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
//
import 'adddevice_page.dart';
import '../../domain/entities/devicelist_entiti.dart';
//
import 'variablelight_page.dart';
import 'devicefunctions_page.dart';
//
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';


class ManageDevicesPage extends StatefulWidget {
  const ManageDevicesPage({Key? key}) : super(key: key);

  @override
  State<ManageDevicesPage> createState() => _ManageDevicesPageState();
}

class _ManageDevicesPageState extends State<ManageDevicesPage> {
  String selectedFilter = 'All Devices';
  //Static list of device types until linked with backend database
  final List<String> filterOptions = ['All Devices', 'Lighting', 'Robot', 'Cleaning', 'Display', 'Vehicle','Charging'];

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
  
  // Navigate to the appropriate page based on device type
  void navigateToDeviceControlPage(DeviceItem device) async {
    if (device.species == 'Lighting') {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VariableLightPage(device: device),
        ),
      );
      
      // Handle the result from the VariableLightPage
      if (result != null && result is Map && result['action'] == 'delete') {
        String deviceIdToDelete = result['deviceId'];
        setState(() {
          devices.removeWhere((d) => d.name == deviceIdToDelete);
        });
        
        // Show a snackbar to confirm deletion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$deviceIdToDelete has been deleted'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } 
    else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeviceFunctionsPage(device: device),
        ),
      );
      
      // Handle deletion result if it comes from other device pages
      if (result != null && result is Map) {
        if (result['action'] == 'delete') {
          String deviceIdToDelete = result['deviceId'];
          setState(() {
            devices.removeWhere((d) => d.name == deviceIdToDelete);
          });
          
          // Show a snackbar to confirm deletion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$deviceIdToDelete has been deleted'),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (result['action'] == 'update' && result['device'] != null) {
          // Handle device update
          DeviceItem updatedDevice = result['device'];
          setState(() {
            // Find device by its original name and update it
            final int index = devices.indexWhere((d) => d.name == device.name);
            if (index != -1) {
              devices[index] = updatedDevice;
            }
          });
          
          // Show a snackbar to confirm update
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${updatedDevice.name} has been updated'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
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
                    child: Image.asset("assets/images/logo64.png"),
                  ),
                  const SizedBox(width: 12),
                  Text(
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
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    // Only show devices matching the filter
                    if (selectedFilter != 'All Devices' && 
                        devices[index].species != selectedFilter) {
                      return SizedBox.shrink(); // Skip this device
                    }
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: MainTheme.luminaBlue,
                        borderRadius: BorderRadius.circular(8),
                        // Make entire row clickable but exclude the switch
                        child: InkWell(
                          onTap: () => navigateToDeviceControlPage(devices[index]),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                // Device icon
                                Icon(
                                  devices[index].icon,
                                  color: MainTheme.luminaShadedWhite,
                                ),
                                const SizedBox(width: 16),
                                // Device name
                                Expanded(
                                  child: Text(
                                    devices[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Switch (wrapped in GestureDetector to prevent navigation)
                                GestureDetector(
                                  onTap: () {
                                    // Just handle the tap here without parameters
                                  },
                                  behavior: HitTestBehavior.opaque, // Block taps from reaching widgets below
                                  child: Switch(
                                    value: devices[index].activity,
                                    onChanged: (value) {
                                      setState(() {
                                        devices[index] = DeviceItem(
                                          deviceID: devices[index].deviceID,
                                          name: devices[index].name,
                                          species: devices[index].species,
                                          room: devices[index].room,
                                          lowerHome: devices[index].lowerHome,
                                          higherHome: devices[index].higherHome,
                                          icon: devices[index].icon,
                                          activity: value,
                                          subactivities: {},
                                        );
                                      });
                                    },
                                    activeColor: MainTheme.luminaWhite,
                                    activeTrackColor: MainTheme.luminaLightGreen,
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
                    backgroundColor: MainTheme.luminaLightGreen,
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
      bottomNavigationBar: Navbar(
      selectedPage: NavPage.devices,
      ),
    );
  }
}