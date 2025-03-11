import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/register_login_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumina_frontend/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:lumina_frontend/routes.dart';

class ResidentRegisterStep2 extends StatefulWidget {
  String accountType = '';

  ResidentRegisterStep2({Key? key, required this.accountType}) : super(key: key);
  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<ResidentRegisterStep2> {
  final FirebaseAuthService _auth = FirebaseAuthService();
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

// Future<void> _checkIfEmailExists(String email) async {
//     try {
//       List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
//       if (signInMethods.isNotEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Email already exists. Please use a different email.")),
//         );
//       } else {
//         // Proceed with registration
//         LoginDetails _loginDetails = LoginDetails(email, _passwordController.text, false, '', '', '', '', '');
//         Navigator.pushNamed(context, Routes.register2, arguments: _loginDetails);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred: ${e.toString()}")),
//       );
//     }
//   }
  
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

  try {
    final List<String> signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (signInMethods.isNotEmpty) {
      // Email already exists, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email already exists. Please use a different email.")),
      );
      return; // Stop registration process
    }

    // Email does not exist, proceed with registration
    LoginDetails _loginDetails = LoginDetails(email, password, false, '', '', '', '', '');

    if (_accountType == 'manager') {
    } else if (_accountType == 'resident') {
      _loginDetails.isManager = true;
      _loginDetails.isManager = false;
    }

    Navigator.pushNamed(context, Routes.register3, arguments: _loginDetails);
  } catch (e) {
    print("Error checking email existence: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred. Please try again.")),
    );
  }
}

// Function to validate email format
bool _isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") // Basic email pattern
      .hasMatch(email);
}
}
