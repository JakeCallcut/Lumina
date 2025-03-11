import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/register_login_details.dart';
import 'package:lumina_frontend/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:lumina_frontend/routes.dart';

class ManagerRegisterStep5 extends StatefulWidget {
  final LoginDetails loginDetails;

  const ManagerRegisterStep5({super.key, required this.loginDetails});
  @override
  _RegisterStep5State createState() => _RegisterStep5State();
}

class _RegisterStep5State extends State<ManagerRegisterStep5> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
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
                Image.asset('assets/images/register_progress/progress_1.png'),
                Image.asset('assets/images/text_logo.png'),
                const SizedBox(height: 20),
                Text('Tell us more about you', style: MainTheme.h2White),
                const SizedBox(height: 20),
                // First Name Field
                TextField(
                  controller: _firstNameController, 
                  focusNode: _firstNameFocusNode, 
                  keyboardType: TextInputType.text,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "First Name"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 16),
                // Last Name Field
                TextField(
                  controller: _lastNameController, 
                  focusNode: _lastNameFocusNode, 
                  keyboardType: TextInputType.text,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Last Name"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 16),
                // Phone Number Field
                TextField(
                  controller: _phoneController, 
                  focusNode: _phoneFocusNode, 
                  keyboardType: TextInputType.phone,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Phone Number"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    finishRegistration();
                  },
                  style: MainTheme.luminaLightButton,
                  child: Text(
                    'Finish',
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
  void finishRegistration() {
    widget.loginDetails.firstname = _firstNameController.text;
    widget.loginDetails.lastname = _lastNameController.text;
    widget.loginDetails.phoneNumber = _phoneController.text;
    _signUp();
    Navigator.pushNamed(context, Routes.home);
  }

  void _signUp() async {
    String email = widget.loginDetails.email;
    String password = widget.loginDetails.password;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("Account is successfully created");
      widget.loginDetails.userID = user.uid;   // This part fetches the userID 
      print(widget.loginDetails.userID);
      Navigator.pushNamed(context, Routes.home);

      print(widget.loginDetails);
    }
  }
}
