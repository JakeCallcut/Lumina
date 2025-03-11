import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

class ManagerRegisterStep2 extends StatefulWidget {

  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<ManagerRegisterStep2> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _blackListController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _blackListFocusNode = FocusNode();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _blackListController.dispose();
    _idFocusNode.dispose();
    _nameFocusNode.dispose();
    _blackListFocusNode.dispose();
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
                Image.asset('assets/images/register_progress/progress_2.png'),
                Image.asset('assets/images/text_logo.png'),
                const SizedBox(height: 20),
                Text('Add your Top Level Home', style: MainTheme.h2White),
                const SizedBox(height: 20),
                TextField(
                  controller: _idController,
                  focusNode: _idFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "ID"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  obscureText: true,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Name"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 16),
                // Phone Number Field
                TextField(
                  controller: _blackListController, 
                  focusNode: _blackListFocusNode, 
                  keyboardType: TextInputType.phone,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Black List"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register3);
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
