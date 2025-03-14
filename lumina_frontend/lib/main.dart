// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/services/create_Database.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:lumina_frontend/core/utils/sockets.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';

import 'package:lumina_frontend/providers/providers.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  var instance = Integration();
  //var instanceCreate = Create();
  //instanceCreate.createTopLevelHome();
  //instanceCreate.createHouseCode();
  //instanceCreate.createUser();
  //instanceCreate.createHousehold();
  //instanceCreate.createRooms();
  //instanceCreate.createEnergy();
  //instanceCreate.createDevice();
  //instance.getTestData();
  //instance.getBothResidents();
  //instance.getOwnerId();
  //instance.getHousehold();
  //List<TopLevelHome> TLH = await instance.getallTopLevelHomes();
  //List<HomeOwner> homeowners = await instance.getallHomeOwners();
  //HomeOwner homeowner = homeowners[0];
  //homeowner.firstname = "testname";
  //HomeOwner homeowner = HomeOwner("fSGAFFMD2U1Ezvo4LCnM", "Lumina", "", "", "", "", "", false);
  //bool worked = instance.addHomeowner(homeowner);
  //instance.updateHomeowner(homeowner);
  //HomeOwner docId = await instance.getHomeOwner("Lumina", "Haven");
  
  // Initialize the socket here
  Sockets socket = Sockets();
  await socket.initSocket(); // Make sure the socket is fully initialized
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => homeProvider()..fetchData()),

        ChangeNotifierProvider(create: (_) => socket)

        ChangeNotifierProvider(create: (context) => TLHProvider()),
        // Add more providers here if needed
      ],
      child: MyApp(),
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