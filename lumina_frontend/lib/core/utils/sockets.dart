import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart' as models;

class Sockets with ChangeNotifier{
  Socket? socket;
  // ---------------------------------------
  // This section makes this call as singleton, meaning only one instance can exist at one time
  static final Sockets _instance = Sockets._internal(); 

  factory Sockets() {
    return _instance;
  }
  Sockets._internal();
  // End of singleton section
  // ---------------------------------------

  StreamController<Map<String, int>> controller = StreamController<Map<String, int>>.broadcast(); //makes a controller for a stream

  Future<void> initSocket() async { //initialises the socket connection
    socket = io(
      'https://67fe-82-132-223-107.ngrok-free.app', // Use secure WebSocket with port
      OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
    );

    socket?.onAny((event, data) { //this gets emits from the server and sends them out throughout the system using the stream
      controller.add({event: data});
    });

    await socket?.connect(); // ensure it connects before continuing
  }

  void changeState(String item, int state) { //when the state is changed in an object
    socket?.emit(item, state); //sends it to the server
  }

  void input(String name) { 
    socket?.emit('input', name);
  }

  void energyGraphUpdate() async {
    var instance = Integration();

    User? user = FirebaseAuth.instance.currentUser;
    String loginId = user!.uid;
    models.User user_db = await instance.getUserByLogin(loginId);
    models.HouseCode house_db = await instance.getHouseCodeById(user_db.houseCodeId);
    models.EnergyUsage energy_db = await instance.getEnergyUsageByHouseId(house_db.householdId);
    String docName = energy_db.id;

    socket?.emit("fetchDoc", docName); //sends it to the server
  }

  @override
  void dispose() { //gets rid of all connections
    super.dispose();
    controller.close();
    socket?.dispose();
  }
}