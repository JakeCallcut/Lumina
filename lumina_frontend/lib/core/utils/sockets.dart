import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart';

class WebSockets {
  int valueLED1 = 0;
  Socket? socket;
  final _ledController = StreamController<int>.broadcast(); // Broadcasting stream

  Stream<int> get ledStream => _ledController.stream;

  void initState() {
    socket = io(
      'ws:192.168.0.9:8080', //change this on day :)
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket?.on('light', (data) {
      if (data != valueLED1) {
        valueLED1 = data;
        _ledController.add(valueLED1);  // Push new value to the stream
      }
    });

    socket?.connect();
  }

  void changeState(String item, int state) {
    valueLED1 = state;
    socket?.emit(item, valueLED1);
  }

  void dispose() {
    _ledController.close(); // Don't forget to close the stream when done
  }
}
