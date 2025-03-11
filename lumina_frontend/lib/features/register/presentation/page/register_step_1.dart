import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/features/user_auth/login_details.dart';

class RegisterStep1 extends StatefulWidget {

  @override
  _RegisterStep1State createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  String _accountType = '';

  @override
  void dispose() {
    super.dispose();
  }

  // void _continueRegistration() {
  //   // Set the role globally
  //   Routes.setUserRole(_accountType);
  //   Navbar.setUserRole(_accountType);

  //   // Navigate to the next step
  //   Navigator.pushNamed(context, Routes.register2);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaBlue,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/register_progress/progress_1.png'),
                Image.asset('assets/images/text_logo.png'),
                const SizedBox(height: 20),
                Text('Select Your Account Type', style: MainTheme.h2White),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 'manager',
                          groupValue: _accountType,
                          onChanged: (value) {
                            setState(() {
                              _accountType = value.toString();
                              //_continueRegistration();
                            });
                          },
                          fillColor: WidgetStateProperty.all(Colors.white),
                        ),
                        Text('Home Manager', style: MainTheme.h4White),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 'resident',
                          groupValue: _accountType,
                          onChanged: (value) {
                            setState(() {
                              _accountType = value.toString();
                            });
                          },
                          fillColor: WidgetStateProperty.all(Colors.white),
                        ),
                        Text('Resident', style: MainTheme.h4White),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    beginRegistration();
                    //Navigator.pushNamed(context, Routes.register3);
                  },
                  style: MainTheme.luminaLightButton,
                  child: Text('Continue', style: MainTheme.h3Black,),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 300,
                    child: Text(
                      "By creating an account you agree with our Terms of Service, Privacy Policy, and our default Notification Settings.",
                      style: MainTheme.smallerPrint,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: MainTheme.smallPrint),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.login);
                        },
                        child: Text("Log In", style: MainTheme.linkText)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
    void beginRegistration() {

    Routes.setUserRole(_accountType);
    Navbar.setUserRole(_accountType);

    Navigator.pushNamed(context, Routes.register2);
  }
}
