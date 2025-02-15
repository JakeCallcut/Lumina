import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/features/settings/presentation/widget/setting_tile.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/logo64.png'),
                      SizedBox(width: 10),
                      Text('Settings', style: MainTheme.h2Black),
                    ],
                  ),
                  ThemeSwitch(onChanged: (bool value) {}),
                ],
              ),
            ),
            Column(
              children: [
                SettingTile(
                  title: "Edit Address",
                  subtitle: "11/15 Kingisher Street",
                  icon: Icon(
                    Icons.location_on,
                    color: MainTheme.luminaWhite,
                  ),
                  addSwitch: false,
                ),
                SettingTile(
                  title: "Edit Time Zone",
                  subtitle: "British Summer Time (London)",
                  icon: Icon(
                    Icons.map_outlined,
                    color: MainTheme.luminaWhite,
                  ),
                  addSwitch: false,
                ),
                SettingTile(
                  title: "Measurement Units",
                  subtitle: "",
                  icon: Icon(
                    Icons.miscellaneous_services,
                    color: MainTheme.luminaWhite,
                  ),
                  addSwitch: false,
                ),
                SettingTile(
                  title: "Notifications",
                  subtitle: "",
                  icon: Icon(
                    Icons.notifications,
                    color: MainTheme.luminaWhite,
                  ),
                  addSwitch: true,
                ),
                SettingTile(
                  title: "Advanced View",
                  subtitle: "",
                  icon: Icon(
                    Icons.verified_user,
                    color: MainTheme.luminaWhite,
                  ),
                  addSwitch: true,
                ),
                SettingTile(
                  title: "Set Budgets",
                  subtitle: "",
                  icon: Icon(
                    Icons.money_outlined,
                    color: MainTheme.luminaWhite,
                  ),
                  addSwitch: false,
                ),
              ],
            ),
            Navbar(selectedPage: NavPage.config),
          ],
        ),
      ),
    );
  }
}
