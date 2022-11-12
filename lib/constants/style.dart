import 'package:flutter/material.dart';

//light colors
Color light = const Color(0xFFFFFFFF);
// Color lightTextColor = const Color(0xFF1B1917);
// Color lightIconColor = const Color(0xFF1B1917);

//dark colors
Color dark = const Color(0xFF030F23);
// Color darkTextColor = const Color(0xFF1B1917);
// Color darkIconColor = const Color(0xFF1B1917);

//transparent
// Color transparent = Colors.transparent;

ThemeData darkTheme = ThemeData(
  colorSchemeSeed: Colors.red,
  brightness: Brightness.dark,
  primaryColor: Colors.amber,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    disabledColor: Colors.grey,
  ),
);

ThemeData lightTheme = ThemeData(
  colorSchemeSeed: Colors.pink,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    disabledColor: Colors.grey,
  ),
);
