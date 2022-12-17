import 'package:flutter/material.dart';

class CustomTheme {
  static const Color grey = Color.fromRGBO(231, 233, 234, 1);
  static const Color black = Color.fromRGBO(19, 19, 19, 1);
  static const Color darkBlue = Color.fromRGBO(42, 50, 70, 1);

  static const Color mainColor = Color.fromRGBO(255, 115, 96, 1);
  static const Color secondaryColor = Color.fromRGBO(19, 24, 40, 1);

  static const mainSpacing = 16.0;

  static const bigBorderRadius = BorderRadius.all(Radius.circular(20.0));
  static const borderRadius = BorderRadius.all(Radius.circular(mainSpacing));
  static const smallBorderRadius = BorderRadius.all(Radius.circular(8.0));

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBlue,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: mainColor),
    textTheme: const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      subtitle1: TextStyle(),
    ).apply(
      bodyColor: grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: grey,
      titleTextStyle: header2,
      iconTheme: const IconThemeData(
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

  static TextStyle header1 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle header2 = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle small = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );

  static TextStyle tiny = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
  );
}
