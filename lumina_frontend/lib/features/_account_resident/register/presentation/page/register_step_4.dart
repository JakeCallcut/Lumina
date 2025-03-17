import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/resident_login_details.dart';
import 'package:lumina_frontend/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:lumina_frontend/model/models.dart' as models;
import 'package:lumina_frontend/services/integration_Funcs.dart';

class ResidentRegisterStep4 extends StatefulWidget {
  final LoginDetails loginDetails;
  
  const ResidentRegisterStep4({super.key, required this.loginDetails});

  @override
  _RegisterStep4State createState() => _RegisterStep4State();
}

class _RegisterStep4State extends State<ResidentRegisterStep4> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _inviteCodeController = TextEditingController();
  final FocusNode _inviteCodeFocusNode = FocusNode();
  var instance = Integration();

  @override
  void dispose() {
    _inviteCodeController.dispose();
    _inviteCodeFocusNode.dispose();
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
                Image.asset('assets/images/register_progress/progress_4.png'),
                Image.asset('assets/images/text_logo.png'),
                const SizedBox(height: 20),
                Text('Enter the invite code given by your home manager', style: MainTheme.h2White, textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                TextField(
                  controller: _inviteCodeController,
                  focusNode: _inviteCodeFocusNode,
                  keyboardType: TextInputType.text,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Invite Code"),
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
  void finishRegistration() {
    if (_inviteCodeController.text.isNotEmpty) {
      widget.loginDetails.inviteCode = _inviteCodeController.text; // Update inviteCode
      _signUp();
      
      Navigator.pushNamed(context, Routes.home);
    }
  }

  void _signUp() async {
    String email = widget.loginDetails.email;
    String password = widget.loginDetails.password;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("Account is successfully created");
      widget.loginDetails.userID = user.uid;   // This part fetches the userID 
      registerUser(widget.loginDetails);
      Navigator.pushNamed(context, Routes.home);

      print(widget.loginDetails.firstname);
    }
  }

  void registerUser(LoginDetails login) async {

    // String houseCode = Provider.of<HCProvider>(context, listen: false).homeCode;
    List<models.HouseCode> HC = await instance.getHouseCodesbyInvite(login.inviteCode);
    print("HC 0: ${HC[0].id} Hc 1: ${HC[1].id}");
    if (HC[0].householdId == ""){
      models.User user0 = models.User("", login.userID, login.firstname, login.lastname, login.phoneNumber, HC[0].id, false);
      try {
      await instance.addUser(user0);
    } catch (e) {
      // Handle error
      print("Error adding user: $e");
    }
    } else if (HC[1].householdId == ""){
      models.User user1 = models.User("", login.userID, login.firstname, login.lastname, login.phoneNumber, HC[1].id, false);
      try {
      await instance.addUser(user1);
    } catch (e) {
      // Handle error
      print("Error adding user: $e");
    }
    } else {
      print("Error: No available housecodes");
    }
  }
}
