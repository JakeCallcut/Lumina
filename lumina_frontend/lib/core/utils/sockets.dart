import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
      'wss://192.168.140.94:8080', //change this on day :(
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

  @override
  void dispose() { //gets rid of all connections
    super.dispose();
    controller.close();
    socket?.dispose();
  }
}