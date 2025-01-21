import 'package:flutter/material.dart';
import 'package:lumina_frontend/features/error/presentation/page/error_page.dart';
import 'package:lumina_frontend/features/home/presentation/page/home_page.dart';

class Routes {
  //main routes
  static const String home = '/';
  static const String devices = '/devices';
  static const String stats = '/stats';
  static const String config = '/config';

  //edge case routes
  static const String error = '/error';
  static const String login = '/login';
  static const String register = '/register';

  //TODO: undefined routes set to error page for now, change when added
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //main page
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case devices:
        return MaterialPageRoute(builder: (_) => ErrorPage());
      case stats:
        return MaterialPageRoute(builder: (_) => ErrorPage());
      case config:
        return MaterialPageRoute(builder: (_) => ErrorPage());

      //edge cases
      case login:
        return MaterialPageRoute(builder: (_) => ErrorPage());
      case register:
        return MaterialPageRoute(builder: (_) => ErrorPage());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}
