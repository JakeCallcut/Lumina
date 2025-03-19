import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();

  RoomList({super.key});
}

class _RoomListState extends State<RoomList> {
  List<Room> rooms = [];
  int? selectedIndex; // Variable to track the currently selected room
  var instance = Integration();

  @override
  void initState() {
    super.initState();
    // Set the default selected index to 0 if there are rooms
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final house = Provider.of<homeProvider>(context, listen: false);
      if (house.rooms.isNotEmpty) {
        setState(() {
          selectedIndex = 0;
          house.setRoom(house.rooms[0]); // Automatically select the first room
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final house = Provider.of<homeProvider>(context, listen: true);
    rooms = house.rooms;

    // Ensure selectedIndex is valid
    if (selectedIndex == null && rooms.isNotEmpty) {
      selectedIndex = 0;
      house.setRoom(rooms[0]); // Automatically select the first room
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: MainTheme.luminaShadedWhite,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Rooms",
                  style: MainTheme.h1Black,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MainTheme.luminaLightGreen,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      TextEditingController roomNameController =
                          TextEditingController();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: roomNameController,
                                    decoration: const InputDecoration(
                                      labelText: "Room Name",
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () async {
                                      String roomName = roomNameController.text;
                                      Room place = Room("", roomName);
                                      await instance.addRoom(
                                          place,
                                          house.houseCode.topHouseId,
                                          house.houseCode.householdId);
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      List<Room> updatedRooms =
                                          await instance.getRooms(
                                              house.houseCode.topHouseId,
                                              house.houseCode.householdId);
                                      setState(() {
                                        rooms = updatedRooms;
                                        selectedIndex = 0; // Reset to the first room
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Add Room"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: MainTheme.luminaShadedWhite,
          height: 50.0, // Ensure this height is sufficient for the content
          child: rooms.isEmpty
              ? Center(
                  child: Text("No rooms found", style: MainTheme.h4Black),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        house.setRoom(rooms[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? MainTheme.luminaBlue
                              : MainTheme.luminaLightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          rooms[index].name,
                          style: selectedIndex == index
                              ? MainTheme.h4White
                              : MainTheme.h4Black,
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}
