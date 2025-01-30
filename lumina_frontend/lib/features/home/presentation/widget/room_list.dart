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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: MainTheme.luminaLightGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Rooms",
                  style: MainTheme.h2Black,
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
          Container(
            color: MainTheme.luminaLightGrey,
            height: 50.0, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.Rooms.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: MainTheme.luminaLightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.Rooms[index],
                    style: MainTheme.h4Black,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
