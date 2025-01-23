import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: MainTheme.luminaBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navButton(context, true, "home", Routes.home),
          _navButton(context, false, "devices", Routes.devices),
          _navButton(context, false, "stats", Routes.stats),
          _navButton(context, false, "settings", Routes.config),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, bool _isSelected, String _page, String _route) {
    return GestureDetector(
        onTap: () => {
            Navigator.pushNamed(context, _route),
        },
        child: _isSelected
            ? Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: MainTheme.luminaLightGreen, shape: BoxShape.circle),
                child: Image.asset("/images/nav_bar/${_page}_black.png"),
              )
            : Container(
                child: Image.asset("/images/nav_bar/${_page}_white.png"),
              ));
  }
}
