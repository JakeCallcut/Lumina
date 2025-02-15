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
                        //When the register page is created put it here
                      },
                      child: Text(
                        'Create an Account',
                        style: MainTheme.h3White,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainTheme.divider,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('OR', style: MainTheme.h3White),
                    ),
                    MainTheme.divider,
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: 310,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: MainTheme.luminaLightButton,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google_logo.png',
                              width: 20, height: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Continue with Google',
                            style: MainTheme.h3Black,
                          )
                        ],
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
