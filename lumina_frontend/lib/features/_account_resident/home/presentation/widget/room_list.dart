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
  int? selectedIndex; //variable to track the currently selected room
  List<Room> rooms = [];
  var instance = Integration();

  @override
  Widget build(BuildContext context) {
    final house = Provider.of<homeProvider>(context, listen: true);
    rooms = house.rooms;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: MainTheme.luminaShadedWhite,
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(10)),
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
                                mainAxisSize: MainAxisSize
                                    .min, // Ensures the dialog wraps its content
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
          height: 50.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
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
        ),
      ],
    );
  }
}
