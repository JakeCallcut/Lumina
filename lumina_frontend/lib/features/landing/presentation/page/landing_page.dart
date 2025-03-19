import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/routes.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('assets/images/logo_raw.png'),
                Image.asset('assets/images/text_logo.png'),
                Text('The Guiding Light of Modern Living',
                    style: MainTheme.h2White),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 310,
                  child: ElevatedButton(
                    style: MainTheme.luminaLightButton,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Text(
                      'Log In',
                      style: MainTheme.h3Black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 310,
                  child: ElevatedButton(
                      style: MainTheme.luminaDarkButton,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: Text(
                        'Create an Account',
                        style: MainTheme.h3White,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
