import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();

  final List<String> Rooms = [
    "Billiards Room",
    "Hall",
    "Lounge",
    "Dining Room",
    "Ballroom",
    "Conservatory",
    "Library",
    "Study",
    "Kitchen",
    "Billiards Room",
    "Hall",
    "Lounge",
    "Dining Room",
    "Ballroom",
    "Conservatory",
    "Library"
  ]; //TODO: change this to a value from the backend
  RoomList({super.key});
}

class _RoomListState extends State<RoomList> {
  int? selectedIndex; //variable to track the currently selected room

  @override
  Widget build(BuildContext context) {
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
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
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
            itemCount: widget.Rooms.length,
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
                    widget.Rooms[index],
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
