import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/login_details.dart';
import 'package:lumina_frontend/routes.dart';

class RegisterStep2 extends StatefulWidget {
  final LoginDetails loginDetails; 

  const RegisterStep2({Key? key, required this.loginDetails}) : super(key: key);
  
  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  String _accountType = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can access the login details with widget.loginDetails
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
                Image.asset('assets/images/register_progress/progress_2.png'),
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
                    continueRegistration();
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
                    Text("Already have an account? ", style: MainTheme.smallPrint),
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

  void continueRegistration() {
    if (_accountType == 'manager') {
      widget.loginDetails.isManager = true;
    } else if (_accountType == 'resident') {
      widget.loginDetails.isManager = false;
    }

    Navigator.pushNamed(context, Routes.register3, arguments: widget.loginDetails);
  }
}
