import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/home/presentation/widget/home_dial.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class HomePage extends StatelessWidget {

  //Dummy values
  String _address = "11/15 Kingfisher Street";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("/images/logo64.png"),
            ),
            Text(_address, style: MainTheme.h1,),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeDial(value: 70, maxValue: 100),
            HomeDial(value: 50, maxValue: 100),
            HomeDial(value: 40, maxValue: 100),
          ],
        ),
        Placeholder(),
        Navbar()
      ],
    );
  }
}
