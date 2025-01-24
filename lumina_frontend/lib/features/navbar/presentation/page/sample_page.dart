import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
//import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class statsPage extends StatelessWidget {

  String _title = "Usage and Stats";

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
            Text(_title, /*style: MainTheme.h1,*/),
          ],
        ),
      ],
    );
  }
}