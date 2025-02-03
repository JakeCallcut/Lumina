import 'package:flutter/material.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/features/settings/presentation/widget/theme_switch.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ThemeSwitch(onChanged: (bool value) {}),
            Navbar(selectedPage: NavPage.config),
          ],
        ),
      ),
    );
  }

}