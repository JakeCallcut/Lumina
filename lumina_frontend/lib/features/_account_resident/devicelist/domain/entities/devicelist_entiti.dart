import 'package:flutter/material.dart';
// Each device has a name, type, location, image and a state
class DeviceItem {
  final String deviceID;
  //A device's name is defined by the user
  final String name;
  //A device's type is selected from a list of types by the user
  final String species;
  //Location location
  final String room;
  final String lowerHome;
  final String higherHome;
  //Icons stand in for images currently as easy to work with
  final IconData icon;
  //Each device is either on or off, dictated by the switch in the device list
  final bool activity;
  //subactivities
  final Map<String, bool> subactivities;

  DeviceItem({
    //All devices must have each of these components
    required this.deviceID,
    required this.name,
    required this.species,
    //
    required this.room,
    required this.lowerHome,
    required this.higherHome,
    //
    required this.icon,
    required this.activity,
    required this.subactivities,
  });
}

  final List<DeviceItem> devices = [
    DeviceItem(deviceID: "12", name: 'Philips Iris', species:'Display', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.desktop_windows, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "34", name: 'EduBot', species:'Robot', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.smart_toy, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "56", name: 'Roomba', species:'Cleaning', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.radar, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "78", name: 'TIM Assistant', species:'Robot', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.support_agent, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "91", name: 'Main Light', species:'Lighting', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.light, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "23", name: 'Samsung TV', species:'Display', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.tv, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "45", name: 'Dassault Falcon 7X', species:'Vehicle', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.airplanemode_active, activity:false, subactivities: {"subact1": false, "subact2": false}),
    DeviceItem(deviceID: "67", name: 'Barbarian Mixo 2', species:'Culinary', room: 'Kitchen', lowerHome: 'lower', higherHome: 'higher', icon: Icons.blender, activity:false, subactivities: {"subact1": false, "subact2": false}),
  ];