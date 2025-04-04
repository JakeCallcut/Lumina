import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

//enumerator to keep track of the current page
enum NavPage { home, devices, stats, config }

//variable to keep track of the user role
String userRole = 'resident';

// ignore: must_be_immutable
class Navbar extends StatelessWidget {
  //parameter to contain the current page
  //input the page on which the navbar is being displayed
  NavPage selectedPage;
  bool isBlurred = false;
  Navbar({super.key, required this.selectedPage, this.isBlurred = false});

  static void setUserRole(String role) {
    userRole = role;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: MainTheme.luminaBlue,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navButton(
                  context, (selectedPage == NavPage.home), "home", Routes.home),
              if (userRole == 'resident')
                _navButton(context, (selectedPage == NavPage.devices),
                    "devices", Routes.devices),
              _navButton(context, (selectedPage == NavPage.stats), "stats",
                  Routes.stats),
              _navButton(context, (selectedPage == NavPage.config), "settings",
                  Routes.config),
            ],
          ),
          Visibility(
            visible: isBlurred,
            replacement: const SizedBox.shrink(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(
      BuildContext context, bool isSelected, String page, String route) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
        child: isSelected
            ? Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: MainTheme.luminaLightGreen, shape: BoxShape.circle),
                child: Image.asset("assets/images/nav_bar/${page}_black.png"),
              )
            : Image.asset("assets/images/nav_bar/${page}_white.png"));
  }
}
