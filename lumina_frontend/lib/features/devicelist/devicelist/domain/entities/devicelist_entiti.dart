import 'package:flutter/material.dart';
// Each device has a name, type, location, image and a state
class DeviceItem {
  //A device's name is defined by the user
  final String name;
  //A device's type is selected from a list of types by the user
  final String species;
  //A device's room is selected from a list of rooms
  //The rooms are not dispplayed on the device list page
  final String room;
  //Icons stand in for images currently as easy to work with
  final IconData icon;
  //Each device is either on or off, dictated by the switch in the device list
  final bool activity;

  DeviceItem({
    //All devices must have each of these components
    required this.name,
    required this.species,
    required this.room,
    required this.icon,
    required this.activity,
  });
}