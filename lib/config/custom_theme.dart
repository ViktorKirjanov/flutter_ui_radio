import 'package:flutter/material.dart';

class CustomTheme {
  static const Color grey = Color.fromRGBO(231, 233, 234, 1);
  static const Color black = Color.fromRGBO(19, 19, 19, 1);
  static const Color darkBlue = Color.fromRGBO(42, 50, 70, 1);

  static const Color mainColor = Color.fromRGBO(255, 115, 96, 1);
  static const Color secondaryColor = Color.fromRGBO(19, 24, 40, 1);

  static const borderRadius = BorderRadius.all(Radius.circular(12.0));

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBlue,
    textTheme: const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      subtitle1: TextStyle(),
    ).apply(
      bodyColor: grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: grey,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
      iconTheme: IconThemeData(
        color: grey,
      ),
      elevation: .0,
    ),
    iconTheme: const IconThemeData(color: grey),
    colorScheme: const ColorScheme.light().copyWith(
      primary: grey,
      secondary: grey,
    ),
  );

  static BoxShadow shadow = BoxShadow(
    color: Colors.black.withAlpha(50),
    spreadRadius: .5,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );
}
