// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/services/create_Database.dart';
import 'firebase_options.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var instance = Integration();
  //var instanceCreate = Create();
  //instanceCreate.createTopLevelHome();
  //instanceCreate.createHomeowner();
  //instanceCreate.createHousehold();
  //instanceCreate.createResident();
  //instanceCreate.createRooms();
  //instanceCreate.createEnergy();
  //instanceCreate.createSecondResident();
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