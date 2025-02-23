import 'package:socket_io_client/socket_io_client.dart';

class WebSockets {
  int valueLED1 = 0;
  Socket? socket;

  void initState() {
    socket = io(
      'http://192.168.0.9:8080',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );

    socket?.on('light', (data) {
      if (data != valueLED1
  ) {
       valueLED1
     = data;
      }
    });

    socket?.connect();

    void changeState(String item, int state) {
     valueLED1
   = state;
      socket?.emit(item, valueLED1
  );
    }
  }
}
