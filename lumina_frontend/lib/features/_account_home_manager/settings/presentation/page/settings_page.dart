import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/features/_account_home_manager/settings/presentation/widget/setting_tile.dart';
import 'package:lumina_frontend/features/_account_home_manager/settings/presentation/widget/theme_switch.dart';

class ManagerSettingsPage extends StatelessWidget {
  const ManagerSettingsPage({super.key});

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
                      const SizedBox(width: 10),
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
                  subtitle: "lorem ipsum",
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
                // SettingTile(
                //   title: "Advanced View",
                //   subtitle: "",
                //   icon: Icon(
                //     Icons.verified_user,
                //     color: MainTheme.luminaWhite,
                //   ),
                //   addSwitch: true,
                // ),
                SettingTile(
                  title: "Delete Account",
                  subtitle: "You want to leave us?",
                  icon: Icon(
                    Icons.delete,
                    color: MainTheme.luminaRed,
                  ),
                  addSwitch: false,
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
