import 'package:flutter/material.dart';

class MainTheme {

  //Main Colours
  static Color luminaBlue = const Color(0xFF334E58);
  static Color luminaLightGreen = const Color(0xFFBBDBB4);
  static Color luminaLightGrey = const Color(0xFFC9C9C9);
  static Color luminaDarkGrey = const Color(0xFF6C6C6C);

  //Status Colours
  static Color luminaRed = const Color(0xFFEB3526);
  static Color luminaYellow = const Color(0xFFFFC35A);
  static Color luminaGreen = const Color(0xFF409A29);

  //Font configs
  static TextStyle h1 = const TextStyle(
    fontSize: 24,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    color: Colors.black,
    decoration: TextDecoration.none
  );

  static TextStyle h2 = const TextStyle(
    fontSize: 18,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    color: Colors.black,
    decoration: TextDecoration.none
  );
}