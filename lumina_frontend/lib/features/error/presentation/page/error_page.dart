import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset('assets/images/logo_raw.png'),
                const SizedBox(height: 20),
                Text(
                  'We\'re sorry, something went wrong',
                  style: MainTheme.h1White,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: MainTheme.luminaLightButton,
                    child: Text(
                      'Go Back',
                      style: MainTheme.h3Black,
                    )),
                    const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.home);
                    },
                    style: MainTheme.luminaDarkButton,
                    child: Text(
                      'Return to Home',
                      style: MainTheme.h3White,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
