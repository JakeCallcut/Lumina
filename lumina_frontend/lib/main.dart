import 'package:flutter/material.dart';
import 'package:lumina_frontend/features/home/presentation/page/home_page.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumina',
      initialRoute: Routes.home,
      onGenerateRoute: Routes.generateRoute,
      //theme: MainTheme.data(),
    );
  }
}