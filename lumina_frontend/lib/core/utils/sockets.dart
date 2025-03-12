import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart';

class Sockets {
  int valueLED1 = 0;
  Socket? socket;

  static final Sockets _instance = Sockets._internal();

  factory Sockets() {
    return _instance;
  }
  Sockets._internal();

  StreamController<Map<String, int>> controller = StreamController<Map<String, int>>.broadcast();
  StreamController<Map<String, int>> getController() => controller;

  void initSocket() {
    socket = io(
      'ws:192.168.0.9:8080', //change this on day :)
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket?.onAny((event, data) {
      controller.add({event: data});
    });

    socket?.connect();
  }

  void changeState(String item, int state) {
    valueLED1 = state;
    socket?.emit(item, valueLED1);
  }

  void dispose() {
    controller.close();
    socket?.dispose();
  }
}
