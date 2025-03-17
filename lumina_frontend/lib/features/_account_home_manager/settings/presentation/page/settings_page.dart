import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/features/_account_home_manager/settings/presentation/widget/setting_tile.dart';
import 'package:lumina_frontend/features/_account_home_manager/settings/presentation/widget/theme_switch.dart';
import 'package:lumina_frontend/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart' as models;




class ManagerSettingsPage extends StatelessWidget {
  const ManagerSettingsPage({super.key});


  Future<void> _deleteUserAccount(BuildContext context) async {
    var instance = Integration();

    User? user = FirebaseAuth.instance.currentUser;
    String loginId = user!.uid;
    models.User user_db = await instance.getUserByLogin(loginId);
    String user_db_id = user_db.id; // get the user id from the database



    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        
        Navigator.pushNamed(context, Routes.landing);
        
        // delete the user from the database and firebase auth
        await user.delete();
        instance.deleteUser(user_db_id);


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account deleted successfully.")),
        );
        // Navigate to login or onboarding screen after deletion  
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No user is currently signed in.")),
        );
      }
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please re-authenticate to delete your account.")),
        );
        // You can call re-authentication logic here if needed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error deleting account: ${e.toString()}")),
        );
      }
    }
  }

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
                  onTap: () => _deleteUserAccount(context)
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
