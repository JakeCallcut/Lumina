import 'package:flutter/material.dart';

class MainTheme {
  //Main Colours
  static Color luminaBlue = const Color(0xFF344153);
  static Color luminaLightGreen = const Color(0xFFBBDBB4);
  static Color luminaShadedGreen = const Color(0xFFA7C3A0);
  static Color luminaLightGrey = const Color(0xFFC9C9C9);
  static Color luminaDarkGrey = const Color(0xFF6C6C6C);
  static Color luminaLightBlue = const Color(0xFF3E8AA6);
  static Color luminaShadedWhite = const Color(0xFFEAEAEA);

  //Status Colours
  static Color luminaRed = const Color(0xFFEB3526);
  static Color luminaYellow = const Color(0xFFFFC35A);
  static Color luminaPurple = const Color(0xFF332538);
  static Color luminaGreen = const Color(0xFF409A29);

  //Basic B&W
  static Color luminaBlack = const Color(0xFF000000);
  static Color luminaWhite = const Color(0xFFFFFFFF);

  //Font configs
  static TextStyle h1Black = const TextStyle(
      fontSize: 24,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decoration: TextDecoration.none);

  static TextStyle h2Black = const TextStyle(
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decoration: TextDecoration.none);

  static TextStyle h3Black = const TextStyle(
      fontSize: 14,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decoration: TextDecoration.none);

  static TextStyle h4Black = const TextStyle(
      fontSize: 12,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decoration: TextDecoration.none);

  static TextStyle h1White = const TextStyle(
      fontSize: 24,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decoration: TextDecoration.none);

  static TextStyle h2White = const TextStyle(
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decoration: TextDecoration.none);

  static TextStyle h3White = const TextStyle(
      fontSize: 14,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decoration: TextDecoration.none);

  static TextStyle h4White = const TextStyle(
      fontSize: 12,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decoration: TextDecoration.none);

  static TextStyle smallPrint = TextStyle(
      fontSize: 10,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.grey[400],
      decoration: TextDecoration.none);

  static TextStyle smallerPrint = TextStyle(
      fontSize: 8,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.grey[400],
      decoration: TextDecoration.none);

  static TextStyle linkText = const TextStyle(
      fontSize: 10,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Color(0xFF8AA4A9),
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFF8AA4A9),
    );

  //Button Styles
  static ButtonStyle luminaDarkButton = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(luminaBlue),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10)));

  static ButtonStyle luminaLightButton = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10)));

  //Input Box Styles
  static InputDecoration luminaInputDecoration({required String hintText}) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      );

  //Divider
  static Container divider = Container(
    height: 1,
    width: 130,
    decoration: BoxDecoration(
      color: luminaShadedWhite,
    ),
  );
}
