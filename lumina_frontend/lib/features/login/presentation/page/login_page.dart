// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
//import 'package:lumina_frontend/features/home/presentation/page/home_page.dart';
import 'package:lumina_frontend/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:lumina_frontend/routes.dart';
import 'package:lumina_frontend/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/core/utils/sockets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

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
                    _signIn();
                  },
                  style: MainTheme.luminaLightButton,
                  child: Text(
                    'Log In',
                    style: MainTheme.h3Black,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account? ", style: MainTheme.smallPrint),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.register);
                        },
                        child: Text("Create One", style: MainTheme.linkText)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    final socket = Provider.of<Sockets>(context, listen: false);

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        Routes.setUid(user.uid);
        Provider.of<homeProvider>(context, listen: false).setUid(user.uid);
        await Provider.of<homeProvider>(context, listen: false).fetchData();
        String accountType =
            Provider.of<homeProvider>(context, listen: false).accountType;
        Routes.setUserRole(accountType);
        if (accountType == "manager") {
          Navbar.setUserRole(accountType);
        } else {
          Navbar.setUserRole("resident");
        }
        socket.energyGraphUpdate();
        Navigator.pushNamed(context, Routes.home);
      } else {
        _showSnackBar(
            "Login Unsuccessful: Incorrect password or account does not exist.");
      }
    } on FirebaseAuthException catch (e) {
      // Catching FirebaseAuth errors and showing a general message
      print("FirebaseAuthException: ${e.code}");
      _showSnackBar(
          "Login Unsuccessful: Incorrect password or account does not exist.");
    } catch (e) {
      // Handling unexpected errors
      print("Login failed: $e");
      _showSnackBar("An unexpected error occurred. Please try again.");
    }
  }

// Function to show a Snackbar
  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
