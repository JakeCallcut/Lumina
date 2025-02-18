// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/services/create_Database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  //var instance = Integration();
  var instanceCreate = Create();
  //instance.setTestData();
  //instance.addTestData();
  //instance.testTopLevel();
  //instance.setTestDataSubCollection();
  //instanceCreate.createTopLevelHome();
  //instanceCreate.createHomeowner();
  //instanceCreate.createHousehold();
  //instanceCreate.createResident();
  //instanceCreate.createRooms();
  instanceCreate.createEnergy();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumina',
      initialRoute: Routes.landing,
      onGenerateRoute: Routes.generateRoute,
      //theme: MainTheme.data(),
    );
  }
}