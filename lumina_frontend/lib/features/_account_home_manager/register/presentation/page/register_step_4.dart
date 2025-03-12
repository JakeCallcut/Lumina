import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/manager_login_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumina_frontend/routes.dart';

class ManagerRegisterStep4 extends StatefulWidget {
  String accountType = '';

  ManagerRegisterStep4({Key? key, required this.accountType}) : super(key: key);
  @override
  _RegisterStep4State createState() => _RegisterStep4State();
}

class _RegisterStep4State extends State<ManagerRegisterStep4> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late final String _accountType;

  @override
  void initState() {
    super.initState();
    _accountType = widget.accountType;
  }

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
                Image.asset('assets/images/register_progress/progress_4.png'),
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
                    continueRegistration();
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

  void continueRegistration() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // Validate email format
    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email address.")),
      );
      return;
    }

v2-database-intergration
    if (!_isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password must be longer than 5 characters.")),
      );
      return;
    }

    try {
      final List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (signInMethods.isNotEmpty) {
        // Email already exists, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Email already exists. Please use a different email.")),
        );
        return; // Stop registration process
      }

    // Email does not exist, proceed with registration
    ManagerLoginDetails _loginDetails = ManagerLoginDetails(email, password, false, '', '', '', '', '');
if (_accountType == 'manager') {

        _loginDetails.isManager = true;

      } else if (_accountType == 'resident') {

        _loginDetails.isManager = false;

      }
      Navigator.pushNamed(context, Routes.register5, arguments: _loginDetails);
    } catch (e) {
      print("Error checking email existence: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }

  bool _isValidPassword(String password) {
    if (password.length < 5) {
      return false;
    }
    return true;
  }

// Function to validate email format
  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") // Basic email pattern
        .hasMatch(email);
  }
}
