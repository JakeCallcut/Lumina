import 'package:flutter/material.dart';
import 'package:lumina_frontend/features/error/presentation/page/error_page.dart';
import 'package:lumina_frontend/features/home/presentation/page/home_page.dart';
import 'package:lumina_frontend/features/landing/presentation/page/landing_page.dart';
import 'package:lumina_frontend/features/login/presentation/page/login_page.dart';
import 'package:lumina_frontend/features/register/presentation/page/register_step_1.dart';
import 'package:lumina_frontend/features/register/presentation/page/register_step_2.dart';
import 'package:lumina_frontend/features/register/presentation/page/register_step_3.dart';
import 'package:lumina_frontend/features/register/presentation/page/register_step_4.dart';
import 'package:lumina_frontend/features/settings/presentation/page/settings_page.dart';

class NoTransitionPageRoute extends PageRoute {
  final WidgetBuilder builder;
  
  NoTransitionPageRoute({required this.builder}) 
    : super(fullscreenDialog: false);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }
}

class Routes {
  //main routes
  static const String landing = '/';
  static const String home = '/home';
  static const String devices = '/devices';
  static const String stats = '/stats';
  static const String config = '/config';
  
  //edge case routes
  static const String error = '/error';
  static const String login = '/login';
  static const String register = '/register';
  static const String register2 = '/register/2';
  static const String register3 = '/register/3';
  static const String register4 = '/register/4';

  //TODO: undefined routes set to error page for now, change when added
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //main pages
      case landing:
        return NoTransitionPageRoute(builder: (_) => LandingPage());
      case home:
        return NoTransitionPageRoute(builder: (_) => HomePage());
      case devices:
        return NoTransitionPageRoute(builder: (_) => ErrorPage());
      case stats:
        return NoTransitionPageRoute(builder: (_) => ErrorPage());
      case config:
        return NoTransitionPageRoute(builder: (_) => SettingsPage());

      //register and login pages
      case login:
        return NoTransitionPageRoute(builder: (_) => LoginPage());
      case register:
        return NoTransitionPageRoute(builder: (_) => RegisterStep1());
      case register2:
        return NoTransitionPageRoute(builder: (_) => RegisterStep2());
      case register3:
        return NoTransitionPageRoute(builder: (_) => RegisterStep3());
      case register4:
        return NoTransitionPageRoute(builder: (_) => RegisterStep4());


      default:
        return NoTransitionPageRoute(builder: (_) => ErrorPage());
    }
  }
}