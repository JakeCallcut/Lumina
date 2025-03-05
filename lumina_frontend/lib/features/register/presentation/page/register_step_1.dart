import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/login_details.dart';
import 'package:lumina_frontend/routes.dart';

class RegisterStep1 extends StatefulWidget {
  @override
  _RegisterStep1State createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
                Text('Enter Your Details', style: MainTheme.h2White),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Email"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  decoration:
                      MainTheme.luminaInputDecoration(hintText: "Password"),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    beginRegistration();
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

  void beginRegistration() async {

    String email = _emailController.text;
    String password = _passwordController.text;

    

    LoginDetails _loginDetails = LoginDetails(email, password, false, '', '', ''); // Provide empty strings for remaining required fields

    Navigator.pushNamed(context, Routes.register2, arguments: _loginDetails);
  }
}
