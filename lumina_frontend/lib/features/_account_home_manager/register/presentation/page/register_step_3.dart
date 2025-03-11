import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

class ManagerRegisterStep3 extends StatefulWidget {
  @override
  _RegisterStep3State createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<ManagerRegisterStep3> {
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _settingsController = TextEditingController();
  final FocusNode _detailsFocusNode = FocusNode();
  final FocusNode _settingsFocusNode = FocusNode();

  @override
  void dispose() {
    _detailsController.dispose();
    _settingsController.dispose();
    _detailsFocusNode.dispose();
    _settingsFocusNode.dispose();
    super.dispose();
  }

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
                Image.asset('assets/images/register_progress/progress_3.png'),
                Image.asset('assets/images/text_logo.png'),
                const SizedBox(height: 20),
                Text('Add your Households', style: MainTheme.h2White),
                const SizedBox(height: 20),
                TextField(
                  controller: _detailsController,
                  focusNode: _detailsFocusNode,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Address or Num"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 16),
                // Phone Number Field
                TextField(
                  controller: _settingsController, 
                  focusNode: _settingsFocusNode, 
                  keyboardType: TextInputType.phone,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Invite Code"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {      
                  },
                  style: MainTheme.luminaLightButton,
                  child: Text(
                    'Add home',
                    style: MainTheme.h3Black,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register4);
                  },
                  style: MainTheme.luminaLightButton,
                  child: Text(
                    'Continue',
                    style: MainTheme.h3Black,
                  ),
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
}
