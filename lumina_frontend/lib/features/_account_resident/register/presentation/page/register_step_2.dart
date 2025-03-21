import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/user_auth/resident_login_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumina_frontend/routes.dart';

class ResidentRegisterStep2 extends StatefulWidget {
  String accountType = '';

  ResidentRegisterStep2({Key? key, required this.accountType}) : super(key: key);
  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<ResidentRegisterStep2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late final String _accountType;
  double passwordStrength = 0;

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
            child: Form(
              key: _formKey,
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
                  TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      decoration:
                          MainTheme.luminaInputDecoration(hintText: "Password")
                              .copyWith(
                        errorStyle: const TextStyle(
                            color: Colors.red), // Keeps error text consistent
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      onChanged: (value) {
                        _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else {
                          //call function to check password
                          bool result = validatePassword(value);
                          if (result) {
                            // create account event
                            return null;
                          } else {
                            return " Password should contain Capital, small letter & Number & Special";
                          }
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LinearProgressIndicator(
                        value: passwordStrength,
                        backgroundColor: Colors.grey[300],
                        minHeight: 5,
                        color: passwordStrength <= 1 / 4
                            ? Colors.red
                            : passwordStrength == 2 / 4
                                ? Colors.yellow
                                : passwordStrength == 3 / 4
                                    ? Colors.blue
                                    : Colors.green,
                      ),
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: passwordStrength != 1 ? null : () {
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

// Function to validate password length
bool validatePassword(String password) {
    String _password = password.trim();
    if (_password.isEmpty) {
      setState(() {
        passwordStrength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        passwordStrength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        passwordStrength = 2 / 4;
      });
    } else {
      if (RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
          .hasMatch(password)) {
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          passwordStrength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

// Function to validate email format
bool _isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") // Basic email pattern
      .hasMatch(email);
}
}
