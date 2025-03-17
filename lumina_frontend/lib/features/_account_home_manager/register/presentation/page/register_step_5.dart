import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/manager_login_details.dart';
import 'package:lumina_frontend/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:lumina_frontend/model/models.dart' as models;
import 'package:provider/provider.dart';
import 'package:lumina_frontend/providers/providers.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';

class ManagerRegisterStep5 extends StatefulWidget {
  final ManagerLoginDetails ManagerloginDetails;

  const ManagerRegisterStep5({super.key, required this.ManagerloginDetails});
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
  var instance = Integration();

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
                Image.asset('assets/images/register_progress/progress_5.png'),
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
    widget.ManagerloginDetails.firstname = _firstNameController.text;
    widget.ManagerloginDetails.lastname = _lastNameController.text;
    String phoneNumber = _phoneController.text;

    if (!_isValidPhone(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid UK phone number.")),
      );
      return;
    }else{
      widget.ManagerloginDetails.phoneNumber = phoneNumber;
    }

    _signUp();
    Navigator.pushNamed(context, Routes.home);
  }

  bool _isValidPhone(String phoneNumber) {
    return RegExp(
           r'^(?:\+44|0)7\d{3}[\s.-]?\d{6}$')
        .hasMatch(phoneNumber);
  }

  void _signUp() async {
    String email = widget.ManagerloginDetails.email;
    String password = widget.ManagerloginDetails.password;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("Account is successfully created");
      widget.ManagerloginDetails.userID = user.uid;   // This part fetches the userID 
      // print(widget.ManagerloginDetails.userID);
      registerUser(widget.ManagerloginDetails.userID);
      Navigator.pushNamed(context, Routes.home);

      print(widget.ManagerloginDetails.firstname);
    }
  }

  void registerUser(String loginID) async {

    String tLHName = Provider.of<HCProvider>(context, listen: false).managerHomeCode;
    models.TopLevelHome TLH = await instance.getTopLevelHomebyName(tLHName);
    models.User user = models.User("", loginID, _firstNameController.text, _lastNameController.text, _phoneController.text, TLH.id, false);

    try {
      await instance.addUser(user);
    } catch (e) {
      // Handle error
      print("Error adding user: $e");
    }
  }
}
