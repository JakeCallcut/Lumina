import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import '../../domain/entities/devicelist_entiti.dart';
import 'editdevice_page.dart';
//
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/routes.dart';

class DeviceFunctionsPage extends StatefulWidget {
  final Device device;

  const DeviceFunctionsPage({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceFunctionsPage> createState() => _DeviceFunctionsPageState();
}

class _DeviceFunctionsPageState extends State<DeviceFunctionsPage> {
  // List to store device functions
  List<DeviceFunction> functions = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some default functions based on device type
    initializeFunctions();
  }

  void initializeFunctions() {
    // Add default functions based on device type
    if (widget.device.typeName == 'Cleaning') {
      functions.add(DeviceFunction(name: '40 Minute Clean', isEnabled: false));
      functions.add(DeviceFunction(name: '60 Repetitions', isEnabled: false));
      functions.add(DeviceFunction(name: '40 Minute Clean', isEnabled: false));
      functions.add(DeviceFunction(name: '60 Repetitions', isEnabled: false));
      functions.add(DeviceFunction(name: 'Main', isEnabled: false));
    } else if (widget.device.typeName == 'Robot') {
      functions.add(DeviceFunction(name: 'Assist Mode', isEnabled: false));
      functions.add(DeviceFunction(name: 'Navigate', isEnabled: false));
      functions.add(DeviceFunction(name: 'Learning Mode', isEnabled: false));
    } else {
      // Default functions for other device types
      functions.add(DeviceFunction(name: 'Main', isEnabled: false));
      functions.add(DeviceFunction(name: 'Secondary', isEnabled: false));
    }
  }

  void _showDeleteFunctionDialog(BuildContext context, int functionIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Function'),
          content: Text('Are you sure you want to delete "${functions[functionIndex].name}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Delete the function
                setState(() {
                  functions.removeAt(functionIndex);
                });
                Navigator.of(context).pop(); // Close the dialog
                
                // Show a confirmation snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Function deleted'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _addNewFunction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newFunctionName = '';
        
        return AlertDialog(
          title: const Text('Add New Function'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Function Name',
              hintText: 'Enter function name'
            ),
            onChanged: (value) {
              newFunctionName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newFunctionName.isNotEmpty) {
                  setState(() {
                    functions.add(DeviceFunction(name: newFunctionName, isEnabled: false));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaShadedWhite,
      appBar: AppBar(
        backgroundColor: MainTheme.luminaShadedWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.device.deviceName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black54),
            onPressed: () async {
              // final result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EditDevicePage(device: widget.device),
              //   ),
              // );
              
              // // Handle results from edit page
              // if (result != null) {
              //   if (result is Map && result['action'] == 'delete') {
              //     // Handle deletion (pass the result up to parent)
              //     Navigator.of(context).pop(result);
              //   } else if (result is DeviceItem) {
              //     // Return updated device to parent
              //     Navigator.of(context).pop({'action': 'update', 'device': result});
              //   }
              // }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Device info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MainTheme.luminaBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.device.deviceName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Functions list
              Expanded(
                child: ListView.builder(
                  itemCount: functions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E3A4D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          functions[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit/delete button
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white70,
                                size: 20,
                              ),
                              onPressed: () => _showDeleteFunctionDialog(context, index),
                            ),
                            // Toggle switch
                            Switch(
                              value: functions[index].isEnabled,
                              onChanged: (value) {
                                setState(() {
                                  functions[index] = DeviceFunction(
                                    name: functions[index].name,
                                    isEnabled: value,
                                  );
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: MainTheme.luminaLightGreen,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Add function button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, color: Colors.black54),
                  label: const Text(
                    'Add Function',
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _addNewFunction,
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

// Class to represent a device function
class DeviceFunction {
  final String name;
  final bool isEnabled;

  DeviceFunction({
    required this.name,
    required this.isEnabled,
  });
}