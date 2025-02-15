import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/text_logo.png'),
            Text('Enter Your Details', style: MainTheme.h2White),
            TextField(
              enabled: true,
              readOnly: false,
              decoration: MainTheme.luminaInputDecoration(hintText: "Email"),
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
            ),
            TextField(
              enabled: true,
              readOnly: false,
              obscureText: true,
              decoration: MainTheme.luminaInputDecoration(hintText: "Password"),
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.home);
              },
              style: MainTheme.luminaLightButton,
              child: Text(
                'Go to Home Page',
                style: MainTheme.h3Black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
