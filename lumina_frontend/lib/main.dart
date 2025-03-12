// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the socket here
  Sockets socket = Sockets();
  await socket.initSocket(); // Make sure the socket is fully initialized

  runApp(
    ChangeNotifierProvider(
      create: (_) => socket, 
      child: MyApp(), //allows access to socket from anywhere
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Lumina',
        initialRoute: Routes.loading,
        onGenerateRoute: Routes.generateRoute,
        // theme: MainTheme.data(),
      );
  }
}